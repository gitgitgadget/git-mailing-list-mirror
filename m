From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 11:38:44 +0200
Message-ID: <CAHYJk3QV8QckbOM76QfqQfTsyOtk+nvfhCped+W3t60JfCfouA@mail.gmail.com>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
	<20111019190114.GA4670@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 11:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGp5O-00045L-2A
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 11:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab1JTJip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 05:38:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52624 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab1JTJio convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 05:38:44 -0400
Received: by ggnb1 with SMTP id b1so2588655ggn.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1tL2M5mZqLJNeUt0AP8nPcq1SV2aVmLnnTCsf15XDRA=;
        b=W3/jRkWIs6vyoIH83XJIgP1pg5iAjT2DUwAb5DyA7NmhvYpfmqMAmrKMO27AgCAuEo
         LujLY1ziii5aLsZJqrxO9wesHashBTTMIe1TRlOXUbMSPCLgbwF9zswS7QUXVlof4FFD
         Hz0LIumLzXNRjMUuaPgNHGY2kYEzs/7ChNm0c=
Received: by 10.182.124.9 with SMTP id me9mr1804821obb.1.1319103524109; Thu,
 20 Oct 2011 02:38:44 -0700 (PDT)
Received: by 10.182.40.165 with HTTP; Thu, 20 Oct 2011 02:38:44 -0700 (PDT)
In-Reply-To: <20111019190114.GA4670@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184019>

On 19 October 2011 21:01, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 19, 2011 at 08:03:24PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> This is quick hack I wrote just before leaving work to show that I
>> could indeed push patches to our main repository starting with
>> 31337. Names hidden to protect the innocent.
>
> Clever and amusing.
>
>> Which in just over a minute will generate, in my case:
>>
>>     $ git show --pretty=3Draw 313375d995e6f8b7773c6ed1ee165e5a9e1569=
0b | head -n 7
>>     commit 313375d995e6f8b7773c6ed1ee165e5a9e15690b
>>     tree c9bebc99c05dfe61cccf02ebdf442945c8ff8b3c
>>     parent 0dce2d45a79d26a593f0e12301cdfeb7eb23c17a
>>     author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@example.com>=
 <censored> <censored>
>>     committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@example.c=
om> <censored> <censored>
>>     lulz 697889
>
> Nice header name.

If you don't mind waiting, you could just increase the timestamps
until you get the desired collision. (If you still want them to be
correct, trying 4000000 times would about 6 weeks though :).

--=20
Mikael Magnusson
