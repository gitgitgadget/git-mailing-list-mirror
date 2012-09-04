From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Tue, 4 Sep 2012 19:40:33 +0700
Message-ID: <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org> <1346544731-938-6-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 14:41:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8sRh-000063-F5
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 14:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177Ab2IDMlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 08:41:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41206 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab2IDMlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 08:41:04 -0400
Received: by ieje11 with SMTP id e11so4712705iej.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vKVtOGqrO1hbAeYf1R9SlmHelNxRWeIQWKyvIleOtMY=;
        b=cTVXgOaSOkqZz8LWwWOeyq4dljgEPPvhG89zFf08EJ73RwfXJRHHDkMshNco1HAHkr
         AuJ8Q2rdnLo8O+XFEIw/0OhaoslfwgVPyOOCeXx38GZ5vh08cQERZ1QzueOXswAo4pqG
         RC4wdaxJaIwz5eMk3YpzbmgZWNUrTnGZ+LaLPy/pOPFhDDlnPXXhJUl9pW48gl/Q/LkD
         x/TsyUOsrbKYcyn5dsHbOETPPYyeNlhyVKvmKwWTkd+KgQ+D9fhj4f17XLU+vjrt7YYO
         GNIMGuo5Scws33rA11BG/Z9UhzZ9fhJvhX+86gqfYyv365MVpX2Kj8rkWYJkzfhYh0DN
         uQeA==
Received: by 10.50.193.201 with SMTP id hq9mr13596158igc.48.1346762463647;
 Tue, 04 Sep 2012 05:41:03 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Tue, 4 Sep 2012 05:40:33 -0700 (PDT)
In-Reply-To: <1346544731-938-6-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204742>

On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
>  extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
>  extern void path_exclude_check_clear(struct path_exclude_check *);
> +extern struct exclude *path_excluded_1(struct path_exclude_check *, const char *,
> +                                      int namelen, int *dtype);
>  extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);

Exported functions should have nicer names than *_1. No idea what are
better names though, maybe exclude_path?
-- 
Duy
