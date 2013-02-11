From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 11/11] Unify appending signoff in format-patch, commit
 and sequencer
Date: Mon, 11 Feb 2013 10:49:29 -0800
Message-ID: <CA+sFfMdBTmu8JsqZaJTUeA8x8Mb15R90v4w3fMQmUgkCDP5Qjw@mail.gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
	<1359335515-13818-12-git-send-email-drafnel@gmail.com>
	<20130128033921.GP8206@elie.Belkin>
	<CA+sFfMduqEJPtDQyTe2n7QiLmDpTN7MzLGrUNf1hWf-h0rGzvA@mail.gmail.com>
	<20130211090009.GR15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4yRv-0000s3-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 19:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758870Ab3BKStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 13:49:31 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33711 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab3BKStb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 13:49:31 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so3662588wie.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GjzM54lXzh/XudfQwsNsS704zABjEjBM5ICI1D5eVU4=;
        b=N9YTck9QuItRGwtT82AT6Yha7hgRKnDFkbaGO13J34NOP6mLg0Wux12JFm4/tbXKWU
         G8yg9MZ3EL5BaULiwjeK0Oyh9WPkzrydQOvB5VoSaKuYyHQMIpxNSM9QE5XYR8KLRxDT
         Z4IjR9gPcguTeT1hdjdO2gXs+2i+dweaG1iwJ4UaqqSc93LBTupCXl8L2M+Qu5/pT4XJ
         KZxbXu2gpceW3TqpO7XHr8tj7kpL2ctS76i15YOHOY7c21KtTfV5tvEJVIIPqofKns0q
         AdN6u6pz5kJwyv+4EenK+mkgE81GgZOiK6hZW9S01dfljSkhsyrDSA3WEfSrsGLhkHUk
         RCFg==
X-Received: by 10.180.109.82 with SMTP id hq18mr18287392wib.0.1360608569666;
 Mon, 11 Feb 2013 10:49:29 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Mon, 11 Feb 2013 10:49:29 -0800 (PST)
In-Reply-To: <20130211090009.GR15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216074>

On Mon, Feb 11, 2013 at 1:00 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> By the way, regarding what the right "--signoff" behavior is for
> commit, cherry-pick, am, and format-patch:
>
> I think the best behavior would be to check if the last signed-off-by
> line (ignoring acked-by, bug, change-id, and so on lines that follow
> it) matches the one to be added, and if it doesn't, add a new
> sign-off.

This makes a lot of sense.

-Brandon
