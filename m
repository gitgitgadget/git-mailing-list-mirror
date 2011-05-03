From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Tue, 3 May 2011 23:17:04 +0700
Message-ID: <BANLkTimVg2sDZzeRyVEJC-Sq4ojs=AQ=rg@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com> <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org> <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org> <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org> <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <BANLkTimfT87-vV0GCvsVmRJ6nBZt7jSkkw@mail.gmail.com> <7v4o5bkevi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:17:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHII9-0005fu-AE
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 18:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1ECQRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 12:17:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46395 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1ECQRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 12:17:35 -0400
Received: by fxm17 with SMTP id 17so213569fxm.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=j9l8S2WJNYurVLAkbPjBPh0H2Tnc1y7WuD7/OgMSnYk=;
        b=cY+OL/sh4YPwGZgr25aDrsMIqfC0uPD5ny6lpRhwNegof8mALE00B9aRn8a2GasapQ
         yEabk31DHujAwnHQn71KW0L2FJRx88wNbs4DUyHNxPGcAOaIyycIeiB1gW7I3bsBnNpy
         ODJL/t0neT8edPcKQbEFXwU5lPh8XqD1qVCUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qsMF3vVZBiwDrLgksPwxi/XclkFl5kHAI2AYYmfweythfPrxgi6aeuO1LAVnfDUnfd
         eYmc2sKKBmx5bZvVaveZuCpoBFDcTbHPsFotwJJWT+ds3UylRsdgOSAXzI0sQEHW3OkW
         KssPX6V8pmKdad/Mtucsjf/ahb0r33TPLV77c=
Received: by 10.223.134.75 with SMTP id i11mr42742fat.39.1304439454105; Tue,
 03 May 2011 09:17:34 -0700 (PDT)
Received: by 10.223.118.5 with HTTP; Tue, 3 May 2011 09:17:04 -0700 (PDT)
In-Reply-To: <7v4o5bkevi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172669>

On Tue, May 3, 2011 at 10:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> I need someone to enlighten me again. Why do we need ":" for "no
>> pathspec" when we can simply specify no pathspec for the same effect=
?
>
> Futureproofing. =C2=A0Currently "log" family defaults to "tree-wide" =
when there
> is no pathspec, but imagine what happens when a command like "log" th=
at
> knows how to simplify history defaults to "current directory". =C2=A0=
You cannot
> override it by "git that-cmd :/", which would give it a single tree-w=
ide
> pathspec, not "no pathspec". =C2=A0It will still cull empty commits.

OK, empty commits. I see. Will test it that way.
--=20
Duy
