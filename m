From: Patryk Obara <patryk.obara@gmail.com>
Subject: Re: [PATCH 0/2] commit -t appends newline after template file
Date: Thu, 28 May 2015 12:06:34 +0200
Message-ID: <CAJfL8+QueOnGwPu0vkpSkWDqPnYYtqdM0mHRWEC8Bad4wuvC4Q@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 12:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxuiV-0002uq-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 12:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbbE1KHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 06:07:07 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35538 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbbE1KHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 06:07:05 -0400
Received: by wicmx19 with SMTP id mx19so140573359wic.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=FKajJpgDrv0imM5uv3T8Y1dBbXwchZ0dVz4LC1JOrbo=;
        b=SqsTrFNjRHt1x6q5oBeOo8xFJHGWHaJvZ4RERk/xLaYHa4XzBEmEIV8YuWsm1opsDg
         rcB0h4KwLaonfxZJlqK8i8Pn3Yo8DKMOr/m5AsVbNUt3cZ8Uee21CJtWprQ4/Gi1gJ35
         a+day/zBKOlh2HIGSJG//pwv8vrH3bUU11c+zG0MbgLo6/tYz2X/aDkSZkleQEjZJKk+
         fqkv6e4gyd7rE0xcFNjG9+VWtGjvlajiT98WMjir1NENgSTi+/76R34Qr2rc+RByr659
         /NtMuIvrt1QfqQIHAq6wXLY6rXhcgpo22yH2YK5nAYeOlmYtc0DtPX032cwmrfDf2kC+
         Qx4Q==
X-Received: by 10.180.84.170 with SMTP id a10mr14933136wiz.52.1432807624346;
 Thu, 28 May 2015 03:07:04 -0700 (PDT)
Received: by 10.28.153.141 with HTTP; Thu, 28 May 2015 03:06:34 -0700 (PDT)
In-Reply-To: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
X-Google-Sender-Auth: YRYgMh5yWDkGYQx4C3_ZuDBpq9Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270133>

On Tue, May 26, 2015 at 8:15 AM, Patryk Obara <patryk.obara@gmail.com> =
wrote:
>
> These are my first patches to git, so be extra pedantic during review=
, please.
>
> I noticed, that newline is appended, when I try to use template file =
- which
> is annoying if template ends with comment. I digged a bit and it turn=
ed out
> that:

Hey, can anyone go through my commit and tell me if I need to improve a=
nything
or (maybe) accept it?

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
