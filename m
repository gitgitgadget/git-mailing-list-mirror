From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 03/10] branch: bump get_head_description() to the top
Date: Tue, 11 Aug 2015 18:42:58 +0530
Message-ID: <CAOLa=ZThF+5-mzyR+wXOPzzTWoGyyPvHnw_x9TbyjW=xkQKEsA@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-3-git-send-email-Karthik.188@gmail.com> <CAPig+cR0F-CdsFRoazqPinFTOpWkCwLoNHva1X1bMo8LapMMVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 15:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP9Mz-0007Ej-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 15:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934164AbbHKNN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 09:13:29 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35834 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934136AbbHKNN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 09:13:28 -0400
Received: by obbop1 with SMTP id op1so148106659obb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g3ILzgpzm2ShLyMyw2tAwVjl8K9BfTU1RaD37UXKR44=;
        b=AduHyAsFqjrHOtwuj8eDPIakRBGd4/48JvduRA7nJlKbb/hLDX+v17xR9gpdSxLFN2
         JsKJnaNHGvjK5qxJ6RU7U+GehMkHKxQZxpbHqAJCaEDI23QXD7KinkK1kU5tH9hay8pK
         nda+povy8Pc6Q9oHL1D0DXAzFl6t2l310rYwMJMYjquxm5L2u2G5BTWCHCRvHee8O6Zn
         NKNXVWxz/zn3dn1YEYRZO4dLJZ8eNA1Q6WIeBBShooXb2u/hNYnEeJoSEwIxExZsUL4I
         XahC9sZ6M03bm/axXTUTXpAmoDhrnlPmWgIQ1W8aSP5gjPXJXBUlEgp3zYLj8uA6+HA1
         ypiA==
X-Received: by 10.60.177.195 with SMTP id cs3mr24345395oec.37.1439298807979;
 Tue, 11 Aug 2015 06:13:27 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 11 Aug 2015 06:12:58 -0700 (PDT)
In-Reply-To: <CAPig+cR0F-CdsFRoazqPinFTOpWkCwLoNHva1X1bMo8LapMMVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275688>

On Tue, Aug 11, 2015 at 7:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> This is a preperatory patch for 'roll show_detached HEAD into regular
>> ref_list'. This patch moves get_head_descrition() to the top so that
>
> s/descrition/description/
>
>> it can be used in print_ref_item().
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

Thanks, will change.

-- 
Regards,
Karthik Nayak
