From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH maint] imap-send: Fix sprintf usage
Date: Sat, 7 Aug 2010 23:25:33 +0000
Message-ID: <AANLkTinD=cqqzG+d8UxoJo1TLhmuu-3L5+3y0WUT5xas@mail.gmail.com>
References: <1281183136-10352-1-git-send-email-avarab@gmail.com>
	<20100807210429.GA2216@burratino>
	<AANLkTim4CHdVLinkw1EjXB74OJ+YW-ri4GzHMNhRd+Cy@mail.gmail.com>
	<20100807230945.GA3427@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Mike McCormack <mikem@ring3k.org>,
	Benjamin Kramer <benny.kra@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 01:25:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohsly-0001lf-6K
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 01:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab0HGXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 19:25:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44460 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0HGXZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 19:25:34 -0400
Received: by iwn33 with SMTP id 33so2539078iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=i0ZQ2PZ6S9CUBRhUzEkjscfPG5kvfN0CozNztXEc2nI=;
        b=S/nItNtT6a2j2r1oPhXutaGMyCDdq4oUPAieS9s0Gsk5jScglSgLGuACvaphsKXQPd
         EylL3sc5uynEViQj9GBwyibliba6br5MFBhPqMoyED/nZCjSi0lQluAvdhMARIy8UB5o
         /hq/RrkUWptBACfTBMYAsGBZosMWGfSpx8KK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XBSb5m7fAY/m01TtbuzMYXSfnUhX1a7g1Wqq0QDHDRpg8rzPW9RxN22JTnjbQVGHOP
         8sGDMnFLt+0LTqLWy8n62DUuZWCawCkb/43wP9Bn6ReDMYpjuKSS/qzgZf/jlzTLWkJ5
         FinWkaoWHrqb90YCT/w0O3R9Ty9NPmZIQDTq0=
Received: by 10.231.33.67 with SMTP id g3mr16477903ibd.31.1281223533171; Sat, 
	07 Aug 2010 16:25:33 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 7 Aug 2010 16:25:33 -0700 (PDT)
In-Reply-To: <20100807230945.GA3427@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152873>

Thanks for submitting this, especially since I was too lazy to do it
myself today. It looks good.
