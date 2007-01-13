From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 14:31:08 -0500
Message-ID: <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com> <200701131815.27481.alan@chandlerfamily.org.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 20:31:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5ob0-0006Y6-CN
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 20:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbXAMTbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 14:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbXAMTbO
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 14:31:14 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:59526 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422764AbXAMTbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 14:31:14 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id CA28C1FFC02B;
	Sat, 13 Jan 2007 19:31:12 +0000 (UTC)
In-Reply-To: <200701131815.27481.alan@chandlerfamily.org.uk>
To: Alan Chandler <alan@chandlerfamily.org.uk>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36766>


On Jan 13, 2007, at 1:15 PM, Alan Chandler wrote:

> (although that is probably harder than it needs to be - can't I  
> just do
> git add . ?)

Yes.  It sounds very much like you want to simply do "git add . ; git  
commit -a".  But making that the default for "commit -a" would be  
obnoxious for many other people.

I know that fairly often I begin adding a chunk of new code and  
realize the changes I made to the existing code should logically be a  
different commit.  Having "git commit -a" ignore the new files (and  
any new object/log/debug/etc files I haven't added to .gitignore)  
makes things so much simpler.

A more through version ("git commit --everything"?) that also adds  
files would be fine, but don't muck up the existing -a, please.

~~ Brian
