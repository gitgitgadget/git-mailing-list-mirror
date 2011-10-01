From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Sat, 1 Oct 2011 23:26:44 +0000
Message-ID: <CAMOZ1BvcQtOzPR=a8NJ9QHXUMhfmmLWwbKMZqsmQTSE150TaXQ@mail.gmail.com>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
 <4E87182C.8050201@op5.se> <CAO1Q+jeLEp2ReNc9eOFoJxdGq6oRE3b+O=JvMNU0Kqx_eAX=7w@mail.gmail.com>
 <4E872288.10503@op5.se> <20111001194746.GA16826@inner.h.iocl.org>
 <CAMOZ1BuXiQkZG_7mvay-ybm7Q7niwXVhbmbCmkfy=wD1AKsasQ@mail.gmail.com> <m3hb3snw4b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>, Andreas Ericsson <ae@op5.se>,
	Albert Zeyer <albzey@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 01:27:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA8xk-0003q5-3n
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 01:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1JAX1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 19:27:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36055 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1JAX1O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 19:27:14 -0400
Received: by iaqq3 with SMTP id q3so3322315iaq.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ExSOxOw102dXHpFyExvUU1qKI7fzydYjqsfPgksix1I=;
        b=hpv9PimWrjENPPAtotloZ+7T5AYEEd6ciBA/9zv5MNo29GnXf+mpg7LTpcg26uZFLX
         x+OnLNUK2z54/ST187JdChjTtGaiWNL4HH5q2tMeQhZGDOvd6TomdDbCNonQ8wuNloHJ
         cFLrEbvtpcJCUcMaKiWsQrJOuKx5ZC1vv4jcA=
Received: by 10.42.137.69 with SMTP id x5mr495718ict.106.1317511634240; Sat,
 01 Oct 2011 16:27:14 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Sat, 1 Oct 2011 16:26:44 -0700 (PDT)
In-Reply-To: <m3hb3snw4b.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182583>

2011/10/1 Jakub Narebski <jnareb@gmail.com>:

> Michael Witten <mfwitten@gmail.com> writes:
>> On Sat, Oct 1, 2011 at 19:47, Andreas Krey <a.krey@gmx.de> wrote:
>>
>> > The question is, should git forbid two filenames that consist
>> > of the *same* characters, only differently uni-encoded? I don't
>> > think anyone would make two files named 'B=C3=BCro', with differen=
t
>> > unicode encodings. But as far as I know that is a shady area.
>>
>> So, let's leave git's current behavior as the default and provide
>> a config variable that when set, tells git to handle file names
>> in terms of characters rather than bytes.
>
> You meant here _graphemes_, not Unicode codepoint when talking about
> characters, didn't you?

Yes.
