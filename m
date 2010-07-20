From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 20:49:45 +0000
Message-ID: <AANLkTimjTxbw0FCujPNbkzuFAbdXZBgWMmDTQeAegvNq@mail.gmail.com>
References: <20100720163822.GA8492@localhost.localdomain>
	<0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
	<7veieym3sh.fsf@alter.siamese.dyndns.org>
	<AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
	<7v1vaym27n.fsf@alter.siamese.dyndns.org>
	<AANLkTil5eq2radUKvle7Ez48CDRfb8dvWcEobXzGaKNA@mail.gmail.com>
	<20100720191655.GA1705@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 22:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObJlB-0002Op-S7
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761537Ab0GTUts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 16:49:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40504 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758327Ab0GTUtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 16:49:47 -0400
Received: by iwn7 with SMTP id 7so6020844iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ER1OoOrnsYsMlhZh9PYm7jh+M+QCPVL/6XQmMvb0krk=;
        b=dUVaOhl2JpotZa/DO8YKIBvQmNqP2MoSRCg8Bm8H+Jtt1pVmvXrkSfqx1RjFXgpzE3
         WMQzQkCK8CP4Fveam/NF/BesVSTkr7qTgnKw/t/RkLAnucdeAZndhXnAA8/QARfaHMbF
         GA31bjASv5a/mk7JWqe5B3v3k2aw7jW51FDxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wcd8ckLSTWZB3R6hlbE0KReo8gR1yeMxr2ZyZYoASzXFz3OfCkiqI5Gw/8i/8oYwep
         8QJ4vUausH85kJLVgQ70uaQgZUwzIrYo6wCfbZPlxdT2wuMMv27dHrm8r+bLsG8ZWaul
         hlGy2K6QMg7eCmIwScKVitjsuI35ER+aMazHU=
Received: by 10.231.172.83 with SMTP id k19mr8385740ibz.114.1279658985747; 
	Tue, 20 Jul 2010 13:49:45 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 13:49:45 -0700 (PDT)
In-Reply-To: <20100720191655.GA1705@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151366>

On Tue, Jul 20, 2010 at 19:16, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> That's what we seem to be doing in the tests so far, i.e. test_must_=
fail
>> is reserved for git commands only.
>
> test_must_fail relies on conventions for return value that cannot
> necessarily be relied on from outside utilities.

Right, someone should send a patch for these:

    ack 'test_must_fail (?!git)' *sh

:)
