From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 5 May 2011 13:18:28 +0200
Message-ID: <BANLkTin8YUwoMmxXLske=5nuvW+idBOuig@mail.gmail.com>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 <7voc3hbtgu.fsf@alter.siamese.dyndns.org> <20110505054611.GA29033@sigill.intra.peff.net>
 <20110505061634.GB29033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 13:19:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHwaR-0005jD-Do
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 13:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab1EELTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 07:19:10 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54454 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1EELTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 07:19:08 -0400
Received: by qyg14 with SMTP id 14so1488401qyg.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=BKkekEaTCeyNDvnT87DBSPJzMyhEwVoQSxDWu4KYNsg=;
        b=Ad90D2sWq2BeE4dytBnJ/eqEYgRK6MGK7loHUZHgWWYB1RXqqtnYFOi2ILgaTDxbDs
         SFyyxJo27v55Y8zWkYNMozQPQ61I5zmleR7kNtOvaQdcR7CbDiBq/TqiPfpnCuDC2Lcv
         xCg8/PYaOXOH2y9pnOvz9PnHQerEGObVI0d8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uhX2oxcYEL2Vx9/kzEurLKKlHXroIAL0iYn3nU1Y8jNRisOVuTbtbdSDmMrWviyywg
         R56+m2sIPiRD5NyM+d4dQoUG9ymS5JTEx7UCKM2h/sKyW1H7uIRt8+8Q1L1KAW4f7dRQ
         GcXLzMj0Nr7B1l67cf00U22TRyAATf7K0bU6A=
Received: by 10.224.33.132 with SMTP id h4mr2207552qad.284.1304594348102; Thu,
 05 May 2011 04:19:08 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 04:18:28 -0700 (PDT)
In-Reply-To: <20110505061634.GB29033@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172829>

Heya,

On Thu, May 5, 2011 at 08:16, Jeff King <peff@peff.net> wrote:
> OK, embarrassing. 09c9957 completely breaks smart http pushing. My
> testing of Johannes' patch was completely focused on the error case, =
and
> I didn't have a single test for the non-error case. And on top of tha=
t,
> we _have_ nice tests in the test suite to catch this, but obviously
> neither I, nor Johannes, nor Junio were running them (because they ne=
ed
> apache installed and GIT_TEST_HTTPD set).

Wasn't someone, I _think_ =C3=86var, or maybe Avery, (I could be totall=
y
wrong) running a buildbot of git.git on various platforms? If so,
maybe they can turn on these tests since they aren't often run?

--=20
Cheers,

Sverre Rabbelier
