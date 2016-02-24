From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git "thin" submodule clone to feed "describe"
Date: Tue, 23 Feb 2016 20:28:42 -0500
Message-ID: <CACPiFCJ216dx9s6YynH2d8StyNxR4zci9OhGKH4BbJXXf4SSUA@mail.gmail.com>
References: <CACPiFCLnXLdt5rLuX0a3pTS3OphKW=1oVKxyYpwvSLhY7ydb2g@mail.gmail.com>
 <xmqq1t83yuv6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 02:29:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYOGL-0002Bw-9S
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 02:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbcBXB3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 20:29:04 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36355 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbcBXB3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 20:29:03 -0500
Received: by mail-ob0-f180.google.com with SMTP id gc3so3755758obb.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 17:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aOgIHinYHUj09iif53HVXRrX2QbA7MeRrlLDFJwKBi4=;
        b=eL9DISmU0H7VBW0cyPJ+QnUC13JQ4QrgbXGOsJVvgL4zRCxTJ1kwzCjKgyW7p+DvEB
         v5qqLW4gCOKuuKHzoXV9QcIAifLHM5LIAYWJTt6+wRAjfT78UKFihM2ZdZepDZpR94DX
         Od2vLw0SW42tlLGhilQQl7X6ddduUnOxKWYvrAGI51HUgSMz0Zg+01ZuZUfA3/o1kcBQ
         ILG6gmFckda70laIoy9DYD1LvXKl/gbxMox5OxiaOymTjHKwV8C8Tk2Wz+dRY6LlBkvo
         gq/36753SxL0pkdkW9c2D63ZTxm7iy2bvJBD6z7joiKlfE3Q0iTWl4plwXGTHaROPlD3
         pwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aOgIHinYHUj09iif53HVXRrX2QbA7MeRrlLDFJwKBi4=;
        b=a3Tl4bzZF4IRKMG/IwsYhE6IxA8FP9QRvbJJ+xaAvKW9DbE0DjHYRBCuRou1ZJobSz
         wKo4n5fr4CXa2ydZ6Xb7BL71/8Lx0geyv9KeRUf3WMnWjsOJtkzL5Gp/aidmUoZDN87h
         GwwNIvnEiX6I3ffHVVlyZmoqZKbqA4FQVI+kc34icZuvUVqReWkaI/H1RObR9MtgiLcE
         XuDstcTrlFbFFXxrB4c+vW5AobgI+/N+L1GPV7dVWRLsNf7xUnqkji9xb59g5x/j7VFw
         yUkhAEz9g+KW79w4cKSpWL9LtjVWxyKtgArir2RK7XaGA7F7GMmyUdccTsbU1wJNQBwN
         Dh9Q==
X-Gm-Message-State: AG10YORSEFkdlpwMhalDUSRbvpBSgcPtu1qhmpF83WrXx2LK2IHuhQYcnoMUmxlzp7LFKHINIbnTHhXANXuOXw==
X-Received: by 10.182.61.38 with SMTP id m6mr31097738obr.32.1456277342344;
 Tue, 23 Feb 2016 17:29:02 -0800 (PST)
Received: by 10.182.19.225 with HTTP; Tue, 23 Feb 2016 17:28:42 -0800 (PST)
In-Reply-To: <xmqq1t83yuv6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287154>

On Tue, Feb 23, 2016 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> No, I do not think so.

Thanks. I will probably setup a pre-commit hook at the top level
project to update a submodule metadata file.

Not the prettiest but... :-)



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
