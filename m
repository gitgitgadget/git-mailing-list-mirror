From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Centralized git
Date: Tue, 31 Jul 2012 16:52:51 +0200
Message-ID: <CACBZZX7drB62ohpPOEs03SGe12sDmGzJDcGMboF50y9QLa6HbA@mail.gmail.com>
References: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
 <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
 <CAH-tXsCGxpqP+C2CiCCB88exMT6H3w0id-otFWPRXrhhreRfWg@mail.gmail.com>
 <CALZVapniy5iNJbuOikZdgHv2qQ80nDSATw8udV=Tk2wNgxXY4w@mail.gmail.com> <CALZVapm-=HXdfb6LCrc60HgUJA0ptzb+E5r3Y1C2w_0eBo1onQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: jaseem abid <jaseemabid@gmail.com>, git@vger.kernel.org
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwDp6-0005aM-7O
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 16:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab2GaOxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 10:53:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41534 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab2GaOxM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 10:53:12 -0400
Received: by obbuo13 with SMTP id uo13so10700870obb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AgjJGu97Th6L30kiJWiS4WSUA7k43euKxoR7jNDxNK8=;
        b=TCmSEkmJ3EffhYSnOUYCwER1Bv9zvnl4aQuILeVPmjDV4bhKwoCoAJOT91KUK51Kfn
         c0AfrdHjElrhJzvsKanYPEwZkeYU6OV72IPHgCrv6YFf80JVVyqjh2dtyQZVpKZelDBj
         g1gZPnvyCVeKADlYgqPz2HA7dCrxbNVuiQltFZ7NKMBvJeHjjmBsAoEbQnSQg5pfagAE
         8Nc31A5xc58/CNwSEtkQ1fYEufVaKJCrmKWSYsTuJbua8le1wVMRipdS4WH9/cp1nqyn
         h54gRf97Ugo3mPMcD5IuSdkH6vrEFUtQS8GudHnJ3rmcQZdjjB/xmDp44o44lDqMQlK+
         PCNw==
Received: by 10.182.145.8 with SMTP id sq8mr23633098obb.50.1343746391970; Tue,
 31 Jul 2012 07:53:11 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Tue, 31 Jul 2012 07:52:51 -0700 (PDT)
In-Reply-To: <CALZVapm-=HXdfb6LCrc60HgUJA0ptzb+E5r3Y1C2w_0eBo1onQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202655>

On Tue, Jul 31, 2012 at 3:08 PM, Javier Domingo <javierdo1@gmail.com> wrote:
> Network, in this case is cheaper. The thing is that If I commit
> frecuently, will have plenty of GBs of history, that nearly for sure I
> won't use. I just need to have other people's work to merge. But I
> want to think in Git style, I am pretty accustomed to that way of
> doing things. That is why I sent this mail here.
>
> The idea is that if I modify 700MBs of video, with 20 commits I would
> get in 21GB. And making a pull would be... just even more horrible
> than anything. That is why I need to have also last checkouts filter.
> Just download branch's HEADs.

You're obviously aware of git-annex, is there any reason you can't
just use that?

That would give you what you want, you'd have a moving window of
current files, and then you'd delete old files as they become
un-needed.
