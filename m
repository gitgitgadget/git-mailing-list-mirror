From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Sat, 23 Feb 2008 20:39:53 +0100
Message-ID: <8763wfwjg6.dlv@maison.homelinux.org>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<m3myptcqji.fsf@localhost.localdomain> <87tzk19wn5.fsf@lysator.liu.se>
	<200802221121.35706.jnareb@gmail.com> <87ir0h9soh.fsf@lysator.liu.se>
	<87d4qpgs9y.dlv@maison.homelinux.org>
	<200802230200.m1N202Y7007392@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, davidk@lysator.liu.se,
	jnareb@gmail.com, julliard@winehq.org, git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:41:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT0F5-00063I-Np
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbYBWTkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbYBWTkJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:40:09 -0500
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr ([84.96.92.124]:37174
	"EHLO neuf-infra-smtp-out-sp604003av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755120AbYBWTkH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:40:07 -0500
Received: from neuf-infra-smtp-out-sp604002av.neufgp.fr ([84.96.92.126])
	by neuf-infra-smtp-out-sp604003av.neufgp.fr with neuf telecom
	id ssHs1Y00H2jakD8031Ho00; Sat, 23 Feb 2008 19:40:04 +0000
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604002av.neufgp.fr with neuf telecom
	id t7fz1Y00n20lBGc0200000; Sat, 23 Feb 2008 20:40:04 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JT0E0-0003g3-65; Sat, 23 Feb 2008 20:39:58 +0100
In-Reply-To: <200802230200.m1N202Y7007392@localhost.localdomain> (Xavier Maillard's message of "Sat\, 23 Feb 2008 03\:00\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74844>

Xavier Maillard <xma@gnu.org> writes:

> Hi,
>
>    Here is a modification with inclusion of git-grep only when the gr=
ep
>    library is available.=20
>
>    +(require 'grep () t)
>
>    +(when (featurep 'grep)
>    +  (defvar git-grep-history nil)
>    +
>    +  (defun git-grep (regexp &optional files dir)
>
> Why not just do something like this ?
>
> (when (require 'grep () t)
>       (defvar ...)
>       (defun git-grep ...))

Because I wanted require to stay on top of the file, but I didn't want
to put the rest of the git-grep stuff there.

(the real reason is because I did not check in the doc for the return
value of require, and so I didn't knew that I could do that, but
still, I believe that my after the fact argument are good.)
--=20
R=C3=A9mi Vanicat
