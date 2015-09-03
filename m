From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu, 3 Sep 2015 17:02:38 -0300
Message-ID: <86C44806-98FB-4E67-83DF-197103B48BB2@FreeBSD.org>
References: <1441298147-83601-1-git-send-email-garga@FreeBSD.org> <xmqq7fo7jp1e.fsf@gitster.mtv.corp.google.com> <2CFFD89E-7059-4C1C-B715-15C5F6C2D295@FreeBSD.org> <xmqq37yvjmza.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXaid-0004LB-TO
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbbICUCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 16:02:44 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:32918 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbICUCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 16:02:43 -0400
Received: by qgev79 with SMTP id v79so467491qge.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+EUAE6g7S3KFLANlazeaByoq5A3BvvNkM1M/Z5iaZy8=;
        b=KPzom11LuwuIVuD3n+EN0bOhM7zNGdSk8mX2UkvobAyNjSOr7y79ZNNcUUz/+HFcx2
         JdKi9UOOeZATjZPb6bFs4UUgPQgZdhoaF1xvqL9wm9NmBbgLFJp4al8Jx30K5Ne1se1m
         VTqGfg6I0QXz1cXCxhGcRzFJszOzDb5pr3HaBdzeJrMJZFVM1ykR5yuunPi3d9zFexdi
         2tkX7xU4ECp456a6EKZ/9rKEbkQWKhCoEadMdOujR9ydqqtBn7+LoSi9lXIjPM4kevbB
         h9YTC/FbdyQUNBHEgMA72Pb/KB83b5S3cXzQYa9TPG6tdxvfweE8feS1Y0jSLrJg/cnT
         dWFQ==
X-Received: by 10.140.234.151 with SMTP id f145mr73703674qhc.26.1441310562890;
        Thu, 03 Sep 2015 13:02:42 -0700 (PDT)
Received: from mbp.home ([177.131.95.241])
        by smtp.gmail.com with ESMTPSA id q45sm15510006qgq.0.2015.09.03.13.02.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:02:41 -0700 (PDT)
In-Reply-To: <xmqq37yvjmza.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277248>

> On Sep 3, 2015, at 16:56, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Renato Botelho <garga@FreeBSD.org> writes:
>=20
>>> You also may want to hold off the "git-submodule" bit, as I expect
>>> http://thread.gmane.org/gmane.comp.version-control.git/277128/focus=
=3D277129
>>> would be one of the first changes to be in 'master' after the
>>> upcoming release 2.6 (that is, it is likely that perl dependency
>>> would be removed in 2.7).
>>=20
>> Can=E2=80=99t we add git-submodule to the list now, for 2.6, and the=
n remove
>> it when this change is pushed? This would help to have a sane tarbal=
l
>> for 2.6. I=E2=80=99m considering this from a package maintainer pers=
pective.
>=20
> Not really.  Anything brand-new that comes this late in the cycle
> will not be in 2.6, so the earliest release this NO_PERL change can
> appear in is one after the upcoming release.

Even if it=E2=80=99s a bug that produce a broken installation?

Nevermind, I=E2=80=99ll add the patch into FreeBSD ports so FreeBSD use=
rs can have a sane package installed.

--
Renato Botelho
