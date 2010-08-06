From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 6 Aug 2010 09:01:41 -0500
Message-ID: <AANLkTi=VUULkuhinLD_fztq5NiWCq+g+rm=KGQppXr2h@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com> 
	<4C599781.2020603@gmail.com> <4C5B2F2E.4050709@gmail.com> 
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com> 
	<AANLkTimdZrdLFEit7ecXkEcGdfevbvp2TU1ekHddUHwf@mail.gmail.com> 
	<m3vd7ooeru.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 16:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhNV5-000198-VU
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 16:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab0HFOCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 10:02:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48535 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0HFOCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 10:02:12 -0400
Received: by fxm14 with SMTP id 14so3886792fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=VH95jJV9q34wQ0TzwEIqVA5gZhIei8zKUTVjXMQLEqA=;
        b=SKyxSrZmpfj4r834eHT0IHNSI9Ie7wPaflXHWg5aHWXv+H8towLIc1lSo/qEqCYEps
         cIc27v5j/Pza0lE9nkgaUT3KdH5golJaeU4/A+hbfrVU99cuXp5e5akSvhjegvi5Eld4
         crZOpfbh6BJ2r4EodbZLzvR2y+e4MYJt3PRYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Kc15mxuNv0LEYeMBgXhTWwU+njlmw2sbbmnZO3KJQ4OHlsLbXGnPg0EdSUsrk4t74n
         baxdrIr6P8F1ae1GP46xqY1YQJjDoiuELaOGffR43tqo9fJyxKTtv9MKJiLfcePCsOqM
         AoaW4ILCGynH9571/KWXvgTepSLgan8jJjbOw=
Received: by 10.239.144.140 with SMTP id o12mr539890hba.119.1281103331208; 
	Fri, 06 Aug 2010 07:02:11 -0700 (PDT)
Received: by 10.239.157.68 with HTTP; Fri, 6 Aug 2010 07:01:41 -0700 (PDT)
In-Reply-To: <m3vd7ooeru.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152781>

On Fri, Aug 6, 2010 at 03:18, Jakub Narebski <jnareb@gmail.com> wrote:
> the problem is with *interpretation* by
> porcelain (and some plumbing).

The problem is that git was written with leaky abstractions.
