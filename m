From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Thu, 5 Dec 2013 13:56:03 -0800
Message-ID: <CAJo=hJtSppKYGSG9RS74AjDC_OfNy+EWWf+V7BETO0gASJS9gg@mail.gmail.com>
References: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net> <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net> <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net> <20131205202807.GA19042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 22:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoguL-000807-5j
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 22:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab3LEV4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 16:56:25 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:46397 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3LEV4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 16:56:24 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so175200wib.0
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 13:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GIFDAvyK1g9iocM2e/M+TcHcSYrr4H/xxBjc5bhnh9c=;
        b=FOC1vD6A+HkIXS9ArTiKgbQ2B7Lq8PtCbqKSe9vKwNO66WYFD3DEwqb2m0m/wZFLXt
         Li0SCV8XUfZAznbTyINhUuyDD3qxksBb0B+pdMnUdzBY/wHS9/FZV1snt5t24heERrRp
         f8b2g/e0kbNaMqhw7bKybBoXj2p2ZwSs6zE0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=GIFDAvyK1g9iocM2e/M+TcHcSYrr4H/xxBjc5bhnh9c=;
        b=XcI9WmA3p6Lo740CKUjuojsBSZNAMMIUurBx1FEiDX/Aq3hyriOsjaYiN5xi1UNZjl
         bBCz/CQEKUGrG4/D9RS0X7J+kAstLPdcmWHrfBrN8eXyMffu4UDYfSwRHM0YqmzWW/Np
         /o5QjetbmkzO6fOiNKvgz9t3XKIp9awQSMoqrjCdcaczWbQKyCRzmWM/2iRvMMz0/653
         T1Ldez35S8vwPHWwKE3gVly6m6Mm+RB67Z4ZsYUJQ+bPyF53gtBIZrJEp+CkAm7XHUoM
         66SpDucySIfLOZfCwt1SCWrscQD0xk8x2E5pNHTRessHXwTIaq4u8nzEdYdqhGoI3QJL
         H/7Q==
X-Gm-Message-State: ALoCoQlLiLqWgK8xnzOLkyti3hzF0+ho1CCCUQ3fDGAsozWJXFMYztpF5to/+ksZt249a3XUU35E
X-Received: by 10.180.228.132 with SMTP id si4mr93075wic.2.1386280583566; Thu,
 05 Dec 2013 13:56:23 -0800 (PST)
Received: by 10.227.192.198 with HTTP; Thu, 5 Dec 2013 13:56:03 -0800 (PST)
In-Reply-To: <20131205202807.GA19042@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238914>

On Thu, Dec 5, 2013 at 12:28 PM, Jeff King <peff@peff.net> wrote:
> Subject: pack-objects: name pack files after trailer hash
>
> Our current scheme for naming packfiles is to calculate the
> sha1 hash of the sorted list of objects contained in the
> packfile. This gives us a unique name, so we are reasonably
> sure that two packs with the same name will contain the same
> objects.

Yay-by: Shawn Pearce <spearce@spearce.org>

> ---
>  pack-write.c          | 8 +-------
>  pack.h                | 2 +-
>  t/t5302-pack-index.sh | 4 ++--
>  3 files changed, 4 insertions(+), 10 deletions(-)

Obviously this is correct given the diffstat. :-)
