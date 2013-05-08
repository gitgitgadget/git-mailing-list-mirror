From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 8 May 2013 02:42:13 -0500
Message-ID: <CAMP44s0yWXHAPAE3vmFpSpVyHi+SeHJEXBS_y4sJw2eP7H-ADQ@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ktoQg5pd-tSiP=wn-3JGv-N7OHK_FkNjPx5HycdjBsKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 09:42:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZz11-0007rF-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 09:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab3EHHmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 03:42:15 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:43255 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3EHHmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 03:42:15 -0400
Received: by mail-la0-f49.google.com with SMTP id eh20so1426166lab.8
        for <git@vger.kernel.org>; Wed, 08 May 2013 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SBf8tw2rTnxcOVjvADOpylTzdrc6OG/vd4tf1wFyJYE=;
        b=oCuaWMjzNfyn2vQrSi9GUvDqtgVrUIrHruopplnzxmh/ZyZTGtaLo0/7MnypZn/6il
         A/Wa8m00nG5fogSb2EwvbJe/sIFuo21TiiUEpSkY7ydrjnmrCLq8ScR744ySOIdaB1Ql
         s03KQYlOzjUZJEmFU+o2YjyTwf7D9cyzEt7NzI7xBnbotwGpQkDhWJsCMEgxYUWDpfRi
         3N3rgk+9Xq1wZyd8pnMmnC2OI3KNx9mgsCaRrnGrHIS0NcMOcQ832qsbnyKlTWMJdjdD
         7qvk5iitNx+5YjuyqjvZJgiPRrCxUEIQ67dhB6umelIEHMrgtntFMvYHSaradvgsIek1
         sBkg==
X-Received: by 10.112.1.166 with SMTP id 6mr2550442lbn.135.1367998933443; Wed,
 08 May 2013 00:42:13 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 8 May 2013 00:42:13 -0700 (PDT)
In-Reply-To: <CALkWK0ktoQg5pd-tSiP=wn-3JGv-N7OHK_FkNjPx5HycdjBsKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223650>

On Wed, May 8, 2013 at 2:39 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> ---
>>  sha1_name.c | 30 +++++++++++++++++++-----------
>>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> How has this changed since my eyeballing of the previous version?  An
> inter-diff would be nice: having spent a significant amount of time
> looking at this area, I can confirm that the patch is Correct.

You mean this compared to v4? It hasn't changed.

-- 
Felipe Contreras
