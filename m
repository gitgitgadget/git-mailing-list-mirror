From: Gabriel <g2p.code@gmail.com>
Subject: Re: [PATCH] Make commit, cherry-pick and revert more silent.
Date: Mon, 7 Jan 2008 08:55:09 +0000 (UTC)
Message-ID: <flspdc$4aa$1@ger.gmane.org>
References: <1199634201-26013-1-git-send-email-g2p.code@gmail.com>
	<7vir2636tq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 10:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBnqV-0003iM-0Q
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 10:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbYAGJAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 04:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYAGJAH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 04:00:07 -0500
Received: from main.gmane.org ([80.91.229.2]:46940 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbYAGJAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 04:00:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JBnpy-0002CI-JH
	for git@vger.kernel.org; Mon, 07 Jan 2008 09:00:02 +0000
Received: from dhcp26-112.enst.fr ([137.194.26.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 09:00:02 +0000
Received: from g2p.code by dhcp26-112.enst.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 09:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp26-112.enst.fr
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69772>

Le Sun, 06 Jan 2008 14:52:33 -0800, Junio C Hamano a =C3=A9crit=C2=A0:

> So a more convincing presentation would be:
> ...
Will split.

> After I wrote all that, I realized that the patch is not acceptable a=
s
> is.
>=20
> Why?
>=20
> This makes a successful cherry-pick way too silent.  With your patch,=
 we
> will see:
>=20
>  * "Auto-merged ..." messages that shows what paths are affected
>    by the cherry-pick/revert (which I do not think we would want to
>    squelch),
>=20
>  * "Finished one cherry-pick."
>=20
> But we will lose the "Created commit ...: <msg>" and "<num> files
> changed..."  summary, neither of which we would want to lose.

I'll have a look.
This seems to require refactoring the interface between cherry-pick/
revert and commit.

> Also sign your patch (see Documentation/SubmittingPatches), please, w=
hen
> you try the second round.
>=20
> Thanks.

Thanks, I appreciate the review.
