From: sylvain@demarque.qc.ca
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 18:04:20 -0400
Message-ID: <20091012180420.8r1px9z7ggs8kksc@webmail.demarque.qc.ca>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
	<1255383459.15646.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT4N-0004FJ-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbZJLWFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 18:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbZJLWFG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 18:05:06 -0400
Received: from secure01.megaquebec.net ([199.202.64.88]:39407 "EHLO
	mqplesk1l.megaquebec.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834AbZJLWFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 18:05:05 -0400
Received: (qmail 14667 invoked by uid 48); 12 Oct 2009 18:04:20 -0400
Received: from modemcable009.10-130-66.mc.videotron.ca
	(modemcable009.10-130-66.mc.videotron.ca [66.130.10.9]) by
	webmail.demarque.qc.ca (Horde MIME library) with HTTP; Mon, 12 Oct 2009
	18:04:20 -0400
In-Reply-To: <1255383459.15646.10.camel@localhost>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130086>

Quoting Daniele Segato <daniele.bilug@gmail.com>:

> Il giorno lun, 12/10/2009 alle 01.28 -0400, sylvain@demarque.qc.ca ha
> scritto:
>> localhost / # git init
>
> I don't see the point of using git on the root directory :)
>
> but that made me think that it could actually be a good idea
> for /etc/ :)
> I happen to modify some configuration and then I forgot which one... and
> sometimes updates broke something
>
>
> And that make me think of another question...
>
> is there a way to have a git repo for a subset of directory that match a
> pattern?
>
> for instance...
>
> can I have a git report of $HOME/.* (without . and ..)? (all user
> setting)
>
> Or better: provide a list of directory under $HOME I want to track
>
> Instead of providing the list of directory I want to ignore i would like
> to provide the list of the directory and files I want to track :)
>
> I probably am going out of topic here but I hope you forgive me :)

I am still a Git newbee, but I am using GNU/Linux for a long time now.  
I have just reformatted my disk and installed Gentoo and I have to  
setup all these little things all over again. Since I clean install  
only every couple of years, I often forget some details, etc.

So I am trying something new. I have my "home Git" at "~/.git" and the  
"root Git" at "/root/.git" with the GIT_WORK_TREE at "/". Both have  
"*" in "info/exclude", so I do provide my list of directories and  
files I want to track explicitly by adding them one by one.

My home Git takes care of .bash* .vim* .emacs*, firefox passwords and  
bookmarks, etc. My root git takes care of some "/etc", "/var" configs,  
etc. (That is the reason why I wanted it on "/", because some  
configuration tweaks are done outside of "/etc". Oh, I forgot to  
mention "/usr/src/linux/.config")

My hope is that next time I'll clean install my system, I won't have  
to backup my whole disk and then mount it again to recover configs  
pieces by pieces. I'll just copy my two Git repositories and I'll  
should be OK.

All praise the Git. :-)
