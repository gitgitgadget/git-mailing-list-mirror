From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] It doesn't make sense to sink below an unapplied patch
Date: Sun, 16 Sep 2007 23:20:36 +0200
Message-ID: <87veaab93v.fsf@morpheus.local>
References: <20070914002031.GC23330@diana.vm.bytemark.co.uk> <20070914005231.17533.17120.stgit@yoghurt> <9e4733910709131822s3c519a3bj7e42c0ecaa89fb6e@mail.gmail.com> <20070914060456.GA27014@diana.vm.bytemark.co.uk> <9e4733910709140715g3cc3e47fu2eb24eed6d4e2c08@mail.gmail.com> <20070914150609.GA319@diana.vm.bytemark.co.uk> <9e4733910709140918wbe94b5eu6ec326b25b0f3d42@mail.gmail.com> <20070915232252.GA25507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 23:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX1Y6-0000aH-H2
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbXIPVU6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 17:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbXIPVU6
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:20:58 -0400
Received: from main.gmane.org ([80.91.229.2]:56770 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbXIPVU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 17:20:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IX1Xx-0004lk-94
	for git@vger.kernel.org; Sun, 16 Sep 2007 23:20:53 +0200
Received: from c83-253-242-75.bredband.comhem.se ([83.253.242.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 23:20:53 +0200
Received: from davidk by c83-253-242-75.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 23:20:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-242-75.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:kcYaaq6JfexHC26GwXljhb+fIec=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58347>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> Another idea that's been kicked around is to have a general reorder
> command, that spawns an editor and lets you move around (and delete)
> patch names until you're satisfied. (This too would be implemented in
> terms of push and pop of single patches.)

This of course sounds very much like "git rebase -i", but the
semantics would maybe not be identical.

One feature from rebase I'd like to see if this was implemented is the
"squash" option to join two patches.  But it would probably be called
"fold" to keep with stgit terminology.

Another way of doing this editing is to do it interactively,
interacting with the patches directly using a UI, such as an Emacs
editing mode, or a custom text or graphical UI. As you might guess,
I've been thinking a little of an Emacs interface, but nothing has
been written yet.

--=20
David K=C3=A5gedal
