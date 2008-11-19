From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
Date: Tue, 18 Nov 2008 17:28:24 -0800 (PST)
Message-ID: <299370.3004.qm@web37902.mail.mud.yahoo.com>
References: <142315.9815.qm@web37908.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bt0-0002iN-Be
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYKSB20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYKSB2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:28:25 -0500
Received: from web37902.mail.mud.yahoo.com ([209.191.91.164]:43387 "HELO
	web37902.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751421AbYKSB2Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 20:28:25 -0500
Received: (qmail 3170 invoked by uid 60001); 19 Nov 2008 01:28:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=bvTzj4lz91sIzO5U/W7BEGuYYnOw+v6ii66HwT9gPZN6Mec4oh+kVevkAR5kvUzYNkn16lq2KamlMj2A+5wEmorZtTqM8YCLEuITKfbaTH8lHqvkjr+Vm1iqicCgQApbuwAjxZ3g4HbMpHsZFuzFLJH78kFRa3oWTyASbEh5Mh0=;
X-YMail-OSG: qYQbHEMVM1l_gIfFvS0Xvre5fZY08ag5Uf4JHXnhgf20dThM83zETmSkaa28.mpScnj6HhaWvstjKdXSsh2XlMfQmrh1rFs7k0YS0e104RZXh_elZJ1VsYBs43ZL9K.kCIyhaVCP.W.nlVrPvU5aziuirQMzLKkPzGuQ4gWvyGw94Pw-
Received: from [76.195.33.70] by web37902.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 17:28:24 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <142315.9815.qm@web37908.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101299>


inuxgit01 is the box I want to make public repository. At my own box, linux12, I ran the command, git push linuxgit01:/pub/git/u-boot.git master

What I did wrong?

Thanks.

--- On Tue, 11/18/08, Gary Yang <garyyang6@yahoo.com> wrote:

> From: Gary Yang <garyyang6@yahoo.com>
> Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
> To: "Shawn O. Pearce" <spearce@spearce.org>
> Cc: git@vger.kernel.org
> Date: Tuesday, November 18, 2008, 5:21 PM
> The command, "git --git-dir=my-git.git init"
> works. But, I got another error.
> 
> http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html
> 
> The document says that, Your "public repository"
> is now ready to accept your changes. Come back to the
> machine you have your private repository. From there, run
> this
>         command:
>  
>             $ git push
> <public-host>:/path/to/my-git.git master
> 
> 
> However, I got "fatal: Not a git repository"
> error. Do you have any idea?
> 
> 
> git push linuxgit01:/pub/git/u-boot.git master
> fatal: Not a git repository
> 
> inuxgit01 is the box I ran the command, "git
> --git-dir=u-boot.git init".
> 
> Thanks,
> 
> 
> Gary
> 
> 
> 
> 
> --- On Tue, 11/18/08, Shawn O. Pearce
> <spearce@spearce.org> wrote:
> 
> > From: Shawn O. Pearce <spearce@spearce.org>
> > Subject: Re: How to make public repository
> GIT_DIR=my-git.git git-init Command not found.
> > To: "Gary Yang" <garyyang6@yahoo.com>
> > Cc: git@vger.kernel.org
> > Date: Tuesday, November 18, 2008, 3:19 PM
> > Gary Yang <garyyang6@yahoo.com> wrote:
> > > Hi,
> > > 
> > > I want to make a public repository. I followed
> the
> > instructions in gitcore-tutorial. I typed
> > "GIT_DIR=my-git.git git init" per
> instruction.
> > But, I got command not found. I do not think this is
> the
> > correct command. How should I do? I use C-Shell.
> > > 
> > >
> >
> http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html
> > > 
> > > %mkdir my-git.git
> > > %GIT_DIR=my-git.git git init
> > > 
> > > GIT_DIR=my-git.git: Command not found.
> > 
> > Instead you can do:
> > 
> >   $ git --git-dir=my-git.git init
> > 
> > The --git-dir option does the same thing that GIT_DIR=
> was
> > doing
> > in a Bourne shell.
> > 
> > -- 
> > Shawn.
> 
> 
>       
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
