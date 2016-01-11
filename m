From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] Add test for rebase with merges amd redundant commits
Date: Mon, 11 Jan 2016 18:50:06 -0500
Message-ID: <CAPig+cQEF7w5rDQK3X9dRUEq_yewEEGA36tcOVMKjsN5hAT12g@mail.gmail.com>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
	<1452488421-26823-6-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, chris@arachsys.com,
	nhorman@tuxdriver.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 00:50:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aImE2-0003sD-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 00:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762041AbcAKXuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 18:50:08 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35908 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762035AbcAKXuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 18:50:07 -0500
Received: by mail-vk0-f67.google.com with SMTP id e64so2900133vkg.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 15:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pNRuRWLP5VN1vhLTHawxEn9OL1Gj9OYEVHFLuTB/J74=;
        b=buu9/mJcVkuYBEtMxX6qVJbNZkqw+dzy3rFwKb/LpQuUqB3O0G9auW38+Qy5b9vB2X
         e8xum8T98s/qMvTdTpJ7ydqRtLpuGsd5FdyL07GQklVpPt2nMLOrhHPpn02WoNDQQydB
         FXRHGMBfby3E2241Op3AcRnKct0Er8jBon88ZxcLYbo2YOdhIm7sTpq3GhiWJCxQu7aO
         sOsFvxNng4tDIwv0YNLqvHHUPIMaDLwHIM4c1Hb64T2j4YOVjBOJgAcc+P6Gk27AHbZp
         MJelLvk1KNduVfTeXvH37OltZefSyZhJJiz9cnFVADJOMBtKlwub9/qfb6oiUgRBAYnl
         0/Cw==
X-Received: by 10.31.182.143 with SMTP id g137mr57742174vkf.45.1452556206577;
 Mon, 11 Jan 2016 15:50:06 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 11 Jan 2016 15:50:06 -0800 (PST)
In-Reply-To: <1452488421-26823-6-git-send-email-greened@obbligato.org>
X-Google-Sender-Auth: 3buj2Y9EUC56-EoEvctXC97-vGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283736>

On Mon, Jan 11, 2016 at 12:00 AM, David Greene <greened@obbligato.org> wrote:
> From: "David A. Greene" <greened@obbligato.org>
>
> This tests rebase --preserve-merges in the presence of redundant
> commits when there are actual erges being rebased.  It primarily

s/erges/merges/

> exercises the --skip-redundant-commits option.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
