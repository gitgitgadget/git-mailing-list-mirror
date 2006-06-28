From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Wed, 28 Jun 2006 02:53:43 -0700
Message-ID: <7vr71938t4.fsf@assigned-by-dhcp.cox.net>
References: <20060627083508.E912A5BBAB@nox.op5.se>
	<7vpsgu6wba.fsf@assigned-by-dhcp.cox.net> <44A23A38.3090206@op5.se>
	<Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:53:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWk0-0006zz-Cf
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWF1Jxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWF1Jxp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:53:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42157 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030502AbWF1Jxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:53:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628095344.RUMX12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 05:53:44 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 28 Jun 2006 11:21:21 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22792>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Try this:
>
> $ mkdir 5
> $ cd 5
> $ git-init-db
> $ rm .git/config # yes, really.
> $ git abc

Thanks for trying to help, but not really.

: gitster; mkdir 5
: gitster; cd 5
: gitster; git-init-db
defaulting to local storage area
: gitster; rm .git/config
: gitster; ~/git-master/bin/git abc
git: 'abc' is not a git-command

The most commonly used git commands are:
    add            Add files to the index file
    apply          Apply patch on a git index file and a work
...
    tag            Create a tag object signed with GPG
    verify-tag     Check the GPG signature of tag
(use 'git help -a' to get a list of all installed git commands)
: gitster; ~/git-master/bin/git --version
git version 1.4.1.rc1.g8096
: gitster; ls -ld ~/.gitrc ~/.gitconfig ~/.git-config
: gitster; ls -ld ~/.gitrc ~/.gitconfig ~/.git-config
ls: /home/junio/.gitrc: No such file or directory
ls: /home/junio/.gitconfig: No such file or directory
ls: /home/junio/.git-config: No such file or directory
: gitster; : confused...
