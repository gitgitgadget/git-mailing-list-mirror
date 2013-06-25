From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: Re: [PATCHv3 00/16] bash prompt speedup
Date: Mon, 24 Jun 2013 23:00:48 -0300
Message-ID: <CAOz-D1LN08R3hJeNMop+_POADC=iP8MLTXUZR5VW5jBtrVppzQ@mail.gmail.com>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 25 04:01:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrIZG-0003bc-GX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 04:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab3FYCBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 22:01:10 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52200 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3FYCBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 22:01:09 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so26769044iea.31
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MhW0r+Qq10rEkru9mUKDdP20Hjej8EemxYGi9wvVZFE=;
        b=j5Ma7R9frSj+VsnsHEt5jXioxjXkUReQBgYaGDURLhtpCIIlKdcgioOSolJp9jJsYC
         5voEfqYojyqtmL79YaeGCrrBrZgKEvlLqF3/EnIqs+mhHlQ5qY1wsGEsGdy20tAzwCj3
         ag85arNemYzUIgAhAZmLAcxnln6Rl4htcfTJ9P90H9kp0zKHuagOOJLoYWB6ZspvINvQ
         0v6RRlDZZLZcTn45I/qFRkamAxWuAHdr0HnNvTeVOVxkl1f9L747eFpOgkgtp7PNVTng
         P9shqzIIJ13HKw3bw/dky0MBbz0ujHRHPQWssXsuRpQ28QvQzh2Nl6gvWEKJlkOWDh4v
         6rTA==
X-Received: by 10.50.111.104 with SMTP id ih8mr7326379igb.28.1372125668908;
 Mon, 24 Jun 2013 19:01:08 -0700 (PDT)
Received: by 10.42.249.197 with HTTP; Mon, 24 Jun 2013 19:00:48 -0700 (PDT)
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228940>

2013/6/24 SZEDER G=E1bor <szeder@ira.uka.de>:
> This patch series will conflict with Eduardo's work on refactoring th=
e
> colorizing function, and the conflict is not trivial.  Although there
> are still some open questions left with that series (using tput, zsh
> tests), those won't affect the conflicts between the two patch series=
=2E
> So, for the convenience of our maintainer, I picked up Eduardo's
> series, took the liberty to apply a fixup commit on top with my
> suggestions from [2], merged the two series, and published the result
> at:
>
>   https://github.com/szeder/git.git bash-prompt-speedup-and-color-ref=
actorization
>
> Eduardo, could you please also check that my conflict resolution is
> correct?  Thanks.

G=E1bor, the conflict resolution is quite correct.

Thanks,

Eduardo
