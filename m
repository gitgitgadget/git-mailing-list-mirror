From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] bash: not all 'git bisect' subcommands make sense
	when not bisecting
Date: Mon, 11 Oct 2010 00:12:32 +0200
Message-ID: <20101010221232.GD12529@neumann>
References: <1286746774-7877-1-git-send-email-szeder@ira.uka.de>
	<1286746774-7877-2-git-send-email-szeder@ira.uka.de>
	<AANLkTi==oCKgw86fy6sPiPuKuownsbob3xXiY=hHhYrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 00:13:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5491-0008QY-3l
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 00:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab0JJWMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 18:12:40 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:59105 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0JJWMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 18:12:40 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MAysS-1OxKuD2YB2-00AX4N; Mon, 11 Oct 2010 00:12:34 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi==oCKgw86fy6sPiPuKuownsbob3xXiY=hHhYrQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:X5IJt41W8YWUI+RcKFQ0o1PpMWIKLv89QbSuWZYBLWy
 ZRyRDRCT/hzdh7O61pEBF1myy64vc/HCiSpMWwZLPNWpBGDYYm
 7hFjraBCc4vizKHRqoxYATpPEt1kQoI5A+cjsF8J28R/qGFq2d
 ZS3CK/885vuaT91kqtVmu7EHgH3aUXujo8xFh+Zci432/SH/JM
 0NQphmSd8sgZZnJA/jBsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158724>

Hi,

On Mon, Oct 11, 2010 at 12:05:52AM +0200, Sverre Rabbelier wrote:
> Heya,
>=20
> On Sun, Oct 10, 2010 at 23:39, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> > ... but only 'start' and 'replay'. =A0The other commands will eithe=
r
> > error out or offer to start bisecting for the user.
>=20
> I'm not sure, following the same concept "git rebase" should not offe=
r
> "--continue" if you're not rebasing.

Actually, my patch follows the same concept of 'git rebase', because
that's exactly what the completion function for 'git rebase' does: it
doesn't offer '--continue' (nor '--abort' and '--skip') if you're not
rebasing.

Best,
G=E1bor
