From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] t/t7300: workaround ancient touch by rearranging arguments
Date: Sat, 18 Sep 2010 01:26:25 +0200
Message-ID: <AANLkTinKxSugWedXxLPkSUKyRBBkTimawVY23+A5nzsZ@mail.gmail.com>
References: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil>
 <20100916003117.GA2527@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 18 01:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwkKS-0004ym-Oe
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 01:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab0IQX0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 19:26:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51941 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0IQX0p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 19:26:45 -0400
Received: by ywh1 with SMTP id 1so889861ywh.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IgyGwu5VvrDqLs5Jz4ZwLwiE3VFwhx0tGBdwEnO9ZuM=;
        b=DrEHjkuBzsdPSr5+jEVT77nVVq3r9AdQ/hrojVquwKmQMBOoaWkSQBVyqGUjCUxZzF
         LVAzGjGa1yT4Lg+YeFWJl9erl7QiHgHmx4Cvdv3GwJJ/dqdh7rqtsaZaeyT/SSPh3v72
         0olrIfjIAcdZOmn4Xtfifc0jZBYCsLyEX1060=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VBnPvZFVnbQrD4tlCFyrh251sUdgqgmLjRG662Vd3WUEaPCqYa+saEOQZBiiyc6EQt
         P6RpNAmPEMzIMEKBE2CoDKFFrmP+wIcYOYOpt1oRZ7zVlhtY7n8Ts64a5XEke4TSrP5I
         CfVZaiI+k/0tueCdtSErobiLmn4LM6PygB0ak=
Received: by 10.150.147.13 with SMTP id u13mr6016119ybd.280.1284766005135;
 Fri, 17 Sep 2010 16:26:45 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 17 Sep 2010 16:26:25 -0700 (PDT)
In-Reply-To: <20100916003117.GA2527@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156419>

Heya,

On Thu, Sep 16, 2010 at 02:31, Jeff King <peff@peff.net> wrote:
> Hmm, this seemed eerily familiar, and sure enough:
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/101270

Does this call for a git_touch which does a regular 'touch' for each
of its arguments?

--=20
Cheers,

Sverre Rabbelier
