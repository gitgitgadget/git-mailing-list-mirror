From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 6 Aug 2010 10:08:20 -0500
Message-ID: <AANLkTiniRmnwHaZ2MOWkrZ9c82SjykQFB6hBs5TWbLD1@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com> 
	<4C599781.2020603@gmail.com> <4C5B2F2E.4050709@gmail.com> 
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com> 
	<AANLkTimdZrdLFEit7ecXkEcGdfevbvp2TU1ekHddUHwf@mail.gmail.com> 
	<m3vd7ooeru.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 17:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhOXP-0007M0-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 17:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab0HFPIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 11:08:41 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52059 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab0HFPIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 11:08:40 -0400
Received: by yxg6 with SMTP id 6so2881553yxg.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=iC0u6b1Iv5Y4+Zz/4fUuXl5yhv+ABgYPBIkjTrVuy7M=;
        b=PNMLyiu+BGUu/xUh083xXPwPgdDp7dhWRgGIIimB7h1IiLn6nVoVFDvw/O+nqLdGpt
         GN/buFy0g2xzSi050OIgxbA0q+TUFVzajRWSR6lLA/y9rbe2zbmCIFrw5n3NOOsTm4Oh
         xdeXRDUt2IEFE8PFWSH0HpGwqpHTbIxxQsKMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XwS47YVYEM89Ee8FSbKF2YgmUEfJBKRTawBU8iUOwKbiCYcBDE435Ie6BUmDge6Azg
         bTG4rozr4dtjsCQfE36u3JHfysY6jmaWbsa04l0ONUlCHKJb0pTTqepn3MTkBhAJgiXQ
         zezGvkqciMPoVLiVvLKr7DQHNzOnFqpr5SeeU=
Received: by 10.150.189.15 with SMTP id m15mr543410ybf.324.1281107320200; Fri, 
	06 Aug 2010 08:08:40 -0700 (PDT)
Received: by 10.150.93.8 with HTTP; Fri, 6 Aug 2010 08:08:20 -0700 (PDT)
In-Reply-To: <m3vd7ooeru.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152787>

Heya,

On Fri, Aug 6, 2010 at 03:18, Jakub Narebski <jnareb@gmail.com> wrote:
> We can *store* it without problems, the problem is with
> *interpretation* by porcelain (and some plumbing).

That's what I mean though, if the porcelain notices it's trying to
read in a date it can't interpret correctly it should warn the user of
this fact.

-- 
Cheers,

Sverre Rabbelier
