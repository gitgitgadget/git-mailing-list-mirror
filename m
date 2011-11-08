From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Tue, 8 Nov 2011 09:52:26 +0100
Message-ID: <CAKPyHN1cqG9-g1Q4iGbUOtfiXLc6EPcFH2cWNCep3af4cTdzSg@mail.gmail.com>
References: <4EB85768.1060508@avtalion.name>
	<20111107225508.GB28188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ori Avtalion <ori@avtalion.name>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 09:52:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNhQ1-0007Dc-6E
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 09:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab1KHIw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 03:52:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45314 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1KHIw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 03:52:27 -0500
Received: by faan17 with SMTP id n17so271318faa.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rEnuNL8LzkECSXphSFzCt/NX4fpE01HhA1R08UNyg28=;
        b=gDpulXfSUbkhP+CkLyAQ1Prjqi5EyfI4zyIm8lpzTHiCwNU2KsISnIuMBSpBx77oUa
         OHezAsAWoCo0WxBLpWc9g00b2B+Wz2aAT5N1aGhdRF/vtQ3KzQrEE047d52pgKwfCCoC
         YgsHrJxQgC6syxFLLU4WISU4gWgyA4FXZ+6JQ=
Received: by 10.223.76.66 with SMTP id b2mr54547978fak.15.1320742346245; Tue,
 08 Nov 2011 00:52:26 -0800 (PST)
Received: by 10.223.89.143 with HTTP; Tue, 8 Nov 2011 00:52:26 -0800 (PST)
In-Reply-To: <20111107225508.GB28188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185078>

On Mon, Nov 7, 2011 at 23:55, Jeff King <peff@peff.net> wrote:
> In the general case, you can't represent all failed hunks with conflict
> markers, can you? I'm thinking something where we couldn't find any
> relevant context. You know the lines from the original patch from the
> hunk header, so you can drop the failed content from the patch in the
> right spot. But how do you know how big a conflict marker to make for
> the "current" side? The same number of lines as were in the hunk?
> I think you'd end up with confusing conflict markers.

GNU patch can produce conflict markers with the --merge option.

Bert

>
> -Peff
