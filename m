From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Mon, 23 Mar 2015 17:18:10 +0700
Message-ID: <CACsJy8AP7Q9tNNDuQ2aLpCWpBwuD39qPSfip54pmDP58roztEw@mail.gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
 <vpqwq2eyyzl.fsf@anie.imag.fr> <CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:18:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZzRW-0005ru-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 11:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbbCWKSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 06:18:42 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37509 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbCWKSl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 06:18:41 -0400
Received: by igcqo1 with SMTP id qo1so34234228igc.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OGx6ZPyyYLlYQf4RFsS3ZePPdBNRVL0s0AQg3uliMAw=;
        b=K0k3jLyrEkpvWNVv31rkT2978l4ryl/G0f883cv+o0yuVHv+MvEaBKmVzHWt/eOWph
         Bos1SCtXybbW2EU2ZT6rl9FoebLw460Hoz2gpkbEfm3HaROX5Fk0XK6s/Bh3wnJtEI0x
         V1+9JhCNEPm4Kcmtoj4dpNUw2+gxY50wB0gx7yDFxgvUkjfGf1opBAXZazbwYXPIX2eB
         7uzJejULiE1OScNVekuKZj8eUMQI2O5YgjhGzXhqvJgBSnf+5UxoeSVNnmGtwgdGDNiD
         UjHQ1X9ni/2RQhjEHzZA4YekSZTo9Vn2+qyXYc9L731oWZF7jmxVRXut7kueqgtInccA
         5MLA==
X-Received: by 10.50.143.36 with SMTP id sb4mr13280666igb.0.1427105921063;
 Mon, 23 Mar 2015 03:18:41 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 23 Mar 2015 03:18:10 -0700 (PDT)
In-Reply-To: <CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266133>

On Sat, Mar 21, 2015 at 8:23 PM, Paul Tan <pyokagan@gmail.com> wrote:
> I see git already has gcov support. For shell scripts, maybe kcov[1]
> could be used. With some slight code changes, I managed to generate a
> report for the git-pull tests[2] which should at least provide a good
> starting point for how the tests can be improved.

Could you share these changes? I'm just wondering if we can add kcov
support to the test suite.

> [1] http://simonkagstrom.github.io/kcov/
> [2] <http://www.googledrive.com/host/0B4O2AiYulllpfmJlTW4xT050OVVicnNWWS02dm52aTJ2TFIwQ2QwdWh0VHotSkU4eUNNWjg>

At least we can see [3] that not many options in git-pull is executed.
Cool reports.

[3] https://83dc3588620c5a97164396ec753a2fa480f6a7b0-www.googledrive.com/host/0B4O2AiYulllpfmJlTW4xT050OVVicnNWWS02dm52aTJ2TFIwQ2QwdWh0VHotSkU4eUNNWjg/git-pull/git-pull.360f32c2.html

-- 
Duy
