From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] make t6302 usable even without GPG installed
Date: Thu, 17 Mar 2016 03:31:53 -0400
Message-ID: <CAPig+cR-sPbPy0Y6W5e3O8ocNLuDir2z1+QssagynWieYdG13A@mail.gmail.com>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
	<alpine.DEB.2.20.1603152038110.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agSPX-0000nH-4V
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 08:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbcCQHb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 03:31:56 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34605 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbcCQHby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 03:31:54 -0400
Received: by mail-vk0-f65.google.com with SMTP id e6so5652084vkh.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=A/nbscticipg0rjc6zAAwGi6NhvEogOPBxQLHud5Lkw=;
        b=aS6oWEpYaST1mPZntkTY0ivHDeqf6NyItN8PIOcaM+OoWwGe/J+6UO7cCRKjrtChB7
         xNaqT7QW3SKeUohjlKdv6zOrsKWhm2JPx0uaB/yCAiom3NDnMnzNrCbBA86weRFzHV5x
         KfITHDIND+jnGrzHcq3AF4RZB9z1989yioI6XuUEBCgpg3yX6UOBpXfyHnRWjbII4qNx
         1TyhRMVnthaSBmCQicUQ5KAoXy3RwnfUIzdrgZyU51heFS2R3rdA7GxRQQu3eMTtZBai
         vAgiQuTTdyd2ryPPlsZ1aZPRE8Z5BFQGi886eFEhI5mYJcWb8U4ttPtx69gO2VXvvpRa
         cLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=A/nbscticipg0rjc6zAAwGi6NhvEogOPBxQLHud5Lkw=;
        b=EqaSe3WvvTqw71tCMZ5a1zPluN6VeifZ4PVZxeFIZRo8n+8hi7K6wryMC5DGn1QAdY
         /uA3bEzRJoxGjDhQBRfEUzgup58BdB61JsDPj2sIMGEzkO5TADMO18cRhuc2rchYofC/
         xO7Pmthz670qEIk54fygngne6hl90b7cxbeZiGbL/jSXIXntrwWVGKdqqrrxMBMhw0eC
         2ndfDFB1nHC3pXRxDSP8L+DN4stJnVNnaeAW1JoS5aT+Hs+oco65vPYUerVHokRIdyJB
         DNd7cwB36KWOLWupeP5IFGvD5YSX5orlFRWioiGrky/zQNFfqxhPk7kpq6luKABZuwub
         SGLg==
X-Gm-Message-State: AD7BkJIPJhVHR2Gp5wfOTDQTh3FX9crMArex8IFMvdAVd22lwwYVxAJGHd3DcYmVST2CvK+gxXXoBkzf+f94mA==
X-Received: by 10.31.146.5 with SMTP id u5mr4489154vkd.19.1458199914000; Thu,
 17 Mar 2016 00:31:54 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 00:31:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603152038110.4690@virtualbox>
X-Google-Sender-Auth: d754B9ZxZjCjfraCuSMHa5YGJLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289083>

On Tue, Mar 15, 2016 at 3:38 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 6 Mar 2016, Eric Sunshine wrote:
>> This is a re-roll of [1] which aims to allow t6302 to be run even
>> without GPG installed.
>
> What a beautiful story this patch series tells. Truly a pleasure to
> review.

Thank you for the kind words; I appreciate it.
