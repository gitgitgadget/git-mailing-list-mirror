From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] for-each-ref: add %(tracking[:upstream]) for tracking info
Date: Sun, 19 May 2013 16:48:28 +0530
Message-ID: <CALkWK0k5qM3CZoivC1GJaBfwxWwvpDVtU7mHmm3feiLKr4kxXw@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com> <1368959235-27777-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1dz-0006Ds-5Y
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab3ESLTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:19:11 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:47795 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3ESLTK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:19:10 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so11676565ief.26
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=QYlX4rXEcnOymitlclWEwEEZjVCI2qPVzcEU9s9MpZk=;
        b=Ef3aDc/tHQ2492m6paQIwCeYVfVOyGuIwnUmbsdjfExTTg9GxHD0DI+YlzUDnumFQ1
         5tWyboYyMSb1LRZak7KFmWp/jhc155hOYPe2vdw6/gmfTZSj8gYBYAtBsu2ERprjivYf
         jSu3yVCwboyIuH29+jkuek0wk0twOVShKNszIX87MKeodTewylTqr8TfU+9R58mcaAlF
         BVHG+S45Nr3akk84XVn/rNJnFzBODtiRog4ENzImmrinDRgyCLjuSrK8ZJipl4aykAbs
         6k6oCa8+KXLYHWugQRoEHDTQlG+A8MGXWt7+fuTIpXnphf/IR5hkk7qTfQA8STZfi/l6
         OTSQ==
X-Received: by 10.43.68.134 with SMTP id xy6mr24300818icb.48.1368962348373;
 Sun, 19 May 2013 04:19:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:18:28 -0700 (PDT)
In-Reply-To: <1368959235-27777-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224851>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 498d703..b10d48a 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -76,6 +76,8 @@ static struct {
>         { "symref" },
>         { "flag" },
>         { "current" },
> +       { "tracking" },
> +       { "tracking:upstream" },
>  };

You just threw the upstream atom (and "upstream:short") out the window =
:|
