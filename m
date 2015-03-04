From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 4 Mar 2015 15:55:22 -0800
Message-ID: <CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
	<54E6C78D.3070506@alum.mit.edu>
	<20150220072924.GC8763@peff.net>
	<vpqpp94exb5.fsf@anie.imag.fr>
	<70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 00:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJ8W-0005Vz-Oi
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 00:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbbCDXz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 18:55:27 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45291 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbCDXzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 18:55:23 -0500
Received: by iery20 with SMTP id y20so18616407ier.12
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aFuhmrmmbtTqh9FoVeis+WTsGKuOMNWUlWPsyIq2T+E=;
        b=COvEOZbp2v+ZJiREuuZpHabgD5XM8B/xEfcbKqmB4w8WYZglALq5bL3+ffJAdtzHL2
         pQqBfUGzbu7Bl+ZJ5z0Brgv+wR+nnnLbmey/Bo26WCORsWfwoQWngn+Q9jCNZp9a9Gjt
         Rmobr39+pHwxbYxhpht9iJP2Hd1jUb7ihcqB0IqZRrdpMhAttDmr2+/7BAXRn+zmCwkb
         1MExLsk/pugYP1nQQys1vPMMP/SePGdA5FyPXjrbju4ugaxdqMHzExbbqa4+TnoXfX1F
         bNow95O4zC8O/I7s3GpT35DnVCKdB/ukqmqKwiv2RZwgYTg6/bwzoS3M+FrRuAaWeJ5d
         tG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aFuhmrmmbtTqh9FoVeis+WTsGKuOMNWUlWPsyIq2T+E=;
        b=TkxTWkA/tXvc+7xsyI8ZFsSDVZLylEF0AguKRTDIXDK9oMw1uj3wpz8koFMmWWqTuF
         UTkonedzumihtIwhT+HLEQvS8xiaAG4jqDh56KdoiSsR0XH978yLCAXD+aUbzUF15KLu
         NPmPisE5ZF9HwGway0omGeRFKjHslWVPC+ZU8zc/IL3Dj8gn62pEBNesSID/9M3nIrJ6
         PJVxXsePuwt1Jac2Il7tRT7LFHaMcl8i5Fsf1uFhFuf3T4RPkoZS0lCic5JyW0MvzT4O
         f8YyzdMki8F0/st0l9AK0TmnLN04niIsEXHSlNRCEoXJ+Ohi7+Ekyrh2jECAiJXT/Kn8
         MTsA==
X-Gm-Message-State: ALoCoQlrFjtRQwUErvEBGVs0YZyI8zUUMvxV8bBKKkSQyUiLjsQYO7T4bHKUX9obzQ2yl2T4Jiba
X-Received: by 10.50.39.65 with SMTP id n1mr42653013igk.37.1425513322273; Wed,
 04 Mar 2015 15:55:22 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Wed, 4 Mar 2015 15:55:22 -0800 (PST)
In-Reply-To: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264794>

On Wed, Mar 4, 2015 at 2:05 PM, Philip Oakley <philipoakley@iee.org> wrote:

> A possible idea is to add a date based variant of shallow clone :
>
>  'git clone --date <when> ...'
>
> in the same vein as the existing depth (shallow) clone.

As food for thought:
Maybe broaden this further up to the git-ish way of describing refs, so

    git clone --since 2.weeks.ago <url>
    git clone --since v2.10 <url>
    git clone --since c0ffee^^ <url>

would all equally work?

I am not sure if that is feasible though, but it would come in handy. (E.g.
you are an end user and want to bisect down a bug which you notice in the
new version X but not in old version Y, so you start on getting the sources,
compiling, bisecting)
