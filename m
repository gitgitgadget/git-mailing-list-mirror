From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] add: make "add -u/-A" update full tree without pathspec
 (step 3)
Date: Wed, 23 Mar 2011 21:02:46 +0700
Message-ID: <AANLkTikBQg_pT2NX9vQc+DcB+4HA35VXBpQyRtAU_ewG@mail.gmail.com>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org> <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org> <20110321111643.GE16334@sigill.intra.peff.net>
 <7vtyeuiu07.fsf@alter.siamese.dyndns.org> <7v7hbqifej.fsf_-_@alter.siamese.dyndns.org>
 <7v1v1yifc9.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2OiO-00048z-Ow
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab1CWOHD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 10:07:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36527 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab1CWOHB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 10:07:01 -0400
Received: by wya21 with SMTP id 21so7681243wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=HWU5WisSMFX9RkGSjJ5DHOj1Mjos0NpdFzHzM+lXZFU=;
        b=rACPi35tMaO6ZQ5drWzX44AqG7g+NPOYnqc4Ldm9KX1CpOZ89IRIxDBLat6eG67RW2
         RpStBhzLHqCjzPKIqDyyemPQJtBNjYgwBJX37mf0S1qY9VuMNcSnu/NoBEC/BXHN/C35
         h5Bs30134oIFo63+McxV6gKblyljcthsGLcFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rWopnuhnYPf/widXsIrqQ0bqVqLL+MKCx27AhQK9f+fjoDpc2OzgEugx8NMS8axmD9
         uLZW5grGNelWEnCAfeRBBhM1X5qYVzPSzNHDaJ4/rqmqvGPlm3pMBtn1atIe4OB9PDFt
         SnYeWKzwynqfUt2v29YaM/S0N/kji1+0fvm6U=
Received: by 10.216.243.195 with SMTP id k45mr6802826wer.66.1300888996367;
 Wed, 23 Mar 2011 07:03:16 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 07:02:46 -0700 (PDT)
In-Reply-To: <7v1v1yifc9.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169833>

2011/3/23 Junio C Hamano <gitster@pobox.com>:
> Now long after 1.8.0 happened, people should have got used to the
> new default behaviour and it is no longer necessary to give the
> migration advice anymore.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =C2=A0* And this concludes the two-year long series from the future ;=
-)

Beautiful.

I'd expect you kill add.treewideupdate too. Say one year after this
patch, we can start to annoy users asking them to remove
add.treewideupdate and switch to new behavior. Another year goes by,
we refuse to work with those who still keep add.treewideupdate config.

A consistent default behavior is a good thing. If I help a git user
and later realize "git add -u" on their machine does not work as I
expect it to be, it'd be less pleasant.
--=20
Duy
