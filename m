From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 19:41:45 +0700
Message-ID: <CACsJy8Aa30TDeSyXaPT1L+VzTMgC+vhJhO+T=j7n6k+9AFi-Eg@mail.gmail.com>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com> <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com> <20160223050210.GA17767@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602231334050.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Stefan_Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:42:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYCIG-0004hO-FB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 13:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcBWMmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 07:42:17 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34542 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbcBWMmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 07:42:16 -0500
Received: by mail-lb0-f171.google.com with SMTP id of3so99948466lbc.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 04:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=owp6ctynssmhHavjOFGjIvSZH5XJ/uhY8blBIa8vPGo=;
        b=nQeGacQEDOwdjNMxgMH4FIyvb6KYcooiq2u5kLZ4DJd/J9/svqWcws86z/cKvr9hqQ
         7tNgK3FwOz7SA5ImOUePDgA+DaMeaJ2xOTBOK8fIIiXmxJsv0oOpkaKFRQ9023hZQCi0
         NC9CSiOUq0u68iIcFyD8uiffIMQ7Ny+Dv85+jzSu8UhnhrC5vV5rHrVfM1NB2AfNHBaU
         +7HzXTzui5QlhFWpKkxgpOm3wBfuX78azzP2NJxXJvEdeH3usGIu1PxmtYV2MsB4w2po
         FIoDV54xi/Mpz7zpHOYtLpZR8s3lhcMhI6TX0O4UXM16aSZD/ioDfY05HhQDlalErSwa
         RPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=owp6ctynssmhHavjOFGjIvSZH5XJ/uhY8blBIa8vPGo=;
        b=mJGkxPSRZMtN1amwIRiZCRhCUk+3XwYikpXAecbL6FFlQLKgAIvhh0Dz6vlrwOV+R2
         kjJjGbZhsgR6e7pSIZ0SLvy8nT4aZbJwvumN4d1ymNQPBHCWvB+W4TAaYYlcMEYSHf2o
         BZyIyLI59tucr4DRvHl8iYsb+mKpFRb06ePghVyJKp/fzT21WeDzEVZ/2hzmJ3jZN0xS
         NOQk8Sra0cg8nKLqseREmIcTrI4YQkHB7GIYboEsFPN8+LfhAXe8RckW2NoIcCuyp/QG
         BezYGgYkSwSp/sZ4AZ8hOiE8nNzg3d4sOVln2H8oI30YyGcmDgfTV9rtUKZJA5JByJNP
         39Bg==
X-Gm-Message-State: AG10YORg8y3U8IZ3UrKXhPS8ReR1eQdgU0u1f04q3875fns8+0FHQTyYQAvvk2DO76b5S/CrgliyesHquPhvjw==
X-Received: by 10.112.171.163 with SMTP id av3mr313746lbc.145.1456231334966;
 Tue, 23 Feb 2016 04:42:14 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 23 Feb 2016 04:41:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602231334050.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287049>

On Tue, Feb 23, 2016 at 7:36 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> We could encourage more voices by issuing a warning when merge-tree is
> called, e.g.:
>
>         warning: merge-tree is unsupported (please contact
>                  git@vger.kernel.org if you use it actively)

Maybe motivate them to reach git@vger by s/use it actively/do not want it gone/.
-- 
Duy
