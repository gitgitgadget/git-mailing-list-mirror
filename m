From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [PATCH] contrib/workdir: add a simple script to create a
	working directory
Date: Tue, 27 Mar 2007 06:50:18 -0700
Message-ID: <1175003418.6140.7.camel@localhost>
References: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
	 <20070327003033.4226.8413.julian@quantumfyre.co.uk>
	 <1174963350.6018.3.camel@localhost>
	 <Pine.LNX.4.64.0703271356590.1024@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 27 15:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWC4H-0004hX-C8
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 15:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbXC0Nu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 09:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbXC0Nu3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 09:50:29 -0400
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:57623 "EHLO
	smtp-5.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbXC0Nu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 09:50:28 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-5.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2RDoMT9023326;
	Tue, 27 Mar 2007 06:50:22 -0700
Received: from [192.168.1.7] (adsl-75-26-185-14.dsl.scrm01.sbcglobal.net [75.26.185.14])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2RDoMtD020727
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 27 Mar 2007 06:50:22 -0700
In-Reply-To: <Pine.LNX.4.64.0703271356590.1024@reaper.quantumfyre.co.uk>
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.47.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43272>

On Tue, 2007-03-27 at 13:59 +0100, Julian Phillips wrote:
> > Shouldn't this be made to work with bare repositories as well?
> 
> I guess that depends ...
> 
> There's probably no reason that it couldn't, but it wasn't something that 
> I was interested in seeing it do.  I don't have any bare repositories on 
> my development machine, and don't anticipate having any in the future.
> 

Also, the symlinked config file will have core.bare = true, which will
make anything with require_work_tree refuse to run.  (Unless
git-sh-setup's is_bare_repository was made to look for .git first, then
check for core.bare.  But that is probably useless.)

You're right in that there may not be many use cases for this.  Sorry
for the noise.

-Eric
