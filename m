From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 10:46:52 -0700
Message-ID: <47E6978C.4040207@zytor.com>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdUIh-0002xr-49
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbYCWRrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbYCWRrS
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:47:18 -0400
Received: from terminus.zytor.com ([198.137.202.10]:49044 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbYCWRrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 13:47:17 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m2NHksLV032702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 10:46:54 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m2NHkr5j031540;
	Sun, 23 Mar 2008 10:46:53 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m2NHkq6O005793;
	Sun, 23 Mar 2008 10:46:53 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <20080323173841.GA24943@mit.edu>
X-Virus-Scanned: ClamAV 0.92.1/6005/Tue Feb 26 14:01:21 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77932>

Theodore Tso wrote:
> On Sun, Mar 23, 2008 at 10:15:48AM -0700, H. Peter Anvin wrote:
>> 2. cg-restore
>>
>>    Cogito separated "reset" and "restore".  This is a syntactic sugar
>>    issue, but having to type "git reset --hard -- path" makes me
>>    nervous, especially since hitting Enter at the wrong time could have
>>    serious and irrevocable consequences.
>>
>>    I also note that this particular use of "git reset" is actually
>>    undocumented, but it seems to work.
> 
> I didn't think "git reset --hard -- <pathame>" was valid, since it's
> not documented in the man page.
> 
> I have the following in my path as "git-revert-file" (which is easier
> to type and less dangerous than typing "git reset --hard -- <path>"):
> 
> #!/bin/sh
> #
> prefix=$(git rev-parse --show-prefix)
> 
> for i in $*
> do
>         git show HEAD:$prefix$i > $i
> done
> 

FWIW, cg-restore is a 131-line shell script, so one can assume it's not 
just doing it for fun.

	-hpa
