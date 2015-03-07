From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is empty
Date: Fri, 6 Mar 2015 21:19:57 -0500
Message-ID: <CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:20:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU4LY-0005MX-9P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 03:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbCGCT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 21:19:59 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:45789 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbbCGCT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 21:19:58 -0500
Received: by yhaf73 with SMTP id f73so6665242yha.12
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 18:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=flNyLDD5Wywxd9tehkXX8r+mCCd36TBaJdesqXmF/PY=;
        b=TOWSbqKXh6x1fLz/RQp2aHd0FownhlFDKQ+GTUDWzURTVd99EpjAhWPJLIFc2aV5EN
         6fL3Jo2E3DqVOrmT3xi4R1zrHPEYi1l3cTtYMjpX6A3DJBkxl/wEvqoDA73b1FVOLfZZ
         Qp5Qpk2XpTDeqgMewe5ZnT9d8QEXLm/sSc6eQRHJOjpYGAIFR+zrrRDThxrww526bFxw
         ki8KFoKujvGP9pp+ynz8EfNG7jEDksqlS0Taclv++d75Lp7Bn1jqwFajA6cJ8bYdDb8p
         ZT4n/tokkAbe+riVCXMGu1mVudLE7LaoJ/QSqanqZFu+fBGQh3wcgalAquQh1mJaTM+X
         SF+A==
X-Received: by 10.170.221.2 with SMTP id n2mr17651256ykf.74.1425694798029;
 Fri, 06 Mar 2015 18:19:58 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 6 Mar 2015 18:19:57 -0800 (PST)
In-Reply-To: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: dkgQG0XnsHYBp--SumCOLwt8DJ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264987>

On Fri, Mar 6, 2015 at 6:18 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> 'git -C ""' unhelpfully dies with error "Cannot change to ''",
> whereas the shell treats `cd ""' as a no-op. Taking the shell's
> behavior as a precedent, teach git to treat `-C ""' as a no-op, as
> well.
>
> Test to check the no-op behaviour of "-C <path>" when <path> is
> empty, written by Junio C Hamano.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunchine <sunshine@sunshineco.com>

s/Sunchine/Sunshine/

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
