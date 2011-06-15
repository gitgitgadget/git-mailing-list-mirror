From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 22:58:09 +0200
Message-ID: <BANLkTimSKGdRKCOzVWZ3gmX_xBUwHoDuaw@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
	<BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWxAG-0002Z5-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 22:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab1FOU6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 16:58:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62350 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab1FOU6L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 16:58:11 -0400
Received: by fxm17 with SMTP id 17so686568fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P8uhpqCcj2u2YcXLY7LsI8OvYZO4PxBw2mdbhvlSgo0=;
        b=S4bZ0KUL+/haLNEuxU8UpKACzaHcS/c4MQj8D/sOrABrcYhXmEv1GUQ4W5YgfPN+dw
         2f2ImQ4pkR7uEciLVhcjTK4ExF0ArEfLyVHJhsclRHFlawqnjOM9WkbY4Ilhn5rrxnCW
         ezrUIXg9AlCLJHpmA+4zu2lpXLKL5qY9JBksk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SLxcCBwHXOcsZSB/FhG9cDfDL2/JmfpmE9ZmRidu5ga3973x7cAIv+aLfl+xc7XMtq
         Nzh/9Ex1BDdiZSIgkZ5BZRfWlis1XKDOW8yMU4Z6eUBrv3Rvn1huHN+ovtT83VuhRrAO
         8NB0F9Gj6igSiFsSyFfbZ0aUwbL63AXJJEpx0=
Received: by 10.223.32.142 with SMTP id c14mr105203fad.59.1308171489823; Wed,
 15 Jun 2011 13:58:09 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Wed, 15 Jun 2011 13:58:09 -0700 (PDT)
In-Reply-To: <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175851>

On Tue, Jun 14, 2011 at 11:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

To clarify a bit. I think it'd be great if we can get more
translations through any scheme possible.

However, I'd personally prefer if this was delayed a bit until the
outstanding po/*.po patches I have have landed in master. I already
have those locally ready for submission, I'm just going to submit them
after my current series hits master.

The timeline on that is entirely dependent on when Junio merges my
patches down.

But that's just my 0.02c. I don't think I own i18n in any way, so if
someone wants to set up some web ui, gather PO files, and submit them
that's great. More power to them.

> =C2=A0* Any way of editing the translations will have to comply with =
git's
> =C2=A0normal patch submission process.

Also, I just mentioned this because those are our existing patch
submission guidelines, which I thought would be reasonable to assume
would be the same in this case. Whether we observe this I think would
be something for the maintainer to answer.

Personally I think signed-off-by is silly, and wouldn't mind if we got
new translations in one giant commit with a crappy commit message, but
I didn't make the rules.
