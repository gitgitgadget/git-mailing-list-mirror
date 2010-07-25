From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/9] t7508 (status): modernize style
Date: Sun, 25 Jul 2010 08:38:03 +0000
Message-ID: <AANLkTin_GsqW6JIUqJXkrIQFIRcZXaoCUFm83s3m_LBG@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
	<20100725005942.GF18420@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocwis-0004Fu-S1
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab0GYIiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 04:38:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39029 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0GYIiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 04:38:04 -0400
Received: by iwn7 with SMTP id 7so1772172iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KFmKaXRScOt5Lg6gsEjJWvDSdl6MimxXRT+rDX2N/x4=;
        b=esHO0n60GQGQGIMqYuc3kwgk+8JwcccBDzK/h8SWMyBHraSjmRRVfWFRlvjrdXFSI2
         +njYd6wBNBI2U99ZMt8lPWWDoNKKoRcFFmWANZLuRT1QJDaPtw5r4Os6QFI7qU7m2NEB
         auBCkR0dYRfUnuciuvU5ab5yC64FpMWJV3R6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mhg/VTItuHdbK/O6mdrUDBEQKgALbndDXQzQrrFBSc5CHH3Dqm7qVHmrYVGlMdSmpX
         DW3xQxl3ScTOUyHz3jYTPzbo7AjoRO3zsYSvTs34Mv5LEh/Xt3/wwvXHxBFEDxYOTVMF
         C9beRSumG7wWRrB6ToxEp8pFgK7H6YvwlEwZo=
Received: by 10.231.30.129 with SMTP id u1mr6649586ibc.63.1280047083775; Sun, 
	25 Jul 2010 01:38:03 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 01:38:03 -0700 (PDT)
In-Reply-To: <20100725005942.GF18420@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151711>

On Sun, Jul 25, 2010 at 00:59, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Some cleanups to make this test script easier to read and use,
> such as:
>
> =C2=A0- put setup code in test_expect_success scripts to make the
> =C2=A0 test script easier to scan through;
>
> =C2=A0- avoid a pipe to test_decode_color that forgets the exit statu=
s of
> =C2=A0 "git status", by redirecting to a temporary file (named "actua=
l")
> =C2=A0 for that function to consume instead;
>
> =C2=A0- remove precomputed object IDs;
>
> =C2=A0- reset configuration after each test, so there is less state
> =C2=A0 for a reader to keep in mind.

These changes are all good. Well spotted with the test_might_fail()
additions, adding forgotten &&, and turning the >expect code setup
into their own tests.

Acked.
