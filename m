From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Fri, 28 Sep 2007 10:43:37 +0200
Message-ID: <87ejgjrxhi.fsf@morpheus.local>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 10:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbBSB-0004cp-9Z
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 10:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbXI1IoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2007 04:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbXI1IoA
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 04:44:00 -0400
Received: from main.gmane.org ([80.91.229.2]:42534 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbXI1In7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 04:43:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IbBRs-0000hg-T8
	for git@vger.kernel.org; Fri, 28 Sep 2007 08:43:48 +0000
Received: from c83-253-242-75.bredband.comhem.se ([83.253.242.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 08:43:48 +0000
Received: from davidk by c83-253-242-75.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 08:43:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-242-75.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:JzChRH7ZJanIflrlEmvlyyH5Z8M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59376>

"Kelvie Wong" <kelvie@ieee.org> writes:

> I've tried all of the ones that were supported, the result is the sam=
e
> -- blank files in all three windows.
>
> It is because git mergetool fails to generate these files for whateve=
r
> reason (the filebasename.{REMOTE,LOCAL,BASE}.* files).  I don't know
> why this happens.
>
> As for merge utilities, all I need is something that looks for the
> first <<<<<, and lets me choose which version I want (either top or
> bottom), plain and simple :/  I don't even need/want a gui.

Since you are already using Emacs, let me suggest you use smerge
(together with ediff).

Use M-x smerge-mode and go over the conflicts and select which one you
want with C-c ^ m (for "mine") or C-c ^ o (for "other") or one of the
commands.  Or press C-c ^ E to run a three-window merge.

Or use the last directly by running M-x smerge-ediff.

--=20
David K=C3=A5gedal
