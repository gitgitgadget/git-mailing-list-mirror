From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH V3] git-send-email.perl: Add --to-cmd
Date: Fri, 24 Sep 2010 16:47:36 +0000
Message-ID: <AANLkTinGZ1H3ODYwRhvzya_UkA8t2QTW7cEyjb2Hx_7M@mail.gmail.com>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	<AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	<1285227413.7286.47.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	<20100923090931.GA29789@albatros>
	<20100923120024.GA26715@albatros>
	<1285253867.31572.13.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	<1285262237.31572.18.camel@Joe-Laptop>
	<AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	<1285263993.31572.25.camel@Joe-Laptop>
	<AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
	<1285267520.31572.34.camel@Joe-Laptop>
	<7v62xwqe7i.fsf@alter.siamese.dyndns.org>
	<1285291098.25928.220.camel@Joe-Laptop>
	<m3lj6rgnub.fsf@localhost.localdomain>
	<1285344394.11616.23.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Julia Lawall <julia@diku.dk>, git@vger.kernel.org,
	Vasiliy Kulikov <segooon@gmail.com>,
	Matt Mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 18:48:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzBRW-0005Ux-G6
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298Ab0IXQrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 12:47:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44876 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933268Ab0IXQrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 12:47:37 -0400
Received: by pzk34 with SMTP id 34so681750pzk.19
        for <multiple recipients>; Fri, 24 Sep 2010 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rf2Y7qoamyWak8b6IapVLLAoG7CiwMk6yZizaO/KZ74=;
        b=Dt2jgA9uycv6DVmTYoXQmytoKVeOUJCQNsGYLYJOMdOyJbr0O4qaHBiw06IUEL9Hwn
         /QNN8wz8pWKoOtFjyf9EJ/qfs7mgu4SrEdkpK4uiBSTPHdi+I5BNIoAcmSAmqhXM4Kp/
         Np44rmTYmdqcwTjegGfE8Uk3+3+1KfCn7+kmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JO8HfehSq+Rg6G4Z9Mpa4cyfI0/L41QBbPUqJ/NPCKpPBWCOpZB5No7Qdkmz0XaTp2
         u4R0gHdo+hDCzXygn5HULgWGqc/fME9Ew8WTPGaAZvkStdPBZvykZtaBvo0hDzlht/1m
         3h125d78bI82T39sM8WvA78C28NMzP4uR6YpQ=
Received: by 10.114.61.16 with SMTP id j16mr3900762waa.143.1285346856365; Fri,
 24 Sep 2010 09:47:36 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 09:47:36 -0700 (PDT)
In-Reply-To: <1285344394.11616.23.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157023>

On Fri, Sep 24, 2010 at 16:06, Joe Perches <joe@perches.com> wrote:
> On Fri, 2010-09-24 at 08:32 -0700, Jakub Narebski wrote:
>> Joe Perches <joe@perches.com> writes:
>> > +# Execute a command (ie: $to_cmd) to get a list of email addresse=
s
>> > +# and return a results array
>> > +sub recipients_cmd(@) {
>> Do not use subroutine prototypes: they do not do what you think they
>> do. =C2=A0In this case using prototype is unnecessary and can be dan=
gerous.
>
> It can be removed. =C2=A0I was following the form of the
> other returned array in the code.

While we generally follow the rule that you should use the style of
the existing code, I think resaonable to discard that when the
surrounding code with less than wizard-level understanding of the
language.

In any case most of git-send-email.perl doesn't use prototypes, it's
just 2-3 subs out of ~30.
