From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Thu, 9 Jun 2016 15:53:26 +0700
Message-ID: <CACsJy8BGV-AWwap9c2hOjXWMYxBLUirX8i20rS_=Vmci_SG_rw@mail.gmail.com>
References: <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
 <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com> <20160607202351.GA5726@sigill.intra.peff.net>
 <CACsJy8CtsFFJPssDDBuL8TLoxi1f=734mjAjCUOr8Y63aD3xUA@mail.gmail.com> <20160608161958.GA30876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 10:54:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAvj9-0002wm-78
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 10:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbcFIIyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 04:54:04 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:34971 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422628AbcFIIx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 04:53:58 -0400
Received: by mail-it0-f45.google.com with SMTP id z189so148643225itg.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YzAeP7JfGmwxlT8FRD7MclEJj/CcuUWXWL+V5NYO/Bo=;
        b=C4eE/VcZT44a9dRx4blbCavxxs96uuTrNoSFHgkJ8nUZUbeOieRYsG4KjDnDaDRSXc
         oT31jhQgTAF66FwNMb4tT2RvmWq+J0Goxt27J80MCFgbeJc/IAcQcN/t5JDfUXaUBNuA
         apeeIZOUqSzJUZRcuQ40hZNbHwYxeLcSyqQrI37bjVadCIMG6OyrjmdSTNZWv3rcc5hs
         uV+51zNmR5/n9Dfx1y/QtvL23ho/A0jZoa5zOKDunl3HawbX1GqzrO7ejObRUzNa53xm
         2hIqKUvU0JXmDOh+la598VRkuCfCO65rdvcrEOX7guMOsqRdtjKLYjXJKevqw/evpicD
         A1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YzAeP7JfGmwxlT8FRD7MclEJj/CcuUWXWL+V5NYO/Bo=;
        b=jQVge8Nl0mYGo6J/ypXPd0YNX5V876sl6W8oxPJxv7z8JLtIuu5fZ6x++ts4jDKqFT
         bla4FMbtZ7BI7fz/zGGNqAc5m5PnVlbW8j14TvxFNuJuRbWfadfBErgA26RaJDEfp+az
         sN6VRRPnYNXzvbG6m0X+exrq6umC/he35IJ8w4SUQW9jd2i/K1Sa4Rcorrd6St98Sh5C
         JvkjIdgIZrTFXVtFSDUEGAHKDy8eT+4I5wl+YVcJpPzh/BOEGkOnxn7390IZNnDkGQe4
         7ctbkJl/RsknKQN+WT1ZFEDWy/vz2t6hn2HoM9GN3qixMD23uWu9nICWZs2GQZSQ+/+y
         s52w==
X-Gm-Message-State: ALyK8tI5EIJhOCoBR2zpQO1Fv1MRm4ipElBW7UJNKQalalRulJMMwuMhul6cEMFOYAtD08+Tp/NSmc2Tpqt66Q==
X-Received: by 10.36.108.76 with SMTP id w73mr15833266itb.63.1465462436081;
 Thu, 09 Jun 2016 01:53:56 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 9 Jun 2016 01:53:26 -0700 (PDT)
In-Reply-To: <20160608161958.GA30876@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296876>

On Wed, Jun 8, 2016 at 11:19 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 08, 2016 at 05:44:06PM +0700, Duy Nguyen wrote:
>
>> On Wed, Jun 8, 2016 at 3:23 AM, Jeff King <peff@peff.net> wrote:
>> > Because this "external odb" essentially acts as a git alternate, we
>> > would hit it only when we couldn't find an object through regular means.
>> > Git would then make the object available in the usual on-disk format
>> > (probably as a loose object).
>>
>> This means git-gc (and all things that do rev-list --objects --all)
>> would download at least all trees and commits? Or will we have special
>> treatment for those commands?
>
> Yes. To me, this was always about punting large blobs from the clones.
> Basically the way git-lfs and other tools work, but without munging your
> history permanently.

Makes sense. If we keep all trees and commits locally, pack v4 still
has a chance to rise!

> I don't know if Christian had other cases in mind (like the many-files
> case, which I think is better served by something like narrow clones).

Although for git-gc or git-fsck, I guess we need special support
anyway not to download large blobs unnecessarily. Not sure if git-gc
can already do that now. All I remember is git-repack can still be
used to make a repo independent from odb alternates. We probably want
to avoid that. git-fsck definitely should verify that large remote
blobs are good without downloading them (a new "fsck" command to
external odb, maybe).
-- 
Duy
