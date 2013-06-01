From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 21:36:13 +0700
Message-ID: <CACsJy8BFv7kJkymJ_rj9dwaN-zMcHtS9sjmqDSpLWB5TsUU_kg@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com> <CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimvQ-0005Bf-FD
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab3FAOgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:36:52 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35545 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3FAOgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:36:44 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so4746091obq.7
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PBnC+pRi2N2d16MdPtVWv95H0SZ9PCDWRXAdmuBfvoI=;
        b=X6S+JexjNdDaE7rFeXEv+KjuK+USef0YVeLLyUhPbeyGqh5Kw2TgL+534cKk9SOgR1
         p275O3LnmaC+g0sXZK0IxCDJqEqIA+aJx9XG6Vo3bBeblcgtX6Eug0MOzLjLBe+o4ywd
         3ns86NiSh0ROXqUt+3T6R7KcOUn0mSdr6HAHK3yXf1up7rPFavthWTdy+4GNZ2LiPsFe
         qXi8LLBqGi3axmFHgexCZIXOqLvPvJ5sFAHMQkRTnu6R7va+KsVC6OwqnYA3Vu5sPMcG
         x1bcYg0d/x/E3RhONBdcAPR4sVvoVyOiAmnB4HQ//AasWVdZkrJItsQw9Kr8F98+Hc1Y
         ygig==
X-Received: by 10.60.59.37 with SMTP id w5mr7431067oeq.7.1370097403995; Sat,
 01 Jun 2013 07:36:43 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Sat, 1 Jun 2013 07:36:13 -0700 (PDT)
In-Reply-To: <CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226136>

On Sat, Jun 1, 2013 at 9:30 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Jun 1, 2013 at 9:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
> Yeah, and last year we returned a different code. The world didn't
> end, because nobody is checking for the specific code. But if you want
> to retain complexity forever, suit yourselves.

And that was changed for a reason, compared to this change "because I
like it". I maintain my NAK (not that it matters) until you justify
your change better than "nobody is using it".

> commit 709ca730f8e093005cc882bfb86c0ca9c83d345b
> Author: Jeff King <peff@peff.net>
> Date:   Sat Jan 5 09:49:49 2013 -0500
>
>     run-command: encode signal death as a positive integer
-- 
Duy
