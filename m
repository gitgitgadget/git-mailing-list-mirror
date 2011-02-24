From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Wed, 23 Feb 2011 21:14:14 -0600
Message-ID: <20110224031414.GC7970@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
 <7vd3mi44gx.fsf@alter.siamese.dyndns.org>
 <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 04:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsReu-00027V-JW
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 04:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab1BXDOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 22:14:21 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61029 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab1BXDOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 22:14:20 -0500
Received: by qwd7 with SMTP id 7so97235qwd.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 19:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ybh2zA3EPpDvlL7DTlWDob4rv0YWJnzeqOnTMvgGecE=;
        b=GsOOJyaAo4dH2K3aQfDaaQatynTFzd5RN3oUjRiDBh28iH0jSR50ZL6MTHfMFLaUfF
         OZpDUjqvaUCOwxItXqdrFEHtn4CSBINHJf1EVeq3IKJZzEg0N1igcbvyzw6DkU+39Fu3
         +j1ITQfVxoQk0n43wZ/u2rrVaOpRuyYNn23Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=R4kfYLE+l0w4uLQt8oXrGZ5Zx7lOT87/kWw5RN4nPptm2rvdIT/4RHpO601tzvMUZS
         R7GnhY2nePrPn2dlxckE3Tay982kEvHht/5rVwjFzN9Mh7R53sgx/tBKRlbPtbGcXLLz
         tYoVUW2kXmrWpmOd6zA1xad2JQcTEr8I9v14A=
Received: by 10.224.28.129 with SMTP id m1mr247856qac.87.1298517259394;
        Wed, 23 Feb 2011 19:14:19 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id h20sm6007531qck.12.2011.02.23.19.14.17
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 19:14:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167771>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Anyway, to be blunt I really don't see the point of fiddling around
> with this bit so much. Whether it's a `"GETTEXT POISON"` constant or
> `rot13(msgid)` the same tests will fail.

Because with rot13 you can decode the message and find the problematic
code?

> If someone else wants to do the work I don't care. I just think
> there's more important things to worry about.

I already wrote a patch.  I imagine you don't intend it this way, but
I keep on hearing "we shouldn't do what you've already done.  It's too
much trouble.  You wasted your time."
