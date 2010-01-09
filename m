From: Simon Chu <simonchu.web@gmail.com>
Subject: Re: How to push changes from clone back to master
Date: Fri, 8 Jan 2010 21:53:49 -0800
Message-ID: <2394EBAE-BA99-4817-93E3-D5441D6DA46B@gmail.com>
References: <1262986087967-4275010.post@n2.nabble.com> <4B47D52A.1050608@dbservice.com>
Mime-Version: 1.0 (iPod Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 06:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTUGr-0001z3-TP
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 06:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab0AIFx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 00:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098Ab0AIFx2
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 00:53:28 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:58225 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0AIFx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 00:53:27 -0500
Received: by ywh6 with SMTP id 6so20139677ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 21:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=w+71QHo8QkDBQLxk1Iw3/15ACgUis7Q0l/0EYBltPu4=;
        b=cD/WnEcjUH4By1OSdnzj+kM4JUlGsBliAZQ9y2lgDWBc058KgOeY9lEGTXeJYEDLTS
         iGZyW5rb1bSnIjwAigaY+7yP2HKn8286fHPCa+q1h9O+5rbpmXD8O+F870574uJ5DA+1
         fK4TAOlF65pqmiYrR2qX9V+t8sB91OQP+Fcsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=Au7zZKD4PtzBc8ZgCbeu35o5R8lCz+iRk8RHOAw2OU+eQyecZKnsWkrlrhALTIKU3L
         qfXsHWq3tYGbNYQhBuZap/Do4xd8oUGkP0nfdUFxOtu6qu5AMt4gZJgt6e0uAkPR6fFk
         Wtb500+bDaOn6GmausMmtnp5SAjVA19UYp+IM=
Received: by 10.100.192.18 with SMTP id p18mr11708733anf.32.1263016406963;
        Fri, 08 Jan 2010 21:53:26 -0800 (PST)
Received: from ?192.168.7.100? (c-67-169-108-246.hsd1.ca.comcast.net [67.169.108.246])
        by mx.google.com with ESMTPS id 21sm9603071yxe.55.2010.01.08.21.53.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 21:53:25 -0800 (PST)
In-Reply-To: <4B47D52A.1050608@dbservice.com>
X-Mailer: iPod Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136517>

Tomas,

How do I push code to master then, do I do got reset - hard on the  
master??

Simon

On Jan 8, 2010, at 5:00 PM, Tomas Carnecky <tom@dbservice.com> wrote:

> On 1/8/10 10:28 PM, Simon C wrote:
> >
> >
> > I created master branch in git:
> >
> > mkdir git_master;
> > cd git_master
> > git init
> > git add .
> > git commit
> >
> > create a clone
> > git clone . ../git_clone1
> > create newfile
> > git add newfile
> > git commit .
> >
> > then try to propagate changes to master
> > git push
> >
> > it gave me some warning, and subsequent git push says everything  
> is up to
> > date.
> > but I do not see the new file under git_master
>
> If you asked that question in the official IRC channel, the answer  
> would be 'faq non-bare', which would cause the bot to send you a  
> link to this entry in the Git FAQ:
> http://git.or.cz/gitwiki/GitFaq#Whywon.27tIseechangesintheremoterepoafter.22gitpush.22.3F
>
> tom
>
