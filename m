From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 19 Feb 2008 00:32:36 +0100
Message-ID: <200802190032.36712.jnareb@gmail.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802152216.42533.jnareb@gmail.com> <C8D96592-DD9C-47D3-93AB-3F74719F4D46@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Junio Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 00:32:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRFTX-00076x-B3
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 00:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbYBRXcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 18:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYBRXcG
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 18:32:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:56305 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbYBRXcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 18:32:03 -0500
Received: by ug-out-1314.google.com with SMTP id z38so440709ugc.16
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=CTi6d0EDTLMzRh3oKGwxGKqun1Tbxl14lyNMIOUJ1f4=;
        b=OuI1iZHZUFnxgH353ucNb3lvrpPPZc75zOFzeRKO026SUn7jc4p9AlsJv6ZcMsA6/zIoDr/8WzYMukRC9383ypVRpq9jVy0RXhFUkiMVIPNkNmd7YCS27Ms2L6l0eMvou3c2bbFVIoEgSIap7mbzng677G5hBuuM800q9cMy+6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LcHcfF2nnxKwtu3eidrwEji6HRlRUb2Ik7uyc89CeZaNa8ic27b1ykr2S+3Mm01DMNjYioyQKcKmdsDpwk+twHyO+Gp/5Lm2L//N/aolYQyu/TBX+v8e76zIUL15Q1hzVFKO2zLyWCIUv6cKWauTSV/8B8cFa1xKBsaUANdpMIE=
Received: by 10.67.116.19 with SMTP id t19mr3178603ugm.47.1203377521982;
        Mon, 18 Feb 2008 15:32:01 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.224.67])
        by mx.google.com with ESMTPS id e1sm5836540ugf.34.2008.02.18.15.31.59
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 15:32:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <C8D96592-DD9C-47D3-93AB-3F74719F4D46@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74357>

Dnia niedziela 17. lutego 2008 11:51, Wincent Colaiuta napisa=B3:
> El 15/2/2008, a las 22:16, Jakub Narebski escribi=F3:
> >
> > WORKSFORME. I could not reproduce this error with the patch
> > below applied. I think that the previous version of patch should
> > give the same result; should also fix this bug.
> >
> > Besides, both "next" and "raw" links are generated using the same
> > mechanism. It would be strange if one of them broke and other didn'=
t.
>=20
> Just re-tested again, this time applying on top of 1.5.4.2 and =20
> definitely doesn't work for me.
>=20
> The "next" links are fixed, the "raw" links still exhibit the same =20
> problem.
>=20
> eg. here's a commitdiff page with a broken "raw" link from my =20
> installation:
>=20
> http://git.wincent.com/wikitext.git?a=3Dcommitdiff;h=3D03b8fda6594aa7=
e6fab3b95b66a4f3c178d6a156
>=20
> And here's a shortlog page with now-working "next" links:
>=20
> http://git.wincent.com/wikitext.git?a=3Dshortlog;h=3D03b8fda6594aa7e6=
fab3b95b66a4f3c178d6a156

Could you reproduce this error with git.git repository (after any of
the two patches, but please tell which)? Please provide an URL to the
page, and fragment of HTML with wrong link.

BTW. I have just checked above link, and the "raw" link is most
certainly not broken. Were you using updated gitweb (with patch),
and reloaded page?


Junio, would you consider applying one of those patches? Any of them
should fix the bug; the second one is less intrusive.
--=20
Jakub Narebski
Poland
