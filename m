From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict resolution
Date: Tue, 19 Jul 2011 18:04:00 +0530
Message-ID: <CALkWK0=7OcEEkf2qxSMvG0=W+M=nEJa6shMp7LffokX=yPxLPQ@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com> <20110712193716.GB14909@elie>
 <CALkWK0nyu6W2Nd=qcrjZZwkAdFGqTqAe53FmecS_n2cK_4UWMg@mail.gmail.com>
 <20110717184057.GD27787@elie> <CALkWK0kZ3nWnnGe1OHXWgiZ8ik9iNW803wi2d6kUiNDpiOWNDA@mail.gmail.com>
 <20110719122102.GA26330@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 14:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj9VL-0000ta-54
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 14:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab1GSMeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 08:34:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1GSMeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 08:34:21 -0400
Received: by wyg8 with SMTP id 8so2739940wyg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2xs5YTQRDGsn6yiEkuPcXcTElk5RuoZtfk2/DFkKIPo=;
        b=C7hg2aD+MIHBmW1Adl6nb5V9y2r8Uh5T0o5NFV1E21q2RL8/bSXLuy8L968OX6UQVW
         8xOAYRHqYgx1skMhU0gAgxgVIdciL+c4svMRGaf6nnv1Ae9ErQe1P96eMdaarSm4Q0gc
         GZqv1/kxLzcBhHCiI2bQ2/ZlR2Q5FzAR3ild4=
Received: by 10.216.143.66 with SMTP id k44mr677524wej.81.1311078860132; Tue,
 19 Jul 2011 05:34:20 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Tue, 19 Jul 2011 05:34:00 -0700 (PDT)
In-Reply-To: <20110719122102.GA26330@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177453>

Hi,

Jonathan Nieder writes:
> Maybe
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: cannot resume a cherry-pick with "g=
it revert --continue"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: unusable instruction sheet

Good suggestion.  Implemented.  Thanks.

-- Ram
