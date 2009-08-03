From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Mon, 3 Aug 2009 15:21:46 -0700
Message-ID: <fabb9a1e0908031521q579a9bf0ta834b2c9253e58e9@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com> <7vocqw8u0x.fsf@alter.siamese.dyndns.org> 
	<4A7760FD.8020705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5v2-0001wn-OH
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 00:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbZHCWWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 18:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbZHCWWI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 18:22:08 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:14111 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZHCWWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 18:22:07 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1029987eyd.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 15:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+PJ0n791vAw4ovxQZEEdkfMZv6dFaBKN94HUPHXe88o=;
        b=Bm204eH8jip2OD90dj+/WD9aPB7xGKHMxaAQRF47FWXrruSzlk4ug+n72JKpescx5J
         GX1Zjp7MeNgTNeaugyptOhLlxv9OGIE5oo0ZEBx6/uxm9ZhdY0IDhh5cELICNsqWDhpE
         uEcHPT0jo5GYrk1bMLfWE9RkKEzmAa0nQcqe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ojxmfZi4ZDX9SYwND/RtcolGzjjV4UFRPW/QW3wXhp7L4/cTeYSyStrInroHcUVKmg
         TMjfySXEHzw/MQiU4cf8Uv1hxuSfmNEl7XFkwZVhBsgSKQwxJkaH2pXAzzco+nBbrjEu
         UnYNZY/qfrIqwOi36G9/pkGjn4fNFFIJLWSo4=
Received: by 10.216.90.74 with SMTP id d52mr1284751wef.51.1249338126282; Mon, 
	03 Aug 2009 15:22:06 -0700 (PDT)
In-Reply-To: <4A7760FD.8020705@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124732>

Heya,

On Mon, Aug 3, 2009 at 15:13, H. Peter Anvin<hpa@zytor.com> wrote:
> Yes, that's what they suggested, too. =A0Like I need an extra step in=
 my
> patch process.

Write your own git-lazy-am.sh and put it in your path?

cat > git-lazy-am.sh << EOF
#!/bin/bash

dos2unix "$@" | git am
EOF

--=20
Cheers,

Sverre Rabbelier
