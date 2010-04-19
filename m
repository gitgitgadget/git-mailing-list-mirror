From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v4 10/11] http-fetch: Use index-pack rather than 
	verify-pack to check packs
Date: Mon, 19 Apr 2010 22:35:39 +0800
Message-ID: <y2zbe6fef0d1004190735q1b2e69f0ja30c7badce49f63b@mail.gmail.com>
References: <20100418115744.0000238b@unknown>
	 <1271686990-16363-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:35:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3s4h-0000W7-NW
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab0DSOfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 10:35:42 -0400
Received: from mail-iw0-f199.google.com ([209.85.223.199]:50819 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0DSOfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 10:35:41 -0400
Received: by iwn37 with SMTP id 37so483797iwn.15
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cNeEfXpy3iq8MdrhaTC7Z4+14O7l7wTpfKzeUAv2eYE=;
        b=xe2pmOlXn6EnH3Wn0eLmgHBN9wu37lFKGl1ev1f2qB1AYCOs5TBns7l5/PAKCqFJ6S
         wthGu6nrEymnSdskPwjoXQZQv3largGPBqDKFvfgGlj9xDDoKEm1iXUt/76miSu/IXdl
         AeTlL+CnwekDWU2/agvG7979UMvj83sZqlRwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MyawUJ48VgkpYu5iuDPkfxGuaxXQ8m7x4x6RGUjJugELkZ5XQktA/IXE5qlTHMwmkt
         t9FwclxsZ8juUV/fch5gg8aRPGJ9tUhB9TWO+EbBHXwoIWiMqq31NFtKlvCTwwVPE7Xo
         O27YFO68JGGI7dUKhOmy+qrSjxivumZ8Lw/t0=
Received: by 10.231.10.65 with HTTP; Mon, 19 Apr 2010 07:35:39 -0700 (PDT)
In-Reply-To: <1271686990-16363-6-git-send-email-spearce@spearce.org>
Received: by 10.231.152.78 with SMTP id f14mr1929346ibw.51.1271687739719; Mon, 
	19 Apr 2010 07:35:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145305>

Hi,

On Mon, Apr 19, 2010 at 10:23 PM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
> =A0Moved unlink of index to after the index-pack is successful,
> =A0per Tay Ray Chuan's request.

Looks good.

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
