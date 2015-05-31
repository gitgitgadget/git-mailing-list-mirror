From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sun, 31 May 2015 10:20:53 +0200
Message-ID: <CAP8UFD0hpUo5iooforU82c2BcFDYSbt7Gqn49qFW+LiwcVQJ_g@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-8-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:21:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyUO-0001P1-OD
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133AbbEaIU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:20:56 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38429 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571AbbEaIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:20:55 -0400
Received: by wizo1 with SMTP id o1so69656613wiz.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6DOHHmBLDzkvAops75ODlz9/2H6AdNtvUKHoTYKJpzs=;
        b=vPLDZP3EhoRuuLI40OTq/9ZgJduT/QToAXbS/ewkhXDwUx1L25dvfZjKoN7Mb/Ak8G
         Q9q+uSwhbPuyxL8oeSH5wkPbsSLgyNrGIR2bh/pS8vdPIMufEpcbosE2TDwsyhWawL+c
         cKkCbSKKWgKaf2vZSJreVeWllb9dvPt5C1KOZNup/JaXCTHM6R3k6G3zzWeuDqvPYwbx
         r46CxYIlrprE3w8n/hQsZztEj7jgkLdZEsXStAS71gKrTkwNm68o8TwGVAUVVj9nBpYn
         260+36vs+e5rOHYj0agBSjMVXuXiJoC+H1VAmydZ+aED7wYm2jNun2YYAM+owSoB2G2y
         piLA==
X-Received: by 10.180.98.103 with SMTP id eh7mr10511021wib.75.1433060453940;
 Sun, 31 May 2015 01:20:53 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 01:20:53 -0700 (PDT)
In-Reply-To: <1433008411-8550-8-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270324>

On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> -struct ref_sort {
> -       struct ref_sort *next;
> -       int atom; /* index into used_atom array */

Where is this used_atom array?
I searched but couldn't find it in the same file.

> -       unsigned reverse : 1;
> -};
