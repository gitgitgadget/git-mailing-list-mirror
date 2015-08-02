From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/2] notes: add notes.merge option to select default strategy
Date: Sun, 2 Aug 2015 01:20:32 -0700
Message-ID: <CA+P7+xoLpedQMiOg3V9m5S-0OShPpAnDS6_qb62E2c8A-if1Nw@mail.gmail.com>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
 <1438384341-2688-3-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
 <CA+P7+xpTu6eKZEBTbzR9mg4gV3zAvTOc-3PTJP6QamEO_sA1=A@mail.gmail.com> <20150802080123.GA17440@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 10:20:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLoVu-00066f-UV
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 10:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbbHBIUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 04:20:53 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32975 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbHBIUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 04:20:52 -0400
Received: by ioii16 with SMTP id i16so120274421ioi.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8wB+pT3r2XCT9noGMIimHmiR9E0GyAUq0q0RxugCF0w=;
        b=Rf7vNtxDAU9wFJPDsNBIKtzQj3/GbuwoDRreDZQtiZJ0Tnz67RE0fe3bltei7ggFYz
         zANNdiullls1duA7DgKwDPEKFUqzuxbAOGAJ+h6TupsKVsrmVCcaG0W7dNgjBmaN4BgL
         5JBoD318woVW1Bspngsd4A167EoB4TtE9imMm8eGKZbPK5kvJW0X0vD0gvxd8JGMcI8o
         6PjlwCwQgtCJrarc8gcqX4Do43TMXSK4/ODjT7IUpUX+wQgq4EYpEczeWLEz7k4TKJLK
         OMFhLawRxRCiwxvHDspPVkzPO8mnkA8ZNWjuDBuE41iuC09qSpWvp1S/xH7x6DoV9hCR
         GetQ==
X-Received: by 10.107.133.214 with SMTP id p83mr15019620ioi.146.1438503651438;
 Sun, 02 Aug 2015 01:20:51 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sun, 2 Aug 2015 01:20:32 -0700 (PDT)
In-Reply-To: <20150802080123.GA17440@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275131>

On Sun, Aug 2, 2015 at 1:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Don't worry too much about it. Consider it something to keep in mind for
> future patches. I reviewed the change and it seemed okay. I mentioned it
> because one of the goals of patch submission, in addition to making an
> actual change, is to ease the review process. If Junio is okay with
> accepting it as is, then it's probably not worth spending more time
> trying to refine it.
>
> Having said that, I came up with the following for those two paragraphs,
> which gives a much less noisy diff and doesn't look too jagged:
>

Yea, I actually have re-worked it as well to something more suitable.
I'm re-sending anyways as I fixed some of the other style issues and
the one bug about not returning 0 on good read of the notes.merge
value.

Regards
Jake
