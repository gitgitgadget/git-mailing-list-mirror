From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Tue, 22 Sep 2015 12:11:11 -0700
Message-ID: <CAO2U3QgehMcBrDUtChLLrn5VrH4jLE0CF5xDSShY72yycLryCg@mail.gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
 <1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
 <xmqqio73abl0.fsf@gitster.mtv.corp.google.com> <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
 <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
 <xmqqbncv6yym.fsf@gitster.mtv.corp.google.com> <9F835973-7045-4AA7-A0B0-D3D3C6F25D73@gmail.com>
 <xmqq8u7y5toe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSyk-0005mg-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934544AbbIVTLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 15:11:34 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36504 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934362AbbIVTLb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 15:11:31 -0400
Received: by igcrk20 with SMTP id rk20so87131226igc.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Oyf/wKFGZgHDjLeAVOyK1px363aoPh2zi+TUWJVsLbw=;
        b=QokTggMeFGxyPFgtusHTkXQ9aPbe0mMjTGoXWnd2YCpPp0l6L2ysAJFsMZsbgew7ll
         EFoeLEW5lZ5DvshE92Ft4wTcUpyprwpYRm3mTcQTDVDDvusD9GJ7sb1ne2AdWutnNGc3
         SCJ/BaleJFdW1z3g1Fx/TkSvocacqdpc58xbprSP+4V+8oNdvlF3sxmqLWVSmMbeSLPb
         iGkbRTUEAoIsY0SL3sw8bn7HFk9vUsnuebO1y/we+Oshnbwdx11rL8isF3wXSbO5gUhK
         wwKQeV7pJFxhObMioc2UdqDM3waGN1JxvGaQlKQll2Ff6m8PuV/0ZY0Rzj/Wct7AJEdY
         lE6Q==
X-Received: by 10.50.17.4 with SMTP id k4mr19468337igd.34.1442949090858; Tue,
 22 Sep 2015 12:11:30 -0700 (PDT)
Received: by 10.64.87.234 with HTTP; Tue, 22 Sep 2015 12:11:11 -0700 (PDT)
In-Reply-To: <xmqq8u7y5toe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278419>

I'm seeing test failures

non-executable tests: t9825-git-p4-handle-utf16-without-bom.sh

ls -l shows that all the other tests are executable but t9825 isn't.

On Tue, Sep 22, 2015 at 9:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> This works.
>
> OK, and thanks; as I don't do perforce, the squash was without any
> testing.
>
>> Do we need the =E2=80=9C-e=E2=80=9D option?
>
> In syntactic sense, no, but our codebase tends to prefer to have
> one, because it is easier to spot which ones are the instructions if
> you consistently have "-e" even when you give only one.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
