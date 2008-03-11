From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] Make get_git_dir() and 'git rev-parse --git-dir'
 absolute path
Date: Tue, 11 Mar 2008 16:18:08 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111616050.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com>  <20080302103348.GA8929@laptop>  <alpine.LSU.1.00.0803111420080.3873@racer.site> <fcaeb9bf0803110806u43fbd8b8v3ec2adf84fa1cd5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1753961895-1205248688=:3873"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6Fh-0006Kq-Uz
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbYCKPSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbYCKPSE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:18:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:56168 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753369AbYCKPSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:18:03 -0400
Received: (qmail invoked by alias); 11 Mar 2008 15:18:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 11 Mar 2008 16:18:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++wYY6XEW+/RGBoHKNc4o/YoZXlXhi+zGCqCmzq0
	HAf9xvuBK9cjRH
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0803110806u43fbd8b8v3ec2adf84fa1cd5e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76866>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1753961895-1205248688=:3873
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 11 Mar 2008, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 11, 2008 at 8:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Sun, 2 Mar 2008, Nguyễn Thái Ngọc Duy wrote:
> >
> >  > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >
> >  I do not like this change.  It is IMO completely unnecessary, and 
> >  might break assumptions.
> 
> It could. And I tried my best to make sure it did not break anything.

That is contradicting.  I think that whatever you tried, once you let 
rev-parse --git-dir return only absolute paths, you already risked 
breakage.

Besides, I remember that Junio specifically requested that I would _not_ 
do something like that (this was for --show-cdup, but I think it really 
applies here, too).

> While it's not really necessary, it would be IMHO a good change as you 
> would not have to rely on `cwd` anymore (that would mean whether moving 
> cwd by prefix or not would no longer matter).

I do not see the problem.  And therefore I do not see that this patch 
solves anything.

Ciao,
Dscho

--8323584-1753961895-1205248688=:3873--
