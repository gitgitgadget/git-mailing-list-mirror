From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 21:00:29 +0700
Message-ID: <CACsJy8Bgzkc51N+t=0NyOasJRd2y3U+pyZCGa-qGoDuTQuyOgg@mail.gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com> <1338469482-30936-3-git-send-email-pclouds@gmail.com>
 <20120531134538.GA10523@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 16:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5w3-0001cQ-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068Ab2EaOBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 10:01:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62964 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab2EaOBB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 10:01:01 -0400
Received: by wgbdr13 with SMTP id dr13so930185wgb.1
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tcaEdiGeW3+dGcM7FB4pWg0eGuqEwKHJDMH4Y/G6TxA=;
        b=nJS0s8oXlXKl9QjezhmpJNOOlwcFvUnz0aFK31kumOkk9a/cF7997e/9bByHNJoESs
         oBUHdSat6lbwUMPIp11XCY24PIX7y3OSK2hzYpl878tktQSQAIMTscwjneG1heJ/E25L
         C2Est+WpyrVVkpeTS1q2bQXD8avnu+aHy/7+ni6TfQcaDtp1M7qTwq+7VoSsKSpOzw+j
         DF+CRdqDuAN/AxXMOBuyX6xHAwRi9A9BoU+DxH167xZO+30aMI+nUu06ULqOuleZFxD+
         7i9sA7zVeixTCxfdPgGwNPLWiCZqCtAsDFPJDymQ1wGtJIGWiMR5lkgUPOpACcD4vPD/
         FHdw==
Received: by 10.216.226.218 with SMTP id b68mr13987051weq.167.1338472860220;
 Thu, 31 May 2012 07:01:00 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 31 May 2012 07:00:29 -0700 (PDT)
In-Reply-To: <20120531134538.GA10523@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198903>

On Thu, May 31, 2012 at 8:45 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Thanks. =C2=A0Style: how about
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cb->newlog)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("would =
prune %s", message);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (cb->cmd->verbose)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("prune =
%s", message);
>
> ? =C2=A0I think that would be more readable than the lego original.

thanks

> BTW I'm not sure if this message would be a good candidate for
> translation. =C2=A0Especially in the --dry-run case, it feels like ou=
tput
> that is intended to be simple enough for scripts to parse. =C2=A0(Tho=
ugh on
> the other hand, I don't know of any scripts or use cases that actuall=
y
> parse it, so maybe nobody would mind.)

it's gray area. reflog is not categorized as plumbing. Maybe adding
--plumbing for scripts?
--=20
Duy
