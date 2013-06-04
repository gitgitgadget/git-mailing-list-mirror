From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/15] Towards a more awesome git-branch
Date: Tue, 4 Jun 2013 19:49:36 +0700
Message-ID: <CACsJy8BDwVL3NC-vweCzn1Lr7-rdOvFGzopBf3qZcO6wyx4fhA@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:50:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujqgm-0008Co-HC
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab3FDMuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:50:09 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58189 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3FDMuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:50:07 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so260278obc.27
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W8JlqggO4wibwsz4oguEl5xVo3883+jfQzxeIBVxEdQ=;
        b=FDVChqVF0du1A3CBZcCQfd1xmazHGlceAJKHrNPoUUnCuSOPrNqOaNO4HRNVlPRrZz
         zqJon0xA9xKbf+58FO2aGmi/HF2l6i5N4ljUdNPKp+DR9fVECQ6C7r3zbkbRXw7vwSe5
         V35Xz4YOxj4qLkN7UivyJIJkfx2E607FZlI16B0qYsVoBT+/YbHowKORvwleYxhFpBVp
         zAqjpePO93phEsOn5lZJCRJpVUi6VeExl+pZpLaYx6flPInfGvTiQxS5oVnwUStZVLN0
         8bpoOaGEEFrwhrXB1ztSJScLne+bhtbuRQXHsiZNvr83cd10yfGcZm9Lxor8wJPA1Qf5
         11WQ==
X-Received: by 10.182.220.130 with SMTP id pw2mr10536427obc.80.1370350206727;
 Tue, 04 Jun 2013 05:50:06 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 4 Jun 2013 05:49:36 -0700 (PDT)
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226360>

On Tue, Jun 4, 2013 at 7:35 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Hi,
>
> Duy and I have been working on this topic for some time now.  Here's a
> review candidate.

I'm still hung up one the detached HEAD thing. It's a bit quirky to
put in for-each-ref, but for-each-ref can't truly replace branch
--list until it can display detached HEAD. But I think we can finish
this part and get it in first. Should be useful for some people
already.

> Duy is currently writing code to factor out -v[v] and adding --sort,
> --count to git-branch, but I'm having a lot of difficulty working with
> a series of this size.  I'm leaning towards getting this merged before
> tackling branch (who wants to review a 40-part series?).  Especially
> after [14/15] and [15/15], git for-each-ref should be usable in its
> own right.

Agreed (a bit of concern about 14 and 15/15, though). Signed-off-by:
me for the whole series.
--
Duy
