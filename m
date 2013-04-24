From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #08; Tue, 23)
Date: Wed, 24 Apr 2013 03:04:49 -0500
Message-ID: <CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 10:05:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUuhI-0005a3-7e
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab3DXIEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 04:04:54 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50897 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837Ab3DXIEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:04:51 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so1448298lbd.30
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=esHi/Vw0RiLhdgAjhXu0IgqQ++5U6hQYuUYDbUTniS0=;
        b=y5VWG40sNiayQRJTUm6mvEh3IP2EXiZSBeF96gQLAiFeIA7pgwY8QsNzj+xfE0m7Si
         7ZPGRxckRv6knRh8cAs4SPCRPgRaEgEOQfhLbXVXzS6/GI5qTYhy0CPywTLPEWAdKlCh
         8amDfW4pTMjTPGYpPvQCM1WQXfUGrzpJ4BaBlvalGRJ6L1OwiJW6sYgCms83wa9E4rPj
         iuI9eUVQK6CPDVMSJ5I08ZL7Jr1ACJo1XlAu7xx/y/WD7D5h8TTkmQZCaMs5eF573uao
         VUbqMbZ3BVBEzhY4+sFE23+w2BbNILY9h9Jhtg0mdGWaQJXBlLIxskVdFXdYLHjy/WnF
         EQPg==
X-Received: by 10.112.139.226 with SMTP id rb2mr16206670lbb.12.1366790689551;
 Wed, 24 Apr 2013 01:04:49 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 24 Apr 2013 01:04:49 -0700 (PDT)
In-Reply-To: <51779052.8020507@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222236>

On Wed, Apr 24, 2013 at 2:57 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 4/23/2013 21:31, schrieb Junio C Hamano:
>> * fc/transport-helper-error-reporting (2013-04-17) 9 commits
>>   (merged to 'next' on 2013-04-22 at 5ba6467)
>>  + transport-helper: update remote helper namespace
>>  + transport-helper: trivial code shuffle
>>  + transport-helper: warn when refspec is not used
>>  + transport-helper: clarify pushing without refspecs
>>  + transport-helper: update refspec documentation
>>  + transport-helper: clarify *:* refspec
>>  + transport-helper: improve push messages
>>  + transport-helper: mention helper name when it dies
>>  + transport-helper: report errors properly
>>
>>  Update transport helper to report errors and maintain ref hierarchy
>>  used to keep track of remote helper state better.
>>
>>  Will merge to 'master'.
>
> Please don't, yet. There is a new test case that fails on Windows. I'll
> have to figure out a work-around.

Which test case? If it it failed, it failed before this series. I
don't see how this new series would affect anything.

-- 
Felipe Contreras
