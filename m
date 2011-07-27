From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Wed, 27 Jul 2011 16:02:48 +0700
Message-ID: <CACsJy8ByDUByZiX43_+4_49uB+h0AMCk9J+35kZJSKgBn2KZbA@mail.gmail.com>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net> <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net> <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
 <20110726060903.GA29486@sigill.intra.peff.net> <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
 <CACsJy8C822Fvwav4Wpw4e-12ZY20XM1s2v4KymZkaDYLxkMHvw@mail.gmail.com> <20110727081034.GB8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm01U-00074Y-EO
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab1G0JDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 05:03:21 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:45361 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1G0JDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 05:03:19 -0400
Received: by fxd18 with SMTP id 18so136903fxd.11
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CeQCUIjs+HXEbIGM1L1ka5OsAG3OkY42BT2aExXgQ+0=;
        b=gvVPyPEDnX5LzNK1Dh3Msuz71w0nsr89yllW2pCrFEh1bwZtiVAeRiEcUUxTVbgqHz
         QlI1FDsROvY5vHdP7vCbXMTihkODOWxrEsDd90DOZ1QT8O43/BQ6XwlD/6hcLbju4v4d
         vbVGLZwNu68q4isDkXhuFjL09132Lcl0FplEs=
Received: by 10.204.132.9 with SMTP id z9mr354713bks.348.1311757398111; Wed,
 27 Jul 2011 02:03:18 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Wed, 27 Jul 2011 02:02:48 -0700 (PDT)
In-Reply-To: <20110727081034.GB8105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177951>

On Wed, Jul 27, 2011 at 3:10 PM, Jeff King <peff@peff.net> wrote:
> I'm not sure how useful "log --hunks" would be. The changes you commit
> don't tend to be that big (well, not if you're doing it right). It seems
> much more likely to have the case you brought up, which is that some
> file has a bunch of boring boilerplate that doesn't need to be
> changed, and you need to pick out the interesting changes from the
> boilerplate changes.
>
> I suppose if somebody committed all of the boilerplate changes (like .po
> comment changes), then you would want to be able to pick them apart. But
> that just seems like the wrong thing (i.e., if those comments really are
> uninteresting, they should not be committed). But I don't work with .po
> files at all, so maybe there is a good reason to commit them.

I was thinking of it as an extension of "git log -Sregex", where as -S
shows full diff of matched files, the new option only shows hunks that
actually match. Not sure if that is really useful though. On the other
hand, "git diff --hunk" is useful for me, I'll see if I can add that
option.
-- 
Duy
