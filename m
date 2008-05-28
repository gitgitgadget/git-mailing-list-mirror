From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 17:53:13 +0200
Message-ID: <483D7FE9.5000207@gmail.com>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed May 28 17:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Nyd-0001QU-4h
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYE1PxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbYE1PxT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:53:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:29755 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYE1PxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 11:53:19 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1366680nfc.21
        for <git@vger.kernel.org>; Wed, 28 May 2008 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=yHuNn+tviUcnMyDxsUFZOJIXY14PkJAiXQJjp8YxuN0=;
        b=B6xGtj+x7rtCVsOHIilBAKrHiBIkdix2sMNkswj63yxA4RMu4UstRSKDneJGPHc+akU1smTBBFR+8JkfH1P4IJnPEH/OM/YlOwmR35YjLYXZwrX35Tzzo+XyLtWkRjOZYNknM1B6lO9QDB4GOxgOxKqVtknz2aWqb66Xdf4CGxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=d+hkHIqWEWOEENFuxRp4MXFGjzCTRT1KsKyMxLIet96jJwTFA4kpwCHEW3TUheMNHB6DYbD5JzG+0TPB+k52+cCN37SlzXIqh5NaHYG35jZqqY4CZRLRmSDSDhpTZE/g4FadC6nvO7SMu6xD20P4MYdV7AAEW5xHvnHWURiSJWU=
Received: by 10.86.27.19 with SMTP id a19mr3450377fga.56.1211989996104;
        Wed, 28 May 2008 08:53:16 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.212.111])
        by mx.google.com with ESMTPS id 4sm14593862fgg.6.2008.05.28.08.53.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 08:53:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83102>

Wincent Colaiuta wrote:
> El 28/5/2008, a las 8:12, Junio C Hamano escribi=C3=B3:
>> Perhaps we should remove the infamous gitweb/test/M=C3=A4rchen file
>=20
> [...] I'd much rather see this kind of thing =20
> tested from within the test suite rather than every time I do "git =20
> status" or "git checkout".

I don't believe the M=C3=A4rchen file is actually used in any test code=
, so=20
removing it should be fine.  If/when we actually write test code for=20
gitweb, it seems to me that we might as well generate such test files o=
n=20
the fly from within the test suite, rather than having them in the file=
=20
system permanently.

Best,

     Lea
