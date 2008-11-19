From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
Date: Tue, 18 Nov 2008 17:21:32 -0800 (PST)
Message-ID: <142315.9815.qm@web37908.mail.mud.yahoo.com>
References: <20081118231925.GW2932@spearce.org>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bmK-00013A-SJ
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYKSBVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYKSBVd
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:21:33 -0500
Received: from web37908.mail.mud.yahoo.com ([209.191.91.170]:20429 "HELO
	web37908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751035AbYKSBVc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 20:21:32 -0500
Received: (qmail 10159 invoked by uid 60001); 19 Nov 2008 01:21:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=38prYArrvnDFY6Mea/qXDtq7Vip4bxiOJ0QSlE95w/9nlA6DrucCZXX0DWZGUm5ubLSidyPxEl/29S8At9c5SCAPQTjvQVcbYwfMw4auUIQprMsL7KEXeDjDyp+NMcpgI3dpypOldng/eU/5Zj3rzh3PwsmMgjXnp5p0Z//m1E4=;
X-YMail-OSG: 1IAjEGEVM1mBXYoA1cjz5s9YgQxOylbd1Am9Ea6etbFcrRUTnRhAUcrTslBK7O9PA6tMXAYAja05mW4G5HB5rCkK96ESPuc_9W1tfVqoorUm.SS0Bq2RwqbUnGsnMU2uZcurjiNWednAMSYK6gYKXyuuPmvp9F5rcWd5zkkws9VzXMI-
Received: from [76.195.33.70] by web37908.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 17:21:32 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081118231925.GW2932@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101298>



The command, "git --git-dir=my-git.git init" works. But, I got another error.

http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html

The document says that, Your "public repository" is now ready to accept your changes. Come back to the machine you have your private repository. From there, run this
        command:
 
            $ git push <public-host>:/path/to/my-git.git master


However, I got "fatal: Not a git repository" error. Do you have any idea?


git push linuxgit01:/pub/git/u-boot.git master
fatal: Not a git repository

inuxgit01 is the box I ran the command, "git --git-dir=u-boot.git init".

Thanks,


Gary




--- On Tue, 11/18/08, Shawn O. Pearce <spearce@spearce.org> wrote:

> From: Shawn O. Pearce <spearce@spearce.org>
> Subject: Re: How to make public repository GIT_DIR=my-git.git git-init Command not found.
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: git@vger.kernel.org
> Date: Tuesday, November 18, 2008, 3:19 PM
> Gary Yang <garyyang6@yahoo.com> wrote:
> > Hi,
> > 
> > I want to make a public repository. I followed the
> instructions in gitcore-tutorial. I typed
> "GIT_DIR=my-git.git git init" per instruction.
> But, I got command not found. I do not think this is the
> correct command. How should I do? I use C-Shell.
> > 
> >
> http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html
> > 
> > %mkdir my-git.git
> > %GIT_DIR=my-git.git git init
> > 
> > GIT_DIR=my-git.git: Command not found.
> 
> Instead you can do:
> 
>   $ git --git-dir=my-git.git init
> 
> The --git-dir option does the same thing that GIT_DIR= was
> doing
> in a Bourne shell.
> 
> -- 
> Shawn.


      
