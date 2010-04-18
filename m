From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 06/11] http.c: Remove unnecessary strdup of
 sha1_to_hex result
Date: Sun, 18 Apr 2010 11:14:04 +0800
Message-ID: <20100418111404.00000794@unknown>
References: <20100416100307.0000423f@unknown>
 <1271534864-31944-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 05:14:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Kxt-0007G4-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 05:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab0DRDOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 23:14:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33407 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab0DRDOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 23:14:17 -0400
Received: by gyg13 with SMTP id 13so2051089gyg.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=BaZM2zux0LjdjfFvT3CuPW3cNYOmgCct65QDA/mqU0w=;
        b=NdntKB62tB/ELpCbQX9C5BIn0pu30YMwpQvGxo7lTXCx4mLejtxUvUxPEBl/+j2nYT
         PdeaB5CrgkYiD6Y8CTYnhfmWjSqLFpN9a1+ym3sHffAup9djUbdqZvbgi0074UHDPFTn
         VhOGszaLadj1GQ29a3c6ls5f2+QPSAj+Qqeds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=FJ/7UkbMtOmp5Ke0uyt2/q5UREfzX+FOIqf5gHv7xOgkLMJxkk5jbJXqi2tzzWQR1T
         tltHualtXfGdjRTnNEoWerxLGEqD/S0cXonZNOYufIM/9PPovr5mCCSCzb29f1H+xyhY
         CySPaNRMRP+UqpXEUhcDwvyS7blkvsTAIJoGs=
Received: by 10.101.5.28 with SMTP id h28mr9148321ani.91.1271560456727;
        Sat, 17 Apr 2010 20:14:16 -0700 (PDT)
Received: from unknown (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id r21sm30212448anp.17.2010.04.17.20.14.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 20:14:16 -0700 (PDT)
In-Reply-To: <1271534864-31944-6-git-send-email-spearce@spearce.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145207>

On Sat, 17 Apr 2010 13:07:39 -0700
"Shawn O. Pearce" <spearce@spearce.org> wrote:

> and its entirely trivial compared to the latency involved with the

Minor nit: s/its/is/, ie. "is entirely trivial".

Junio, perhaps you could squash that in?

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

-- 
Cheers,
Ray Chuan
