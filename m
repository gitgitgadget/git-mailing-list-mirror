From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: make last_exclude_matching_from_list() run til
 the end
Date: Mon, 31 Aug 2015 17:13:26 +0700
Message-ID: <CACsJy8AwV9J9hs4uyZ0eCy0vFMat4dYaQy+6mVkcK7KvRw2bgg@mail.gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
 <1440334214-32131-2-git-send-email-pclouds@gmail.com> <xmqqmvxfxgdj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWM6C-0002aF-9l
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbHaKN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 06:13:57 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34868 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbHaKN4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2015 06:13:56 -0400
Received: by iog7 with SMTP id 7so28986877iog.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=24LqzPsrVKto72zR3Q+WSHnwUojZzjwunClJCQTYSvE=;
        b=P3rxEc8owbGQKrNZFHUwZbGnOYuMv7GSa+hJ2KfGPfpiqFTOOk8hyKn816aLq710A3
         i5KTqLYc3NgW25HQG+MC/DVrnatSfPKFc3Dg7sEcPRosraV+aWYxbhu8CHXmbj4Euhrg
         ncknuLeOl1Lyp0mKp+HmCXtqAbBZGoi/UR+hKzGH8WqtwLvgATk6K3F/5L+2PV16nFoB
         T5NxJyN+S1+zCdU90QhuwEri0ZTS4zyJg7j5q2KDN7W35lVbL5WhuT6vOP19iCEKaREC
         zbPMtwMymhyxLQ1VgrNJskMbmXEKCOlxZDJ1IsRrLx/qHOP0vytJVgMy0HNIUFAO/nKE
         CsdA==
X-Received: by 10.107.9.11 with SMTP id j11mr22503040ioi.191.1441016035876;
 Mon, 31 Aug 2015 03:13:55 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 03:13:26 -0700 (PDT)
In-Reply-To: <xmqqmvxfxgdj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276866>

On Wed, Aug 26, 2015 at 3:28 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> Because?  Title just tells what the patch meant to do (i.e. instead
> of returning it keeps looping), but does not say why it is a good
> idea.  Besides, this a no-op patch and does not make it keep looping.

Because the next patch adds some post processing before returning the
value. Having all the paths come to the same point would simplify the
code. Will update the commit message.
--=20
Duy
