From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu, 3 Sep 2015 16:39:19 -0300
Message-ID: <2CFFD89E-7059-4C1C-B715-15C5F6C2D295@FreeBSD.org>
References: <1441298147-83601-1-git-send-email-garga@FreeBSD.org> <xmqq7fo7jp1e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 21:39:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXaM5-00021Q-HB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843AbbICTj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 15:39:26 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34564 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbbICTj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 15:39:26 -0400
Received: by qgez77 with SMTP id z77so37654195qge.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Gz5sBzUHtcqABsAgWQgQ8iZ+hoOgZg1HROXTiF9YYA=;
        b=kAvX3kL/3QNxsD/mh0ZdqyBZnsf5OULxICuPCe5ytOYDJxXcH2u4uRivyOHy+CTFVp
         w+ZXOjZ4B5d8nlivAb019u12RXvA7QpUEFGb6+1ROCyKJsimgGzVPqLFUou/8Hd2Buji
         QNprmZTuZk33fxsY38vQ+UY0o8b3k9e2sgMoePOPnONJ7I5Kn95gTQUvx1MqGTfIMYhN
         JFuZxRui1usD1/gmuimgpbZsyTUaEvKlHNwVaRIqLTM+ppeVbJ88NSpnHaMUDo8SPiqg
         YRapVNT3vmSgBdtg4YaAt5VpiN9SkXxkeQ2eh3VdqyGi0QKjUZHK313eSik1S+YTQblL
         ompA==
X-Received: by 10.140.201.66 with SMTP id w63mr74201216qha.36.1441309165418;
        Thu, 03 Sep 2015 12:39:25 -0700 (PDT)
Received: from mbp.home ([177.131.95.241])
        by smtp.gmail.com with ESMTPSA id h48sm8144449qge.21.2015.09.03.12.39.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 12:39:24 -0700 (PDT)
In-Reply-To: <xmqq7fo7jp1e.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277243>

> On Sep 3, 2015, at 16:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> garga@FreeBSD.org writes:
>=20
>> From: Renato Botelho <garga@FreeBSD.org>
>>=20
>> git-submodule and git-request-pull are written in sh but use perl
>> internally. Add them to be replaced by unimplemented.sh when NO_PERL
>> flag is set
>> ---
>=20
> Missing sign-off.
>=20
> You also may want to hold off the "git-submodule" bit, as I expect
> http://thread.gmane.org/gmane.comp.version-control.git/277128/focus=3D=
277129
> would be one of the first changes to be in 'master' after the
> upcoming release 2.6 (that is, it is likely that perl dependency
> would be removed in 2.7).

Can=E2=80=99t we add git-submodule to the list now, for 2.6, and then r=
emove it when this change is pushed? This would help to have a sane tar=
ball for 2.6. I=E2=80=99m considering this from a package maintainer pe=
rspective.

I=E2=80=99ll re-send it with sign-off.
--
Renato Botelho
