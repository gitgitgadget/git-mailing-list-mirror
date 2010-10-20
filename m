From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH] diff: handle lines containing only whitespace better
Date: Wed, 20 Oct 2010 15:51:12 +0800
Message-ID: <AANLkTi=XhsJyi0Tb5j8j1WKUNTbuy4Y6ugaAifYGBzB_@mail.gmail.com>
References: <1287549978-54280-1-git-send-email-kevin@sb.org>
	<7vzku9wfrp.fsf@alter.siamese.dyndns.org>
	<780B144B-03E0-4ED5-8E92-D4EB3CBBBF71@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 20 09:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8TSB-0008Ob-4J
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 09:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356Ab0JTHvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 03:51:13 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59787 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280Ab0JTHvN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 03:51:13 -0400
Received: by qyk12 with SMTP id 12so1248067qyk.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jqmc1NcLPNsS+cexyhgiT/wSDptm7gj6+d+XgamOws4=;
        b=rQSIAkfaLkDpjw6aaAx4knGIFAKo9s0y9WW+9+H+N87Mvys3uNpuwIjE9US8u0xyqu
         4MatxYfto/dcEJtBd/qXcNYf0/3N9stbYuncvHY3cCUDJry61VX3VRM5yVVGAw7Dhppo
         ppsh9983eQ45BRAiGun7kkrIuHSf3PZyLOpuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b3DFh7VNMHohRxkRaBKY3v89AsZuTKGdPKjlOgLfNZ21Msx3OaH2b8dP9TpNw/ME68
         soYHtxpyK+JNAcThUSqqIy/RG45V65+PMVr4D43cbl5WEeXmmQa2LK2QFqbUXnjiEg1W
         dmao79Imc3g5D4lizQ+p62XXvf6bvrDeuv1A4=
Received: by 10.229.236.74 with SMTP id kj10mr6116443qcb.221.1287561072234;
 Wed, 20 Oct 2010 00:51:12 -0700 (PDT)
Received: by 10.229.100.79 with HTTP; Wed, 20 Oct 2010 00:51:12 -0700 (PDT)
In-Reply-To: <780B144B-03E0-4ED5-8E92-D4EB3CBBBF71@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159399>

On Wed, Oct 20, 2010 at 2:38 PM, Kevin Ballard <kevin@sb.org> wrote:
> ... I can also attempt to write
> tests if you can give me some guidance on how to deal with the need for ansi
> color codes.

Have a look at t/t4207-log-decoration-colors.sh for inspiration.

nazri
