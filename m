From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Tue, 7 Dec 2010 21:41:04 +0100
Message-ID: <20101207204104.GE1867@neumann>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
	<20101202091624.GB1771@burratino>
	<20101202091613.6ac8f816@MonteCarlo.grandprix.int>
	<20101202210207.GA4994@burratino> <20101207160747.GD1867@neumann>
	<20101207194923.GD22587@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4Lo-0001NW-Vo
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab0LGUlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 15:41:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:57948 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab0LGUlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 15:41:21 -0500
Received: from localhost6.localdomain6 (p5B13086E.dip0.t-ipconnect.de [91.19.8.110])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MXWgY-1Oti0y2KPe-00VzXB; Tue, 07 Dec 2010 21:41:07 +0100
Content-Disposition: inline
In-Reply-To: <20101207194923.GD22587@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:cDanUgorwtCgYBddAENUwL87J6Lq0rYQJIXFco2d1rq
 0TxMik7xhAEASp3SsyQlM2HiiNCdeAaKeeAvecWYOSIFevfydu
 g3XGaI484q0TSAhGc72oXyhYNQMDB4u6AMOaJKYY/DdxKMcUj5
 bSgBO0sQCWo/BaE6R+S7by6/woIoAhy5/KOEIjfMZ9ZFvWpJdF
 dJyC8gdKzLs4dCD0JU63g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163128>

Hi Jonathan,


On Tue, Dec 07, 2010 at 01:49:23PM -0600, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
> > On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:
>=20
> >> Add a minimal implementation of _get_comp_words_by_ref,
> >> the routine used to work around bash 4.0's COMP_WORDS semantics.
> >>=20
> >> Based on bash-completion 2.x (commit bf763033, 2010-10-26) but
> >> tweaked for simplicity and to allow zsh to at least parse the
> >> code.
> >
> > What is this patch based on?
>=20
> Ah, sorry, applies to d93f4a297 (bash: work around bash 4.0 change in
> COMP_WORDS semantics, 2010-12-02).

In which repo? ;)

I don't have d93f4a297, but I have e0a9590 (Introduce functions from
bash-completion project., 2010-12-01) and c7e75bb (Use the new
functions to get the current cword., 2010-12-01) instead, which were
merged into pu at 0c30752 (Merge branch 'pd/bash-4-completion' into
pu, 2010-12-03).

Hm, waittaminit...  Ah, OK, nevermind, got it.  There was a patch in

  http://article.gmane.org/gmane.comp.version-control.git/162686

I forgot to apply first...  Now I have it all, seems to work so far.


Thanks,
G=E1bor
