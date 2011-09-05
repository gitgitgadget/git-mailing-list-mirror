From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options
 accepting 'g' sizes.
Date: Mon, 5 Sep 2011 15:49:07 +0200
Message-ID: <CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk> <1315223155-4218-2-git-send-email-nix@esperi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Mon Sep 05 15:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ZYf-0002yZ-HM
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 15:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab1IENts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 09:49:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62929 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab1IENtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 09:49:47 -0400
Received: by pzk37 with SMTP id 37so8775412pzk.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vcRKq8HdZwbAVfPDXhKKTRWE+fMZCWbBFkoIwamRGY0=;
        b=BI2/G7p8IopZmOh2qBcw2Ka3SosUkbSXPdHeDduOu0WItMdqPGdP967OtsSO3fAJGv
         9X56xZO0NvWJHt9yfUNZ1Sg1TAUDn9HzS6VkQfEezzIZ5jVsVbg9vcNLY+Dp83X9DH8l
         D2wawOPnR7wFygM2wdm6G4P9PjCf0mPzpuN8U=
Received: by 10.68.22.201 with SMTP id g9mr6347729pbf.433.1315230587176; Mon,
 05 Sep 2011 06:49:47 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Mon, 5 Sep 2011 06:49:07 -0700 (PDT)
In-Reply-To: <1315223155-4218-2-git-send-email-nix@esperi.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180743>

Heya,

On Mon, Sep 5, 2011 at 13:45, Nix <nix@esperi.org.uk> wrote:
> 32-bit platforms with no type larger than 'long' cannot detect this
> case and will continue to silently misbehave, but the misbehaviour
> will be somewhat different and more useful, since bigFileThreshold was
> also being mistakenly treated as a signed value when it should have
> been unsigned.

Is it not possible to detect that the target value won't fit in the
max size of an int when parsing the config value?

-- 
Cheers,

Sverre Rabbelier
