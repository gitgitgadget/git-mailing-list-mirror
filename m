From: Martin Langhoff <martin@laptop.org>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 18:50:09 -0500
Message-ID: <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
References: <4D0ED5EC.9020402@burntmail.com>
	<20101220213654.GA24628@burratino>
	<4D112586.2060904@Freescale.com>
	<4D119015.6020207@burntmail.com>
	<4D2AB63D.7040803@burntmail.com>
	<AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
	<4D2FEF49.8070205@burntmail.com>
	<20110114074449.GA11175@burratino>
	<7v8vynnokt.fsf@alter.siamese.dyndns.org>
	<4D450655.5090501@burntmail.com>
	<AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
	<7vhbcb35xk.fsf@alter.siamese.dyndns.org>
	<4D5E1116.7040501@burntmail.com>
	<7voc69p4xu.fsf@alter.siamese.dyndns.org>
	<4D5F6E97.4000402@burntmail.com>
	<7vy65bkw72.fsf@alter.siamese.dyndns.org>
	<4D61EA4B.3020708@burntmail.com>
	<7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
	<7vipwbbrcc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guy Rouillier <guyr@burntmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 00:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps201-0002j6-JN
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab1BVXuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:50:15 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43959 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab1BVXuL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 18:50:11 -0500
Received: by yib18 with SMTP id 18so3253421yib.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=of3EBlx9wwr20DqxBXQt8h4noVeuzokKcjAKDeaQcYs=;
        b=dylVQysodjH9yptKVP0D2ARHtwNFypYMfdNVXTnvWZDhml1E8ILIgFmOwHadg9ezTS
         r2/gI3Q/23pI0hejPT1Xape2AYqdfSVkCnlDyYVl08PelV7rzX9SgIjc7VI1uNmFqLx2
         3hZDVyAl8lLtTJQSC6RfTvUZjORe00gPMzPfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Xx2BNLdqgiBTX8+I+MWbgNawWagoTzRHNg4tMM27L49KWLXm+J6nbxTw7QvtQMiXkH
         osc8ENFIfArKfy9DPRInBj5DApQxnNseBGIo/AMjsLHfpjooZRjfpp1rcZhaSacldeYp
         Y2ddQnZ1CclJuDjCGXy0z2t2jGshfnKQl9VgI=
Received: by 10.90.32.16 with SMTP id f16mr4348751agf.202.1298418609564; Tue,
 22 Feb 2011 15:50:09 -0800 (PST)
Received: by 10.90.33.13 with HTTP; Tue, 22 Feb 2011 15:50:09 -0800 (PST)
In-Reply-To: <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: tFPkTmtgUlufZwFHzv0ze8PUdu0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167663>

On Tue, Feb 22, 2011 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Even though I don't deeply care about what CVSNT does...
=2E..
> Does anybody know why? =A0Only to make things incompatible, perhaps? =
;-)

A brief googling around shows that it also stores it in the Windows reg=
istry.

Should we support that too...? ;-)


m
--=20
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
