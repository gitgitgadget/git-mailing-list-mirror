From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Fri, 26 Oct 2012 11:02:18 +0200
Message-ID: <CAMP44s2H=jTBJbDu-Fzc6Z9NLOmheKty5HFcv4hND=_rDV==Vg@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<20121017225913.GC21742@sigill.intra.peff.net>
	<CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
	<CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
	<CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 11:02:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRfoI-0006io-4k
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 11:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731Ab2JZJCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 05:02:21 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42390 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab2JZJCT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 05:02:19 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2432773oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rafmkVwL17alHiLEOgklQWJFZ2V8w8czjR1wah+TSVE=;
        b=gFWaPjzGT8h6UI8AJm/PXq+Q2q1aGbOgb1f/4yKy+FjL6INAj9rLOMrLEgNC2waA+L
         8uV4Hf3ouMY1PxhsgIXXytlw6VHcCIGtnG1LB1xovq2NBU5rw4G1pK/kImXDHG3AD5ja
         ylHyeazHwbBoNLlriP2dSeouMiWdJCwX8gbWzDQ1Vx6gsDzFclxqYX9H/FBa9ucqQDS4
         9xcp83F+vaGnK6G2uHxYAfLNa3+NeDt5KxmbpxpFUdByjPTvisjFqssTX483aR0/fAto
         LOFRvc2PPIhnsrOHFscIaxFfWk+1+09deENRWOIAU2OsqSfqrokYXbKuwRSQuFgzZ1nK
         Yi6A==
Received: by 10.182.10.6 with SMTP id e6mr17758802obb.16.1351242138993; Fri,
 26 Oct 2012 02:02:18 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 26 Oct 2012 02:02:18 -0700 (PDT)
In-Reply-To: <CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208431>

On Thu, Oct 18, 2012 at 8:12 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Oct 17, 2012 at 10:18 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Right now I've just added an error when using remote repositories. But
>> it seems there's no way around it; if we want to have support for
>> remote repos, we need to make a local clone.
>
> My git-remote-hg does the local clone into .git/ using a hash of the
> url (although you could just as well use urlencode, basically any way
> to safely use a url as a directory name). Have a look if you want.

I can't find that code.

-- 
Felipe Contreras
