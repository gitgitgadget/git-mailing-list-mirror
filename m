From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ewah/bitmap: silence warning about MASK macro redefinition
Date: Tue, 2 Jun 2015 23:50:34 -0700
Message-ID: <CAPc5daV4UDhGb-5eF_nGxrmpAArxj4X2Qm2kQ3ESMyZvic2A2Q@mail.gmail.com>
References: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com>
 <xmqqegltzriq.fsf@gitster.dls.corp.google.com> <20150603045117.GC15989@peff.net>
 <CAPig+cR3Xt5FNSYbDPhW=m5aEOMq8mCLRSe+mjYfVvdS0R382A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Vx-0005Cp-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbbFCGu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:57 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33417 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbFCGuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:55 -0400
Received: by obbea3 with SMTP id ea3so653248obb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fLNGQh0A07lZadollgJnrSNGCBEIxxgfSnFKAkfavu8=;
        b=x6IZEMs9r8u7vSJPi7VjE8yRRWDD4g8b6qgSd13bAHjof6w1ZVc2aWGDrVzP8uP8su
         2NdESxRxzGs71OoRKR/q8O6wGQs2nREyxo4iSRoXl06VKziEUNcBOJsonQyX/CxAYTE2
         MMf5vjoxMss3/3cSWUNad2Ymx0ZiEWdUx7xVqEMIPeCUSGLydnwK8y6ozxDL0MIqYfc3
         Y+io5BtboIQHW/yo/DdaYXOwAap/mxkoX0BPKko4wBvG3bHB508Yh+dm7WyZKXfCBk+v
         P5VcLcwEI6K6rZ/t7Qijgmnw7HKKPFoeKQ+MF10sloBqEltUNhllUMGOlUbDlcKgrZZd
         1qew==
X-Received: by 10.182.252.99 with SMTP id zr3mr26153872obc.44.1433314254961;
 Tue, 02 Jun 2015 23:50:54 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Tue, 2 Jun 2015 23:50:34 -0700 (PDT)
In-Reply-To: <CAPig+cR3Xt5FNSYbDPhW=m5aEOMq8mCLRSe+mjYfVvdS0R382A@mail.gmail.com>
X-Google-Sender-Auth: LtZusi38DVh-ofWBGJpsTr7EvUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270655>

On Tue, Jun 2, 2015 at 11:28 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 3, 2015 at 12:51 AM, Jeff King <peff@peff.net> wrote:
>> ---
>> I'm also happy to split it into two patches, and make Eric the author on
>> the MASK part.
>
> I don't mind being an author of a patch, so splitting works for me,

OK, then let's have two patches, one from you each.

Thanks.
