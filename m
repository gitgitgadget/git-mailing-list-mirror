From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: [PATCH v2 3/4] use new config API for worktree configurations
 of submodules
Date: Thu, 17 Jul 2014 13:08:22 -0700
Message-ID: <CAPc5daWBDwJGPexMEM+fhhqM6Y8eG95wg2Z==2_oKEZTgnjnVA@mail.gmail.com>
References: <20140628095800.GA89729@book.hvoigt.net> <20140628100321.GD89729@book.hvoigt.net>
 <xmqqy4w38v6r.fsf@gitster.dls.corp.google.com> <20140709195547.GA3081@sandbox-ub>
 <xmqqegxu9ojh.fsf@gitster.dls.corp.google.com> <20140714205759.GA3682@sandbox-ub>
 <xmqqfvi2tfj2.fsf@gitster.dls.corp.google.com> <20140717195346.GA23563@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7ryx-0000qu-T3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbaGQUIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 16:08:44 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:42038 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaGQUIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 16:08:43 -0400
Received: by mail-la0-f44.google.com with SMTP id e16so2140481lan.31
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=P81t6NsDjf+iEAB6ve79nM+N5pswuT1AtwxoljXXC8k=;
        b=TRPTKfbMOTRiz3dXSt9mQd70dS+n6ULbHy0jLB9mFlsFKmxhh3EKLc7GmSn7U5lv0V
         cKH2d4js3aoFzRniIgc7rZ/aITkZO6wpXktvs7GS5URA7BKEsZmRey5moF25A+A3/qB6
         2MzhCKruafTApgww7LfCbmI6tZv9i22HOaQxOEAob4FUYLKLPlCePsHfxAmw8nv1wRYd
         l13oAgERAQRzUQYNFe+VbPM0RCtGPdvssvji4CwKncsW+6hKZyFnNw3Tc6EcnJNk/8HF
         fgLZ0/+DIAUUFueLyJYXYbT5StUoy8R0SfcAhWg4Hw4LmbpKhWVTRexbmLDXog0ZiVDC
         vMTw==
X-Received: by 10.112.159.200 with SMTP id xe8mr27414944lbb.55.1405627722170;
 Thu, 17 Jul 2014 13:08:42 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Thu, 17 Jul 2014 13:08:22 -0700 (PDT)
In-Reply-To: <20140717195346.GA23563@sandbox-ub>
X-Google-Sender-Auth: R9Kmd2jlXV64iuyBsjYwBKLDqXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253778>

On Thu, Jul 17, 2014 at 12:53 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> On Tue, Jul 15, 2014 at 03:37:21PM -0700, Junio C Hamano wrote:
> > Any other thing that still needs fixing in the series, or is it now
> > ready for 'next'?
>
> All comments addressed. From my side it should be ready for next.

Thanks; I am running today's integration cycle with this in 'next' now.
