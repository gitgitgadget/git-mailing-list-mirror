From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig reader
Date: Fri, 4 Sep 2015 09:49:16 +0200
Message-ID: <BD5C97C8-DA84-4DC2-8745-893510F1D4ED@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-2-git-send-email-larsxschneider@gmail.com> <55E8A5C2.9090500@diamand.org> <A76D6BC6-E0AD-48F4-AE33-80BD0803BFA3@gmail.com> <xmqqmvx3i7dg.fsf@gitster.mtv.corp.google.com> <6FAAE139-9010-4C68-AA97-2739E9A09564@gmail.com> <xmqqio7ri40h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:49:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXlkQ-0006xw-GF
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 09:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693AbbIDHtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 03:49:19 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37269 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbbIDHtS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 03:49:18 -0400
Received: by wicfx3 with SMTP id fx3so8712469wic.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+FLbCLSyIT1aYmJ3yV5xLxMumkpDDqfNpRkhmgV5ajs=;
        b=0Eh15JyF0O8CInBQcS0ar8YdU9/qaHh6ZKLOUh1Gj31L28sZeJjyUjVe7+06ajmBN8
         LDpCVTuUFn/ZzCLKNM1W3LDkIVjleNjHDfTrAtTGJ4lX4U32GGcAcg3QryuRiX+P/TuH
         CuyjH8hHfaX6nDKE3fjS1RR/XCJoqSccKgyTGy5VM9SgIInKJKUCmf6sXcN5LdJgf3aL
         weUfHm4ez9NA2jnK/qRqebiBBzEY8UU8LJIPpH9MRNuK3+pH2RGCpJPhXJtnbbVcJQYo
         TaA35wwyJXKYDmvu9rlGke9L4fWbioMojEHN5fg6of0CFcYYedRTs8+yB/Njwdf4R5mg
         Ka+A==
X-Received: by 10.180.211.11 with SMTP id my11mr4581373wic.51.1441352957282;
        Fri, 04 Sep 2015 00:49:17 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-094-223-088-076.094.223.pools.vodafone-ip.de. [94.223.88.76])
        by smtp.gmail.com with ESMTPSA id fz5sm2713744wic.18.2015.09.04.00.49.16
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Sep 2015 00:49:16 -0700 (PDT)
In-Reply-To: <xmqqio7ri40h.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277291>


On 03 Sep 2015, at 23:31, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> In case I agree with a reviewer. What is the more appropriate action=
?
>> A response like the one above or a new role that includes the change
>> right away? I don=92t want to spam the list with lots of tiny change=
s=85
>=20
> Responding to review comment like you did with "will do" is
> perfectly fine.
>=20
> When you do think you will (eventually) want to send an updated
> patch, there are things other than "will do" that you can say.  "I
> understand what you said, but I am not sure how exactly to make this
> better.  Perhaps lend me a help?" is good, too.
>=20
> An explanation, followed by "ok?", in response to "it is unclear
> what you are doing here" (commenting on code) or to "I cannot
> understand what this is trying to say" (commenting on log message),
> is problematic because your intention becomes ambiguous.
>=20
> The reviewers are rarely saying "I do not understand; educate me."
> but "I do not understand, and it is likely many others don't, too.
> Make it more easily understandable." is what they mean.
>=20
> An explanation with "ok?" can be taken as a sign that you mistook
> the review comment as "educate me".
>=20
> 	What I meant was ....  Do you think commenting the code here
> 	with the above description is good enough?  Or do you think
> 	of a way to restructure the code itself to be more self
> 	evident?
>=20
> or something like that may be a way to avoid the ambiguity.
>=20
> Thanks.

Thank you for the explanation! :-)
