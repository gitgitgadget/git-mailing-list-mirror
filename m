From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 0/4] http cleanups
Date: Wed, 4 May 2011 17:50:24 +0800
Message-ID: <BANLkTim9uii4gRHAp+UWk8+_bv=wXasj-g@mail.gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
	<7v4o5bgl8m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 11:50:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHYj0-0000cF-2j
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 11:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab1EDJuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 05:50:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36821 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1EDJuY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 05:50:24 -0400
Received: by iyb14 with SMTP id 14so796826iyb.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EoLs26LK/rQjaFn76krKlRmci1wZi6XOuR/qI2Q33sI=;
        b=aLQnzXJxk1+7Jvf+ateDcVJWO19d6FzYwtrR+0qDKDS+OVw00O3GxJqDeJIWw1YB3V
         Sx95F8/5L4JlanRjGT3b8Mm0mBVk4xbO+bsOAaaPNmrQfreoBsTH7t6B/OGabz7u75Cl
         ACzv7x6IZsOCsuVrUisMdWEmIoAR/Q5HZDmf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DtQbr7MvKmVB9F3Wo1r4orwey22Xaz/Mui9cbgrx+rcg/hNXvd82W1TNI1JkWfTXIl
         dabp7bD8K1wD/b/H/Wt/y01BaDpHq3tJpy5cO6ocJK/2FpqzOzReJnfe4xw23XzXPscv
         I2aphRaRHxKcXQ840w60yBwmlAN7295efZ1AE=
Received: by 10.42.138.193 with SMTP id d1mr1529078icu.267.1304502624245; Wed,
 04 May 2011 02:50:24 -0700 (PDT)
Received: by 10.42.146.199 with HTTP; Wed, 4 May 2011 02:50:24 -0700 (PDT)
In-Reply-To: <7v4o5bgl8m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172732>

On Wed, May 4, 2011 at 12:09 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It doesn't apply for me. =A0It does apply to 'master' after that topi=
c is
> merged to it, which is good enough for our purpose, though.

Sorry about the inaccurate note. I think this is due to
sp/main-clear-postfields not containing t/t5541-http-push.sh.

--=20
Cheers,
Ray Chuan
