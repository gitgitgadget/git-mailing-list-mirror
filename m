From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] t/t0006: specify timezone as EST5 not EST to comply with 
	POSIX
Date: Wed, 7 Jul 2010 11:48:41 +0200
Message-ID: <AANLkTin5czoPMgqg5SsiuURjZ-1tpg-S-Die4DejjAMs@mail.gmail.com>
References: <20100704110017.GA23121@sigill.intra.peff.net>
	<upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 07 11:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWRFJ-0007j9-Et
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 11:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab0GGJso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 05:48:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54597 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0GGJsn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 05:48:43 -0400
Received: by wwb24 with SMTP id 24so2588059wwb.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0tQWH36lfvsTOPuyxN6bt49Ly1tbhp3Tg7sLWAG/Cp8=;
        b=ewed+8fDut/ZOZMIkgvT5zyWHlt6fh9ppIgNpIRj4Rbi6TfyZjZuIeDubKAZnE/Q/y
         HLyXMrbamiLxGSuZWdUIU+85afVjN8QXpkt6Ahi/HUFP9RHKOw3REf6wF7pPVjbe1TzD
         IAQfYHUldikElAJIXHzbKLGyEIN01am82xFJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gUEYHGlys7nRMZvEIVbG4ppofL8FSiKs6WGN4BUgltmzibdp4u5cAp1MHXLWiUPlm8
         0iB/Fq2ETGQwqUPRBKSeGjw21qwgOBNIMKV1HrNnmpPkIE+fI2SIP0UEAeXBytpIGWp4
         /SEC1IrPWWJQgYM2Zp+0ACWygPSnPmA6MSFTM=
Received: by 10.213.108.65 with SMTP id e1mr5460574ebp.47.1278496121504; Wed, 
	07 Jul 2010 02:48:41 -0700 (PDT)
Received: by 10.213.112.208 with HTTP; Wed, 7 Jul 2010 02:48:41 -0700 (PDT)
In-Reply-To: <upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150462>

On Wed, Jul 7, 2010 at 01:34, Brandon Casey <casey@nrlssc.navy.mil> wro=
te:
> From: Brandon Casey <drafnel@gmail.com>
>
> POSIX requires that both the timezone "standard" and "offset" be spec=
ified
> in the TZ environment variable. =C2=A0This causes a problem on IRIX w=
hich does
> not understand the timezone 'EST'.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
> I guess 'EST' is an alias? for EST5EDT? =C2=A0Linux and Solaris both =
grok EST
> just fine. =C2=A0POSIX says the offset is required. =C2=A0I don't see=
 any mention of
> aliases.

Same on the Cygwin installation I happen to have here: it doesn't
recongnize EST,
but does know about EST5.
