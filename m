From: Ivan Kanis <ivan.kanis@googlemail.com>
Subject: Re: security flaw with smart http
Date: Mon, 25 Jun 2012 14:59:04 +0200
Message-ID: <87ipef5yzr.fsf@visionobjects.com>
References: <87fw9ns0cp.fsf@kanis.fr>
	<CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com>
	<7vmx3vp2co.fsf@alter.siamese.dyndns.org>
	<CAGK7Mr7_a0V=Tzp9FtTjARsvSn2YOa0_GbydTrsQzxg_MJf=uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 14:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj8sy-0004dV-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 14:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718Ab2FYM7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 08:59:16 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46425 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab2FYM7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 08:59:15 -0400
Received: by wgbds11 with SMTP id ds11so2675526wgb.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:references:face:x-hashcash:x-hashcash:x-hashcash
         :x-hashcash:date:in-reply-to:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=9ZYw351shACG9DooSixuVlMPpyLzN46V3VBpQMQPoZ8=;
        b=saJ96rCe/yfNBcfKGdIJUM+byFU9UBheYp7UiqCvVYfIqWYqHoBLnflpnJBTAN/Toc
         S/yKzbDHMLxbhnQ0oZcfG16cvpgRYPEY3Z8hYvq/RLMtqAivxS+OKbGhspQtdju4KvOU
         c5DbqUehw6dMWpTosQQ/rF3+YvEIJ/1tt7PBr0JQCzikg3NTd4gvs5xHmUVFJtPnytQ0
         SDOamqOyYK8h8ofawJhscy8d1bMyvb1j/lkAPH3+Plmftk5mupSux/hz/8AbKdr3R/hL
         YfbRgic6wLDqT3bcAOxarEqDUS6gbEM20IQ8BA61qJWSuDv41QKn8U5/Dk8IA+byfGHO
         HIkw==
Received: by 10.216.145.157 with SMTP id p29mr6222597wej.65.1340629153730;
        Mon, 25 Jun 2012 05:59:13 -0700 (PDT)
Received: from yan (nantes.visionobjects.com. [92.103.229.106])
        by mx.google.com with ESMTPS id q6sm23749382wiy.0.2012.06.25.05.59.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 05:59:12 -0700 (PDT)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
X-Hashcash: 1:20:120625:philippe.vaucher@gmail.com::S3egDXUv6v0DUszO:000000000000000000000000000000000001hi8
X-Hashcash: 1:20:120625:git@vger.kernel.org::hafcNZVQKfyUlPIt:0000000000000000000000000000000000000000002PSE
X-Hashcash: 1:20:120625:gitster@pobox.com::o9e4D4CAGqFK6fzV:000000000000000000000000000000000000000000002gE7
X-Hashcash: 1:20:120625:spearce@spearce.org::RThSh37cattmGRcH:0000000000000000000000000000000000000000005WQr
In-Reply-To: <CAGK7Mr7_a0V=Tzp9FtTjARsvSn2YOa0_GbydTrsQzxg_MJf=uA@mail.gmail.com>
	(Philippe Vaucher's message of "Mon, 25 Jun 2012 13:24:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200576>

Philippe Vaucher <philippe.vaucher@gmail.com> a =C3=A9crit

>> I do not recall ever releasing 1.0.7.4, nor having smart http
>> support before v1.6.6, by the way.
>
> It sounds very likely that he meant 1.7.4 no?

It's compiled from a 1.7.0.4 tar ball, amusingly git --version says 1.0=
=2E7.4
--=20
Ivan Kanis
http://ivan.kanis.fr

Par pr=C3=AAchements, le peuple on peut s=C3=A9duire ;
Par marchander, tromper on le peut bien ;
Par plaiderie on peut manger son bien.
    -- Cl=C3=A9ment Marot
