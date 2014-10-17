From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Fri, 17 Oct 2014 16:14:19 +0700
Message-ID: <CACsJy8ABm93QTZm8wnJUYaJ6zC2bXBDyois+Wrq-vCB=DCJmVQ@mail.gmail.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de> <20141014203114.GB8157@wheezy.local>
 <CACsJy8AmBr2YTJkVw4BDD95RVE91EEBtEyakOpb77NDXaVBzJA@mail.gmail.com> <xmqq1tq9xnrs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Kirillov <max@max630.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:15:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xf3ci-0002id-Bf
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 11:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbaJQJOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2014 05:14:54 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:65209 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbaJQJOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 05:14:51 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so1194206igi.17
        for <git@vger.kernel.org>; Fri, 17 Oct 2014 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s09owCBn0LjACFwbBitXtEfjRaMubEc7LZyp1vMyOiA=;
        b=avDgQ/LuUvdxQnKImLr1U/IykVNhlY8mrkEpAySD0aXYRdNmcnMGjP4+ZUN5phB+6Q
         vUt5mXh1rcOcappcz9MRFKkhO2B6c5pxeGDcbgGpnqFKyeF4O4i3wBCYn4LXOb1RkF+w
         YxPBl9tUS8T0nAhOyFsSt5CVbHhCGgE6fPMdtRvcyqyKvfV/kmZ7rEja96wouSmRvcNA
         CyCUqCfbyVi0OmVaMFambM6hDT4S/GQXMfnc89RLUVT7A6+5CO+Q5ldNviE+/RykcJrC
         jKyIX8cDMAW1YJCvCDNTgEUQsZLykzDFyN0YJNeqRfkP29hQw7AgTFTKjduq5f1vrR1N
         Rhlg==
X-Received: by 10.42.114.18 with SMTP id e18mr9462317icq.42.1413537291050;
 Fri, 17 Oct 2014 02:14:51 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Fri, 17 Oct 2014 02:14:19 -0700 (PDT)
In-Reply-To: <xmqq1tq9xnrs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph.  I was hoping that the multiple-work-trees topic was ready for
> 'next' by now, but we may want to wait to see how the interaction
> with submodule plays out to have another chance of a clean reroll
> before it happens.  This is a topic with large impact and is quite
> intrusive code-wise, even though the intrusive parts are cleanly
> done.  So we'd want to take more time to unleash it to the general
> public than more usual small scale topics, anyway.

Originally I wanted to get it merged without submodule support, but I
failed to spot the local_repo_env problem and could have caused a
regression for submodules. So yeah delaying the series does not sound
bad. Not sure about the reroll (i.e. rewriting current patches). I
think putting patches on top with explanation is better. But we can
keep it in 'pu' and see if we really need to reroll.
-- 
Duy
