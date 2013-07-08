From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] prompt: do not double-discriminate detached HEAD
Date: Mon, 8 Jul 2013 19:19:07 +0530
Message-ID: <CALkWK0nB3MBw0xKx29BH1_0Yq7eF61Jx7ANP5tyadezkmr35sw@mail.gmail.com>
References: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
 <CAEBDL5UfHpR3GNeqbDf9X3Ya+Spcpx0Byq5MZPMMsE=a3y2jhg@mail.gmail.com> <7vppuu45q8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Szakmeister <john@szakmeister.net>,
	Git List <git@vger.kernel.org>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBpA-0002Q2-9o
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab3GHNts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 09:49:48 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45521 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3GHNtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 09:49:47 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so10297127iet.9
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Flh8lFlcp1Fdk+SPz/2b6losMMqf83S1hBTV/3WX438=;
        b=1Ie7LWZz4qTL/Ir87lap83V89OP8qa0cTidsiHIzlRi1TkM6RKgP331uMitckv/MGt
         PHItD3wf6t0QuVldJJ63iyg1+OnpVSQBQF3pVd3TB3JQQy8LiTwssb4wLED+g1tSDTj8
         yvkehT1TYrmccK/G4W9S3Le/TNdQjJ5mkob2etIgdkJ/Egn/Wuk1riWn6CyJhFoB/h+u
         OmGeywhoxWt087mz8sypN1KBKdADY/gUnD5rbCVSURUvJdUXqpGgizYoyB1/ROqMnY2a
         Lw22ak65wGerXIQrLSN/+tW3VZ8PCXkQRW0blkhNZXj2gqoh9Qcx25RUJkiqeuRIYJuQ
         U75Q==
X-Received: by 10.50.72.73 with SMTP id b9mr32089223igv.50.1373291387412; Mon,
 08 Jul 2013 06:49:47 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 06:49:07 -0700 (PDT)
In-Reply-To: <7vppuu45q8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229856>

Junio C Hamano wrote:
> +1; I find red on many terminal emulators to be too dark to tell,
> especially in a small font, from black myself.

It's a matter of taste anyway.  I hope everyone's not going colorblind
from writing too much C89 and Bourne shell ;)

Eduardo R. D'Avila wrote:
> I think color in terminals should be used to highlight and make it ea=
sier to see
> textual information, not to replace them. So I would keep the parenth=
esis.

I largely agree, but there are a few exceptions.  Most notably, have
you noticed how, in addition to font-locking, scheme-mode replaces
lambda with =CE=BB?
