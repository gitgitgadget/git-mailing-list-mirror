From: Thomas Schneider <thosch97@gmail.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Wed, 25 Mar 2015 12:43:57 +0100
Message-ID: <CAJUTLVXC7b4svJ0N4sQGm3+eRpjcQ_8eSv0vSYff=K_x_7mO3A@mail.gmail.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
 <CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
 <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com> <CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com>
 <xmqqmw37cn18.fsf@gitster.dls.corp.google.com> <55103565.9040000@drmicha.warpmail.net>
 <DA8ADE6265034B1186A4D63318C6EF3C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 12:44:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yajk0-0008Gg-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 12:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbbCYLol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2015 07:44:41 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35914 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbCYLok convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2015 07:44:40 -0400
Received: by labe2 with SMTP id e2so17308399lab.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gN2MqCYeOlgoDxfx049G4qsa34qmiy8GZssyjjH0k60=;
        b=MMezhA6bNRMAutsO0NWFMl27VOz19FPOeIo2tY1ymzsLfKcWIGpr2YfPEopFOAZI6Y
         xO0myRmSm0fXtzJyOOgmbncZAdAq5Ws9Cesa+zkbvUPXpFcdtc3rQDeW9oWh3T6OH7M1
         sos7vPSJ45HFGJe0k7dgHQC0HM6y9aKeGc94+KGS5u92DXRw2kh1ym+ONqGPWE8WSSyS
         4IhsTaP+ohUGY4IPC4pe6QlgLiwzA6CDAALfvZGx5EFpTO3e8pYrCSwrYo3LZylG/SxX
         zkRxnP30ro76HCj7RvbbuqHvD55f82pZ4oDuZ78lvnCQE0Kij4HRAGMfpau6FU3jWqd5
         uf5A==
X-Received: by 10.152.42.141 with SMTP id o13mr1199323lal.79.1427283878197;
 Wed, 25 Mar 2015 04:44:38 -0700 (PDT)
Received: by 10.112.63.199 with HTTP; Wed, 25 Mar 2015 04:43:57 -0700 (PDT)
In-Reply-To: <DA8ADE6265034B1186A4D63318C6EF3C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266279>

Philip Oakley <philipoakley@iee.org> wrote:
> I'd expect 'git help --pdf git' to simply feed the path of git.pdf
> (probably in the same directory as the .html versions) to the web
> browser and let it determine the users prefered reader.
Yes, this is what I would do as well.  Unfortunately I don=E2=80=99t re=
ally
know C, so I can=E2=80=99t implement this.  But for someone who is fami=
liar
with C, it should be easy---just call `xdg-open` (X11), `open` (OS X)
or `start` (Windows) and thus the user=E2=80=99s preferred PDF reader, =
and
maybe some common programs (evince, okular, =E2=80=A6) as fallback.

Junio C Hamano <gitster@pobox.com> wrote:
> I didn't see (and I still do not quite see) why people would want to
> have separate pdf files for all the subcommands (instead of say an
> .epub or .pdf that binds all the man pages and perhaps user-manual,
> just like we do for .texi/.info).
Because it=E2=80=99s a good start :-)
I see your point, and I agree that a combined PDF/EPUB/etc would make
more sense.  This should be not too difficult with the
AsciiDoc-DocBook-Toolchain (or maybe even without DocBook), I just
need to dig into it a bit further.
