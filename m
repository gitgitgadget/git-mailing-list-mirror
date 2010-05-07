From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 16:06:45 -0400
Message-ID: <t2g32541b131005071306v580560c4gb524e9456604298d@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<20100507194140.GC7963@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri May 07 22:07:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATpL-0006Wt-9d
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146Ab0EGUHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:07:08 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:61111 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab0EGUHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:07:06 -0400
Received: by yxe1 with SMTP id 1so1010325yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CsP/VogNvl1n1GWTA+e8glK5WrBcpnr+5x8IVeVw68g=;
        b=aZE0FkagU1CBCTwkwhjmaBFuwSQrAsVL0MHccK9mIZGosGuYCT8X1pKZh3oZBA/KTA
         L0WBtWqeGmHp0f+eQ8NVBCckgWhjaPgqt4DsrlgSFEzX41icQXIb03slt7KHRZ0vb174
         uKK25dFumg+u6ULRML+v36A/SEBnSx+CU7RVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Cc0bljdG79DWriXmY90bj8tPzqmbT05DxGUCaOY552sxT92qcgArEHRDcggZsYsIw0
         sy0X5Hz6NnB/Rp1noyPWmC5VDTTEc5RF5j0y/nwY51q2WDw1uzrya+8XPNWY3SDjEemv
         OnmtU+V+kfXVDEp3On3wi+AgLfvZwSzVwUgz4=
Received: by 10.150.213.15 with SMTP id l15mr3809302ybg.202.1273262825415; 
	Fri, 07 May 2010 13:07:05 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 13:06:45 -0700 (PDT)
In-Reply-To: <20100507194140.GC7963@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146578>

On Fri, May 7, 2010 at 3:41 PM, Finn Arne Gangstad <finnag@pvv.org> wro=
te:
> Maybe it is sufficient to add a new value to "crlf" that means:
>
> - If the file is autodetected as text:
> =A0- Convert to LF only on commit, and
> =A0- Convert to your preferred EOL style on checkout.
>
> I don't think autocrlf is a good place to specify preferred EOL
> style, it is too dangerous to set autocrlf to true by default, but it=
 should
> not be dangerous to say that your preferred EOL style is CRLF.

Assuming it's updated to reuse the existing crlf attribute instead of
adding a new one, that seems to be exactly what this patch series is
about.  "Your preferred EOL style" is the newly introduced
core.eolStyle config option.  So... good idea :)

Have fun,

Avery
