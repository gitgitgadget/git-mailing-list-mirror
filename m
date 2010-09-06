From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: remote-helpers: The lost verbosity level
Date: Mon, 6 Sep 2010 15:52:31 -0500
Message-ID: <AANLkTinkPaHMknS8GTbDAyxkdpDjKkSmbQjK-B7KkC9r@mail.gmail.com>
References: <4C8507A3.5050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsigT-0003Ae-IN
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0IFUwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 16:52:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49966 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab0IFUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 16:52:51 -0400
Received: by ywh1 with SMTP id 1so1720888ywh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=u5BaHR28C+XKDosJRh2WSwIVunRN/Ng8FOwt5K+jNzQ=;
        b=cnzbB8FhADUhyKGC1X+86Brd1+xdg36S0Pgn11j4IU2Ea1CKRy52LMEIEsVKsUjbe1
         lr5mIxyNCEJjaNZ51Jflqw4UgbUgc7yvW8YfmNDsw2Oof30LEVKR+DtW5iKAX1PtG3TN
         uUYVXDR6vbVi0p+4j5nSW8QRhigNWlxu3Yb8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GRAAARFsx7devICnfJrntp09FmiPM+4hSBkGAzs/bzG8KjpCGVwQCSzvkBBRYpBK1e
         E4SV1z0BufVjQDEmvVNefs/7AzA5i3kUZz/BliLFUuvS54ibW1lW7foy4zpk2S5h5d14
         QDItacR1tVz3zpWbmswzlODOcyffhYm3mEJas=
Received: by 10.150.147.14 with SMTP id u14mr393149ybd.5.1283806371257; Mon,
 06 Sep 2010 13:52:51 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Mon, 6 Sep 2010 13:52:31 -0700 (PDT)
In-Reply-To: <4C8507A3.5050105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155620>

Heya,

On Mon, Sep 6, 2010 at 10:24, Artur Skawina <art.08.09@gmail.com> wrote:
> Tried turning on more debugging in my new remote-helper and was surprised by this:

> IOW the '-v' case is undetectable. Presumably an off-by-one check somewhere,
> and not part of ABI cause some existing helper depends on this behavior? ;)

Curious. That does not seem like correct behavior, no. Can you
investigate where this goes wrong?

-- 
Cheers,

Sverre Rabbelier
