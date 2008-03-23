From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 11:58:24 -0700
Message-ID: <47E6A850.5060308@zytor.com>
References: <47E69044.3000207@zytor.com> <7vzlsp5ly8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVPq-0001Jb-Gj
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 19:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbYCWS6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbYCWS6m
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 14:58:42 -0400
Received: from terminus.zytor.com ([198.137.202.10]:52968 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbYCWS6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 14:58:42 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m2NIwR09015086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 11:58:27 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m2NIwQ35031837;
	Sun, 23 Mar 2008 11:58:26 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m2NIwOfH006460;
	Sun, 23 Mar 2008 11:58:26 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7vzlsp5ly8.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.92.1/6005/Tue Feb 26 14:01:21 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77941>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>    Native git doesn't have any equivalent, other than:
>>
>>    git clone -n .... tmp
>>    mv tmp/.git .
>>    rm -rf tmp
>>    git checkout HEAD
> 
> Or
> 
> 	git init
>         git add remote -f .....
> 
>> 2. cg-restore
>>
>>    Cogito separated "reset" and "restore".  This is a syntactic sugar
>>    issue, but having to type "git reset --hard -- path" makes me
>>    nervous, especially since hitting Enter at the wrong time could have
>>    serious and irrevocable consequences.
> 
> Why --hard?

To make it actually change the file in the working directory (equivalent 
to the -f option in cg-restore.)

	-hpa
