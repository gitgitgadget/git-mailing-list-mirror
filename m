From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 09:20:52 +0100
Message-ID: <CAMP44s1=sjWypEN3zzC=aPqZYnBFU0C+Dhrh3zj=jY57PHJ6wg@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
	<CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
	<20121126220108.GB1713@thyrsus.com>
	<CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
	<20121126234359.GA8042@thyrsus.com>
	<CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
	<20121127072700.GA23169@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 09:21:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGPl-0001Ns-U5
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab2K0IUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:20:54 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52364 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2K0IUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:20:53 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so12205533oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mdbFoHZSn6IvOY8xRhYBiSKdRX5lkwYeh4qIPd0N+ao=;
        b=a/gRien/asWEi2QHTjHeWBK2mjIy4DK49FpyRNptcvT6+GuCIlFNBAeKfkP5P7D1+u
         0JSuswD9e47aOp+TXsdxJoqpUXl4mmjWPYoNhf1YYtMEdd+t6RqWQcL6hbYIC1qQZkET
         lBkdRMaZR54ElgJQ9cio96M0T/t9Nfg+QAZTVcsCZjJm45HrwEOBKQoifYoKWb3EjKsB
         A4rxFjShn/ZSPAUmMAWsKT2gV2gBy8g8vKyXNNCtGUilf9Q02NvjY3BCR0+kPI5mhpZ+
         X7NGgoui2LGMeuYs4g0D0GM8/993r4HN2nlQBdF8HKerFEjpRggsFK8T4Huyp9s0a867
         T4kw==
Received: by 10.60.31.6 with SMTP id w6mr11714784oeh.65.1354004452733; Tue, 27
 Nov 2012 00:20:52 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 00:20:52 -0800 (PST)
In-Reply-To: <20121127072700.GA23169@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210541>

On Tue, Nov 27, 2012 at 8:27 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> I believe that log file is much more human readable. Yet I still fail
>> to see why would anybody want so much detail only to import tarballs.

> In both cases the object was to assemble a coherent history
> from all the available metadata as if the projects had been using
> version control all along.

I didn't say I couldn't see why somebody would need such a tool, I
said I couldn't see why somebody would need such a tool _with so much
detail_.

Most of those old projects have a linear history, so a log file like
this would suffice:

tag v0.1 gst-av-0.1.tar "Release 0.1"
tag v0.2 gst-av-0.2.tar "Release 0.2"
tag v0.3 gst-av-0.3.tar "Release 0.3"

And if they really had release branches, it shouldn't be difficult to
modify it for:

tag v0.1 gst-av-0.1.tar "Release 0.1"
tag v0.2 gst-av-0.2.tar "Release 0.2"
tag v0.2.1 gst-av-0.2.tar "Release 0.2.1"
checkout v0.2
tag v0.3 gst-av-0.3.tar "Release 0.3"

But different commit/author and respective dates, and merges? Sounds
like overkill.

Cheers.

-- 
Felipe Contreras
