From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 15:28:57 +0530
Message-ID: <CALkWK0kwia-OQj_=B7A3k6_DxCJShqoJehNQu8eApgdo=OzQwg@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
 <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
 <CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
 <CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com> <CAMP44s0x62h+n29osEdRvuhBtvDY7bD3m1_jDq4ZDMrgFwP0ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:59:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuyN-0005Cs-3m
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab3EPJ7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:59:38 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:34623 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3EPJ7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:59:38 -0400
Received: by mail-ia0-f179.google.com with SMTP id i20so2105987ian.10
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9foZzbtdX9jl0iKE3ABMz6W1wYKMVmhCrXogLx0mHnI=;
        b=vpP1EVsXTIxu5YUbor9tPzXIFttmLOee2+Zfpnqe77OIL0j2MbIf1GJSAiG3I16Y2r
         oyCHaaTD3iAM4Umh9L0M32VlA+dCHFbUFvtDIu3t/Ca7Yobv3srfwkDdRXV+IdogM+Mf
         bTu0vBmm8dBG7qQ0AvoCWajmrS2RD27ina/HORL6/accz/BFWlvqK3FpX1qkpgayNUty
         xEWqv3GXv+frBJ56dzvyCHmYk1reZahd1bmcYKl8i8CzUkbc83NNyFC4c4I3KP0MlSek
         uOtuWAhhsN6DOikM8ha51gV+sxSfWfVqOKJJaPxz95A+V2azxaF9jAxlEurM/Al5EDhe
         MZPg==
X-Received: by 10.50.73.65 with SMTP id j1mr8722584igv.49.1368698377893; Thu,
 16 May 2013 02:59:37 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 02:58:57 -0700 (PDT)
In-Reply-To: <CAMP44s0x62h+n29osEdRvuhBtvDY7bD3m1_jDq4ZDMrgFwP0ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224544>

Felipe Contreras wrote:
> Why would I do that? When I do 'git rebase' I want to rebase on top of
> 'master', not 'origin/master' (or whatever the upstream of 'master'
> is).

Ah, so you want @{u} to point to refs/heads/master, but want to modify
fetch to act on the hard-coded "origin", not @{u} (wouldn't you like
to be able to configure this?).  Seems a bit yuck overall; I wonder if
there's some other way to achieve what you want.
