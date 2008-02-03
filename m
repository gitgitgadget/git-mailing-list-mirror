From: Remi Vanicat <vanicat@debian.org>
Subject: Re: What about git cp ?
Date: Sun, 03 Feb 2008 19:55:14 +0100
Message-ID: <87hcgplvjh.dlv@maison.homelinux.org>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLk6N-0003Eq-PD
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 20:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbYBCTBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbYBCTBc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 14:01:32 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:36000
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160AbYBCTBb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 14:01:31 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2008 14:01:30 EST
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id kwxV1Y0092VLLWC071B900; Sun, 03 Feb 2008 19:55:18 +0100
Received: from maison.homelinux.org ([80.118.117.236])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id l6vF1Y00C566J2w0C00000; Sun, 03 Feb 2008 19:55:18 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JLjzm-0006ga-NO; Sun, 03 Feb 2008 19:55:14 +0100
In-Reply-To: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> (Francis Moreau's message of "Sun\, 3 Feb 2008 19\:23\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-SA-Exim-Scanned: No (on maison.homelinux.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72393>

"Francis Moreau" <francis.moro@gmail.com> writes:

> Hello,
>
> I'm looking for a something which could be done by a git-cp command.
>
> I'd like to copy a file with its history to a new  file but want to
> keep the old one,

Git don't attach history to a file, but to a content. Just do a:
cp foo bar
git add bar
git commit -m "copying foo to bar"

And it will be done, and when needed, git will be able to know that
this was a copy.

--=20
R=C3=A9mi Vanicat
