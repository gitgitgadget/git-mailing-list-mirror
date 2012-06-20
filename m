From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 14:45:31 -0500
Message-ID: <CAFzf2XwmZo4ErG_9w0m66k4OPtDr_4_xvATL_6sOo8QVg0DhJA@mail.gmail.com>
References: <20120619232231.GA6328@sigill.intra.peff.net>
	<20120619232310.GA6496@sigill.intra.peff.net>
	<20120620035015.GA4213@burratino>
	<20120620042607.GA10414@sigill.intra.peff.net>
	<20120620102750.GB4579@burratino>
	<20120620163714.GB12856@sigill.intra.peff.net>
	<20120620182855.GA26948@sigill.intra.peff.net>
	<CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com>
	<20120620193638.GA32418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:45:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQqP-0007Np-SW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab2FTTpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:45:33 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59996 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab2FTTpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:45:32 -0400
Received: by gglu4 with SMTP id u4so6010414ggl.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wLxt1EFUBxrtyJ60dyh1DWlIIPaNyi7laD44jnP6ov4=;
        b=JVbBvGyjusy+K072YlbIn4mbbvac8OI4MZipFj+Fs6o0d9sQ/ghAejOIYq3Gti0Gbt
         H9H0kXIQ8Tgw3vjFPrnqkI6+nNYAnb/OIejBa+0YfpeeeJsZGrY2H5YHIHqN8SfSnOug
         61mNnR/IxRGh+x3K37wnUilTtGIqWke73Es440L+JS3kKnmYwioBGw6L5h4kZpIuSA5N
         tOq0TP6tgqwE3drdARMIq1Cf8kELIIv5ULnS/iYr/4ivp3SDUN7qMiGXfuyiCGYklaxs
         IRXvWQUkWMuuYHMzwWyBWRzCjtvpWchqqlrBcQxvIMFtImVk72FkG7E2R0aircQzjMKo
         VS3Q==
Received: by 10.50.184.227 with SMTP id ex3mr5682511igc.26.1340221531826; Wed,
 20 Jun 2012 12:45:31 -0700 (PDT)
Received: by 10.42.30.136 with HTTP; Wed, 20 Jun 2012 12:45:31 -0700 (PDT)
In-Reply-To: <20120620193638.GA32418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200345>

Jeff King wrote:

> Did you read the argument in patch 2? They are almost certainly not
> helping anyone, anyway.

Yes, I read patch 2. I hacked on git from time to time in the days
before COMPUTE_HEADER_DEPENDENCIES, and it sometimes involved changing
header files. When they were not in LIB_H, the experience was much
nicer.

Is that called "not helping"? I'm afraid I don't follow this line of
argument at all.

On the other hand, if someone were proposing adding a simple awk
script to implement a "make dep" fallback, I would understand that.
