From: Elijah Newren <newren@gmail.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 07:44:31 -0600
Message-ID: <CABPp-BGUghrwUv4YHcSXeaLaYoUG=7oS7a5OhR3MYs0W6E5Bow@mail.gmail.com>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
	<20111019190114.GA4670@sigill.intra.peff.net>
	<CAHYJk3QV8QckbOM76QfqQfTsyOtk+nvfhCped+W3t60JfCfouA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 15:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGsvI-0001Pd-IJ
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 15:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab1JTNod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 09:44:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51198 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab1JTNoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 09:44:32 -0400
Received: by gyb13 with SMTP id 13so2789508gyb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nwC0FLgWp39AAlpXj64NFCgrAXxfh2Wtd0zyTS6xH/c=;
        b=jFI20G7bjwr0RsEHYaxVwNIg9eQjpoCeCxblw0fCWlCmR9TAWQapu9AHS2VhXpGfrk
         Arzlqy3E8G1yiQNjdiThSSeORCOHc2Nwwy2CQQWQ9Z6NLlbeFF4BfLXv94lOKjt66gsR
         q1Ajgn6TNwELqnl+e4Qb0DjJMshZDNOIzc9I0=
Received: by 10.223.63.130 with SMTP id b2mr18957108fai.35.1319118271868; Thu,
 20 Oct 2011 06:44:31 -0700 (PDT)
Received: by 10.223.119.5 with HTTP; Thu, 20 Oct 2011 06:44:31 -0700 (PDT)
In-Reply-To: <CAHYJk3QV8QckbOM76QfqQfTsyOtk+nvfhCped+W3t60JfCfouA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184021>

On Thu, Oct 20, 2011 at 3:38 AM, Mikael Magnusson <mikachu@gmail.com> w=
rote:
>> On Wed, Oct 19, 2011 at 08:03:24PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>>
>>> This is quick hack I wrote just before leaving work to show that I
>>> could indeed push patches to our main repository starting with
>>> 31337. Names hidden to protect the innocent.
>>
> If you don't mind waiting, you could just increase the timestamps
> until you get the desired collision. (If you still want them to be
> correct, trying 4000000 times would about 6 weeks though :).

But the nice thing is that we have both author and committer dates to
twiddle with, meaning that if we need 4000000 different values to try
then it's only 2000 for each of those two dates, i.e. we only need to
be willing to let those dates float by about half an hour.
