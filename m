From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: how to apply patch?
Date: Sun, 7 Feb 2010 12:40:03 +0800
Message-ID: <be6fef0d1002062040x6556b73fvb2a62a85fe21ec9e@mail.gmail.com>
References: <13f0168a1002061720t93ff6aew3420a41a547549d8@mail.gmail.com>
	 <13f0168a1002061805o5d64c05cy9d8f0190a8f37feb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matt Di Pasquale <liveloveprosper@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 05:40:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndywc-0001n5-50
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 05:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0BGEkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 23:40:08 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:60259 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0BGEkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 23:40:06 -0500
Received: by iwn39 with SMTP id 39so5627694iwn.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 20:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KrW1p59E4xfX2Oxbd4qQ14k/TXGpzaxyklYWWaICiss=;
        b=HWVoDNuWHZD/I7ycIm3e20VCs1AmP7GRG1KwFdWai93DdOMmm/37hMQ8RgQjjRctI1
         yFimL9SFSMW5Iw5FCXgYwqeT77+DJjWWEE/nqCgj5m2vaelnLVDapjKdwQFFzfjL8cVL
         YDYhQ2WrSVqvKW1IDk7AlGfbNVIDAiKCRM+Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KbhUW9x1V8WX0lgfkR8bL+ELKXRNgNLfNyhM5emtpZVFpGYJHMLdBREXUenwlWed+7
         zdTSwXXtviU07jLUhCOxQnLc+GaU7fdKyW+JEZTl9+4cNX3lMIOsN6QvqHBgmlUMsuIt
         z6MwHauFvGBhiQRhpgOIx3jTBTLmWXKkjeLYg=
Received: by 10.231.156.205 with SMTP id y13mr6354226ibw.27.1265517603305; 
	Sat, 06 Feb 2010 20:40:03 -0800 (PST)
In-Reply-To: <13f0168a1002061805o5d64c05cy9d8f0190a8f37feb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139216>

Hi,

On Sun, Feb 7, 2010 at 10:05 AM, Matt Di Pasquale
<liveloveprosper@gmail.com> wrote:
> [snip]
> Then, copy dev to pro, then reapply/rebase the essential
> differences to pro that got wiped out. if i rebase though, i want to
> be able to rebase again on the next edit.
> what's a good way to do this?

you could put this in your config:

  [remote local]
    url = .
    fetch = dev
  [branch "pro"]
    remote = local
    rebase = true

When you're wish to incorporate your latest changes in "dev" into
"pro(duction)",

  $ git checkout pro #assuming you're not already on "pro"
  $ git pull

Repeat ad nauseum.

-- 
Cheers,
Ray Chuan
