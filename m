From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Unify appending signoff in format-patch, commit and sequencer
Date: Fri, 16 Nov 2012 11:13:42 +0700
Message-ID: <CACsJy8ABogKMujC9KhDeLXkwLpd0pkg03hqWzbH0Lmi0A7xoCA@mail.gmail.com>
References: <1352982778-28631-1-git-send-email-pclouds@gmail.com> <CA+sFfMcfGbGDeXKZD1o4pmhbrJ1E5WgV3qrQBPT3eH=W54tNGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 05:14:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZDJz-0006JL-Qp
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 05:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab2KPEON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 23:14:13 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63545 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2KPEON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 23:14:13 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2434236obb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 20:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qJup/CuKFNo1iNFUn17rUk2Lj9KdFPWT+Rg5zgTiiSQ=;
        b=bzfj4z2gq0eafVs+6GarUhX1xbS9lnau6NO8EtnvtsQ0UVanB+uXf2QaiWWGOY6KYy
         0Mz7AQLmUzYuzxjol+kgb3w2aERoi5GHUnusp0KFVAkd+5KTpqIkfALukmhuibtms4Ls
         KahpQ32KezNLwlSBhzLTfH+ZrZdRHXBwAuOy1rjsWxiBkZQPD2JnM22Ck+xtgTitvMK7
         KmLy+bS1j9Yeo2UbtIJf8Of0HMU7ZiXHJXRMtwvAX6LOT42uERh71ca8sya8g+Pu/0mU
         aRr/gbU2J3JudGVmFAyCeL1hejUOZiHXR/rOd5vLUHWL2ETic39qw+3K3PVF8O8ojJ/Z
         p5pw==
Received: by 10.182.38.101 with SMTP id f5mr2862491obk.80.1353039252410; Thu,
 15 Nov 2012 20:14:12 -0800 (PST)
Received: by 10.182.40.163 with HTTP; Thu, 15 Nov 2012 20:13:42 -0800 (PST)
In-Reply-To: <CA+sFfMcfGbGDeXKZD1o4pmhbrJ1E5WgV3qrQBPT3eH=W54tNGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209860>

On Fri, Nov 16, 2012 at 3:42 AM, Brandon Casey <drafnel@gmail.com> wrote:
>>  Interestingly this patch triggers the fault that it fixes.
>>  I was surprised that there was no blank line before my S-o-b
>>  and thought I broke something. It turns out I used unmodified
>>  format-patch and it mistook the S-o-b quote as true S-o-b line.
>>  The modified one puts the blank line back.
>
> Heh, yeah I noticed this bug yesterday when I submitted my changes
> affecting the same area of code (sequence.c).  Glad I didn't waste too
> much time fixing it.
>
> Have you looked at this:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/209781
>
> That series doesn't duplicate your work, but the two series's should
> be resolved.

Thanks I'm watching that discussion now and probably will rebase on
top of yours once it's finalized. I actually wrote this patch a while
ago, just waiting for nd/builtin-to-libgit to graduate because of some
linking issues this patch causes. I can wait a bit longer until yours
graduates.
-- 
Duy
