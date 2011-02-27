From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Sun, 27 Feb 2011 14:35:15 +0100
Message-ID: <AANLkTimox7NhBsp9V=9p4hooeB-sprV21UbUFtzf+-Rw@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com> <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 14:36:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtgnE-0004J1-4p
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 14:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab1B0Nf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 08:35:56 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47672 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1B0Nfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 08:35:55 -0500
Received: by yia27 with SMTP id 27so357985yia.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ixgtfX9IZpq1Go7r5+t0qM/asLp6U149hFk9q+hCUck=;
        b=ZmDiuqpqWcTVTe0qoODHYRkj9/0UaKbeWXG+DaHRtaduP0/NRxp7ouT2AEEIiTjstO
         VfuHqGHaiQXGkVkvq2pGyWFwLMPoE0+DqGPEMgwTM1kfReT6tjzfVGwnECVUXhFnTbBt
         kt7oab2RRJDTxrl7VrjXQe6sFrHVoVTEk1oE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FI3vF3Ultz7topyv6RT0EifU1+eprqiPQ7LF5s1c7/TU2WgZkR/qSpw3a6bVlIn4s7
         2nZ8E3sVnD/cYGp7ENrKZgs2SKogVyQdU7X4vL4oDnxCXOYl6z9jfG1E7ifWdTSg0QMJ
         OIHOXNHv7fRVB94JbLVWAZo7pxARkFzFsuA3U=
Received: by 10.150.52.14 with SMTP id z14mr5968534ybz.292.1298813755077; Sun,
 27 Feb 2011 05:35:55 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Sun, 27 Feb 2011 05:35:15 -0800 (PST)
In-Reply-To: <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168030>

Heya,

On Sun, Feb 27, 2011 at 11:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C2=A0* Ship this as 1.7.X and see how well the new feature is accept=
ed in the
> =C2=A0 wider user community. =C2=A0If the feature is not widely used,=
 there is no
> =C2=A0 point in proceeding further.

I'm confused, I thought we were doing this for consistency reasons?
That would benefit mostly new users, right? New users, which are
unlikely to notice this new feature, or report to this list that they
find it useful?

--=20
Cheers,

Sverre Rabbelier
