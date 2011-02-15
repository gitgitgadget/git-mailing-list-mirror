From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 18:07:19 -0500
Message-ID: <AANLkTikUMoCC2-+oqX1dngC-zsSpx+T6gq2+o_r6B0uE@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-2-git-send-email-jaysoffian@gmail.com> <20110215221832.GA826@elie>
 <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:07:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTzv-0007c2-08
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab1BOXHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:07:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61113 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1BOXHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:07:49 -0500
Received: by iyj8 with SMTP id 8so597492iyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=V1LoPHgIkqoMgiVFh6O1+GdymIO8X24beifu+mJ0Omo=;
        b=vQKYMXvvFxOfHO9cK//LxtySaRs0XDTuh/mVTxZ0iPmpEcbVUjRBf+saRAhf+X32yU
         uitv3mF35lSOqo6w10Wn8Tc5/J+LzD0fxSJ9qeLJ6tNgJJFb8EDWsonottw7GT63U6QX
         APWxw+kYRWox7DzSwr4BlFOy3nr1NdFDoFS6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YNKPkNXcB3l1IoNNiu+gbOrludDo+OKaW7whbo+s0fBTRDWr9nvikjlOxHN+sjf1hq
         8RGUvfnqXK+FfJ9K2W1Lf+h2Bly4qoqVOaWrJ9KZnsUDWYtgOnfKML/K2OrTPkXhsUTV
         hFc9yvdtpO6khvYK9VkGGordRdtH1LaU2SFi0=
Received: by 10.42.226.69 with SMTP id iv5mr5392923icb.43.1297811269437; Tue,
 15 Feb 2011 15:07:49 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 15:07:19 -0800 (PST)
In-Reply-To: <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166895>

On Tue, Feb 15, 2011 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I wonder if cherry-pick shouldn't also write MERGE_MSG or similar so
>> that gets taken care of automatically? =C2=A0That would also allow o=
ptions
>> like -x and -m to work better.
>
> Hm, that probably is a good idea.

I must not understand what either of you is asking. MERGE_MSG is
written by cherry-pick already, it's just that it's ignored if you use
commit -c, as cherry-pick advises. (Before this patch series anyway.)

j.
