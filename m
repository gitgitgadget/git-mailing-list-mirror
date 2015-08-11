From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/10] branch: bump get_head_description() to the top
Date: Mon, 10 Aug 2015 21:59:36 -0400
Message-ID: <CAPig+cR0F-CdsFRoazqPinFTOpWkCwLoNHva1X1bMo8LapMMVQ@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
	<1438693282-15516-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:59:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOyqr-0003h0-HS
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 03:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273AbbHKB7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 21:59:37 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34228 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbbHKB7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 21:59:37 -0400
Received: by ykdt205 with SMTP id t205so75151817ykd.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 18:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gs5AmaIuV9mTEebg1WOAx4f5KJWd4JD0AyMaoYLt8XE=;
        b=rbpAbrTWIdAMdA/mMVYY7UfgVcerQWjQYL8MmpNKXXYZuPhKh1vOLWmiCWc8zwTG51
         MOUJPy781f2taPynuZDZK2bryYNwxy0XETmqeX+4Ukg6z0Npe7N10AIK3HIg2qJ5iiTd
         DgKUwa59bm/HwNAtIdUikVfkyPoSCUZr1BhIdKOHm1UGUjSLV4PX9kw72NqRM7Kt87uB
         yjEG+ULzYMpNaVOMnkijHikvXj1YOIXVinYqdk854d7BL8hTmldPK317IrNPphpTTm9C
         eNhlQykriOuxjsceJ5vDhRTsipE5F+CClxcA8Noi4LtrJZSFHxsx2Vsh9wP2A8PDFWq/
         mtFA==
X-Received: by 10.170.138.134 with SMTP id f128mr25162533ykc.90.1439258376592;
 Mon, 10 Aug 2015 18:59:36 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 18:59:36 -0700 (PDT)
In-Reply-To: <1438693282-15516-3-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 5tBmhnPyYIRMwikFa3T_cFjNg78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275668>

On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> This is a preperatory patch for 'roll show_detached HEAD into regular
> ref_list'. This patch moves get_head_descrition() to the top so that

s/descrition/description/

> it can be used in print_ref_item().
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
