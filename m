From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el
Date: Wed, 31 Jan 2007 21:53:31 +0100
Message-ID: <87ejpazzn8.fsf@morpheus.local>
References: <87iren2vqx.fsf@morpheus.local> <864pq7839g.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 21:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCMSu-0001x6-Qy
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbXAaUxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbXAaUxz
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:53:55 -0500
Received: from main.gmane.org ([80.91.229.2]:45899 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030575AbXAaUxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:53:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCMSe-0004ql-8e
	for git@vger.kernel.org; Wed, 31 Jan 2007 21:53:44 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:53:44 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:53:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:DQF1eBJkNX9GwEA8f656bdzOVEY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38296>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "David" =3D=3D David K=C3=A5gedal <davidk@lysator.liu.se> writes=
:
>
> David> Here's another version of git-blame.el that automatically trie=
s to
> David> create a sensible list of colors to use for both light and dar=
k
> David> backgrounds.  Plus a few minor fixes.
>
> If this gets traction, this should be what vc-annotate uses on a git =
file.

I only had a very quick glance, but one "problem" is that vc-annotate
assumes that what you want to do is to run an annotate/blame command
and show the output in another buffer.  My solution is a minor-mode
that shows the blame directly in the edit buffer, and I'm not sure how
easy it would be to convince vc that this is what I want.  And I need
a way to turn it off again, and maybe some local key bindings when it
is active.  This all points to the fact that a minor mode is really
the thing to use.  So maybe I should simply rebind C-x v g to
git-blame-mode instead of vc-annotate...

--=20
David K=C3=A5gedal
