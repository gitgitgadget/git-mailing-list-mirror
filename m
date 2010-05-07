From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Make test-lib.sh emit valid TAP format
Date: Fri, 7 May 2010 21:50:21 +0200
Message-ID: <v2sfabb9a1e1005071250i5cfbcb93qbbed103d1d8c73d6@mail.gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 21:50:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATZS-0007h1-Kr
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab0EGTup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:50:45 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52696 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab0EGTuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:50:44 -0400
Received: by wwa36 with SMTP id 36so264745wwa.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EdGuyd4AzpyGRXGYk/GtsFTwAAKxuqn0pTgnTt2tbTc=;
        b=X0sccfQN2+sB5ZXri7C5KQFd3Kai+GKCVKrA7MpmhME9VYl5FMPNCJC/TvTYDcmOBw
         /wzKruOMnL4D0NJzX8hJmRJE//D5wtuGzzwjTW2zH46VC8+77/Ic/qSoP17tVzIbYTQv
         +5+nFuILPiYGXxxT7RoOOMnOPReXJZwJDvdlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lVX2Nj2RZGIK8RzmZdwd5MVMRYNw8Mtq0mMLF9J7UD/ZQ3vq8c8z7zvrbAFMAadMdj
         cnE/3GIk+ixuSJvO1+9VX3v6jvxPPnrPZvs+LORpiARE2VVhe8yigizjR7n+b2EyxfVt
         /LfV6Krp7j0SRq+ouCHIe3W1Z9ntivssaORMM=
Received: by 10.216.162.147 with SMTP id y19mr388097wek.0.1273261841425; Fri, 
	07 May 2010 12:50:41 -0700 (PDT)
Received: by 10.216.60.147 with HTTP; Fri, 7 May 2010 12:50:21 -0700 (PDT)
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146574>

Heya,

On Fri, May 7, 2010 at 21:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On my quad Xeon server running the test suite with `make test` takes
> 21 minutes. Running it with `prove -j 15 ./t[0-9]*.sh` takes just ove=
r
> 5 minutes.

That's not a fair comparison, how much does 'make -j 15 test' take you?

--=20
Cheers,

Sverre Rabbelier
