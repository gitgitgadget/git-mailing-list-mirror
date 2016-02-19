From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 10:09:45 +0700
Message-ID: <CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
 <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com> <vpqh9h7f9kz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 19 04:10:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWbSf-0004K8-T3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 04:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbcBSDKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 22:10:24 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34967 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbcBSDKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 22:10:17 -0500
Received: by mail-lf0-f41.google.com with SMTP id l143so45519177lfe.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 19:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r35QZYs/KeCNBSQzMDJnaz1k3g0eRB7CH81YHVm+LCs=;
        b=P0OVEP0rOToghrU3xBWMAjEyQ3pVtKobtPg+/4Y/I+wsbHwZ1KYyPOEZ62OIP1AtMn
         /FPAvp28iBanSwcaoRYA1cW19QqW4k4yrgh1emqgLbcqZ1MNUuguAqRKg/1UMAnG/kWE
         0e41zOWwwV7TAsi9FgJd+IgLJmcK/gPoDkvrwpJ2Y/w0FVrp91Nx/dQ4FKPEEqW3xrCA
         tZYa+xdaSiubSAhJ35TEwkRcj6ujKiqGchPsjwOQXXOcvK8jFXBX9nO0zzbM39KveS0x
         HVZUTOxNdbjYHYJyRvds/9XlAqv9blgAb0kBAuMfKmt7PzGmhzIubRo/nWS3s0mFvu7K
         alFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=r35QZYs/KeCNBSQzMDJnaz1k3g0eRB7CH81YHVm+LCs=;
        b=GCV8CRkY5GIL3bE4tC8WV4Dz93tPubFLcLB7tL6ClNT6wG5+Bx9W9yQDa8ACelrC75
         VwGjGnNWp0UH9hxkmw6DVQHbatAXnWNF7fJD9XcEnyx3F4E1tPnHS8Zs4fs4hy9/JiSM
         hkqJ9gmObIp3coVg/8dnNeCfZAwtPknGWUnUy94DeETfzYah5eTUcQX68zNTEp5paAXH
         8gnC7qSJPiSuRrZ+wqQk8clWt8KIm13bKA/5kLMcisU7Cc6mPpT+MOAqahddbhYBk+Vh
         pR7nj/lvzwRtUgonjmDSmlkMWLbRX8lH4MRH8hWxxOkPCk8VpuokbMzbGzqmwMNsKhBp
         7MGQ==
X-Gm-Message-State: AG10YORfOWfvQzy+bPKQW/RA52wFiZlDpsnK+ehHlKOL0Cl+UpAtc6o/21vXJl9uzroG/GLh0yapj+/pmUUQpw==
X-Received: by 10.25.5.6 with SMTP id 6mr3710928lff.3.1455851415385; Thu, 18
 Feb 2016 19:10:15 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 18 Feb 2016 19:09:45 -0800 (PST)
In-Reply-To: <vpqh9h7f9kz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286654>

On Thu, Feb 18, 2016 at 1:58 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Feel free to start writting an idea for
> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
> ideas before Friday. We can polish them later if needed.

Probably too late now, anyway.. with David's multiple ref backend
work, we could have a third, no-dependency backend. We can use index
format to store refs. Then we can avoid case-sensitivity issue with
filesystems. Split-index could make it relatively cheap for updating
refs. Later on, when we can store tree objects in index (*), some
(rarely used) refs could be stored as tree objects and we can reduce
index file size (and loading cost). This idea is inspired by Shawn's
storing refs as tree objects mail, except that I stopped at "wait, if
we want to create trees we (usually) have to go through index, why not
just stop at index?".

(*) In have some WIP in this area, but not ready for public discussion
yet. And it's out of scope for GSoC.
-- 
Duy
