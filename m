From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Having Git follow symlinks
Date: Thu, 30 Jan 2014 11:09:55 +0100
Message-ID: <CAP8UFD34r9netM_k7bG7P5NdXQnvw2OojV8X_+oYQRoKUBGYrA@mail.gmail.com>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
	<CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
	<alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jan 30 11:10:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8oZM-0006h2-N6
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 11:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaA3KJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 05:09:57 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:56051 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaA3KJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 05:09:56 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so4547332qcq.18
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lIDhM8bRhN6M4sEksa/xci9r22Ih6cEM4f5itNGYLhE=;
        b=0XRGgxOi/5l/2Ej5FoIaz1ZMwMWAPWXTN9U+GOejyPxLZk349D4qMlN6GYgCTjNhuu
         4sLYeYaxzAMJKzbWl9rg7XANukZbSo/kPAcoZGAjBxWzsAtqjK2ZHb/lAa6ss+CxqZFD
         19QWGyzpYkQLTtWuuxGPU5KzblSr8PoSleGCeKvgj39I7IT6MFRtNWvn5bnonEVZqn98
         t41wV/nC1J/EnebnjxSkyrQywOvy3e6M5hoH/vg2Z8P4ZlhxdoIOnUdKx/zIBVODSWMr
         I1AT7HI55iuNnUI1+w3e+naqkGdzI2rpWAAixNH6er5HfV0O+9VnxHFNRcRp/PgaJerN
         twJA==
X-Received: by 10.224.32.133 with SMTP id c5mr20140463qad.54.1391076595566;
 Thu, 30 Jan 2014 02:09:55 -0800 (PST)
Received: by 10.96.140.229 with HTTP; Thu, 30 Jan 2014 02:09:55 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241263>

On Thu, Jan 30, 2014 at 10:01 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Johan Herland:
>
>> I believe a preferable way to manage dotfiles in Git, is to have a script
>> that does the necessary setup/installation from the repo (that lives in some
>> subdirectory of ~) and into ~.

There are tools these days to manage dot files.
See for example:

https://github.com/RichiH/vcsh

Best,
Christian.
