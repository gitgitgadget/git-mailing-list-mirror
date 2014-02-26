From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] tag: support --sort=<spec>
Date: Wed, 26 Feb 2014 18:11:54 +0700
Message-ID: <CACsJy8Aqd4-9z3nb2Hi=nxrRLUYN+9pGiNP7-fnUE_Bn5zRW+Q@mail.gmail.com>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
 <1393330935-22229-1-git-send-email-pclouds@gmail.com> <20140226090511.GA32537@sigill.intra.peff.net>
 <CACsJy8CW9p-PDJC9zXBwXrxOk9GhBFk1nVtG1Xn76g3FN+KgaA@mail.gmail.com> <20140226110803.GG25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:12:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcPe-0006FE-L8
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbaBZLM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:12:26 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:61984 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbaBZLMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:12:25 -0500
Received: by mail-qc0-f177.google.com with SMTP id m20so1029744qcx.22
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 03:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DtRo+O6pftHrV1Rb+FvOPNt+Tx3Q9vBs3ZGELmn9SX8=;
        b=lhwRzikJrpPxKt4BYqSJ1/h7UG8Gy+OqFwCNd8Zk7gQn66psPdcSRtJW/Jp5oG1NB1
         OSkbRI8tgVjUQuDyRliGSo+/0O5317sk68DWcRXanaEHVYiW5mrHFLsgTHndsgcNCIOb
         y9fLx1eT5YkpyNuwRnZ39NwB+JT/wfkIpAo+IpRor8+/yOYiOiBN1U2jxaqeYFUlmNUe
         7xU45EDXI1cr1TE5mx7Gja6JNI5Og3JiU7Hq1NJrXoTsEbus2P/0Yb0IE97A7EtsNjUs
         o98RmtTm8qWFDPxIaxlOAksa1pBTCw3ZsQhI/gnajrnSWLIL0U4b2Rk8ycbl2sbD7Alf
         6Acw==
X-Received: by 10.140.40.5 with SMTP id w5mr6332207qgw.65.1393413144921; Wed,
 26 Feb 2014 03:12:24 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 03:11:54 -0800 (PST)
In-Reply-To: <20140226110803.GG25711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242719>

On Wed, Feb 26, 2014 at 6:08 PM, Jeff King <peff@peff.net> wrote:
> I'd worry slightly, though, that there are other schemes where that
> behaves poorly. Should we optimize for git's version numbering, or for
> what most other projects want? There could even be room for two types of
> version-compare. But before thinking about that, I'd want to know why
> glibc behaves as it does.

We don't have to force one version style for all projects. We could
provide --sort="thisver:refname" vs. "thatver:refname", or put the
"-pre" part in config file. The important thing is we can control the
version algorithm.
-- 
Duy
