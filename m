From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
Date: Tue, 18 Nov 2008 17:35:38 -0800 (PST)
Message-ID: <674246.30132.qm@web37901.mail.mud.yahoo.com>
References: <299370.3004.qm@web37902.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bzz-0004Ko-KB
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYKSBfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYKSBfk
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:35:40 -0500
Received: from web37901.mail.mud.yahoo.com ([209.191.91.163]:25444 "HELO
	web37901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751269AbYKSBfj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 20:35:39 -0500
Received: (qmail 30596 invoked by uid 60001); 19 Nov 2008 01:35:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=bXxQKCn5iAzH6iRj4jlaK3KbUCTApge/MQRVwufvbrr+99JuETbKwXdxNV3kK6EDnRPyUjmQrB6b7KMd34SAQSslNrdZh+TEft1m4ACx5UEo0G/cAl1qkCrIP6BsJn1kc8bR96uUurX2eak8XKYvNF7E5U+cXy0dU6NMUHRFNhM=;
X-YMail-OSG: c1B_P2oVM1lTMxI0kXKv6HIcVyL9AwqmpDYSd_Z56t3eMIkmOoUjhx0UGM2VwBahLdid6pav0KuJrZgdwn6dmirAy7zeUNgLEj0QKVkkz8ggLFLx_T6WzI1U7.g1kvsl.0Adql.69viC4jvD186XFZp8M6YPbJjkAuMo3OjFK_IQuMU-
Received: from [76.195.33.70] by web37901.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 17:35:38 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <299370.3004.qm@web37902.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101301>

Never mind. I figured it out. I need to cd to u-boot.git (my local git repository, the run the command, git push linuxgit01:/pub/git/u-boot.git master.


--- On Tue, 11/18/08, Gary Yang <garyyang6@yahoo.com> wrote:

> From: Gary Yang <garyyang6@yahoo.com>
> Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
> To: "Shawn O. Pearce" <spearce@spearce.org>
> Cc: git@vger.kernel.org
> Date: Tuesday, November 18, 2008, 5:28 PM
> inuxgit01 is the box I want to make public repository. At my
> own box, linux12, I ran the command, git push
> linuxgit01:/pub/git/u-boot.git master
> 
> What I did wrong?
> 
> Thanks.
> 
> --- On Tue, 11/18/08, Gary Yang <garyyang6@yahoo.com>
> wrote:
> 
> > From: Gary Yang <garyyang6@yahoo.com>
> > Subject: Re: How to make public repository
> GIT_DIR=my-git.git git-init Command not found.
> > To: "Shawn O. Pearce"
> <spearce@spearce.org>
> > Cc: git@vger.kernel.org
> > Date: Tuesday, November 18, 2008, 5:21 PM
> > The command, "git --git-dir=my-git.git init"
> > works. But, I got another error.
> > 
> >
> http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html
> > 
> > The document says that, Your "public
> repository"
> > is now ready to accept your changes. Come back to the
> > machine you have your private repository. From there,
> run
> > this
> >         command:
> >  
> >             $ git push
> > <public-host>:/path/to/my-git.git master
> > 
> > 
> > However, I got "fatal: Not a git repository"
> > error. Do you have any idea?
> > 
> > 
> > git push linuxgit01:/pub/git/u-boot.git master
> > fatal: Not a git repository
> > 
> > inuxgit01 is the box I ran the command, "git
> > --git-dir=u-boot.git init".
> > 
> > Thanks,
> > 
> > 
> > Gary
> > 
> > 
> > 
> > 
> > --- On Tue, 11/18/08, Shawn O. Pearce
> > <spearce@spearce.org> wrote:
> > 
> > > From: Shawn O. Pearce <spearce@spearce.org>
> > > Subject: Re: How to make public repository
> > GIT_DIR=my-git.git git-init Command not found.
> > > To: "Gary Yang"
> <garyyang6@yahoo.com>
> > > Cc: git@vger.kernel.org
> > > Date: Tuesday, November 18, 2008, 3:19 PM
> > > Gary Yang <garyyang6@yahoo.com> wrote:
> > > > Hi,
> > > > 
> > > > I want to make a public repository. I
> followed
> > the
> > > instructions in gitcore-tutorial. I typed
> > > "GIT_DIR=my-git.git git init" per
> > instruction.
> > > But, I got command not found. I do not think this
> is
> > the
> > > correct command. How should I do? I use C-Shell.
> > > > 
> > > >
> > >
> >
> http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html
> > > > 
> > > > %mkdir my-git.git
> > > > %GIT_DIR=my-git.git git init
> > > > 
> > > > GIT_DIR=my-git.git: Command not found.
> > > 
> > > Instead you can do:
> > > 
> > >   $ git --git-dir=my-git.git init
> > > 
> > > The --git-dir option does the same thing that
> GIT_DIR=
> > was
> > > doing
> > > in a Bourne shell.
> > > 
> > > -- 
> > > Shawn.
> > 
> > 
> >       
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> 
> 
>       
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
