From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] modernize t1500
Date: Mon, 16 May 2016 13:39:52 -0400
Message-ID: <CAPig+cTPsya6_3D2wx=k3pVaDJ2PokUvK4muM7nz-eV+Ss5+tw@mail.gmail.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<xmqqfutqsaxn.fsf@gitster.mtv.corp.google.com>
	<xmqqmvnxpyw6.fsf@gitster.mtv.corp.google.com>
	<xmqqeg99py5j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:40:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MV0-0006Pr-Hs
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbcEPRkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:40:01 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34225 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbcEPRkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:40:00 -0400
Received: by mail-io0-f171.google.com with SMTP id 190so218926876iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kFPQu+JKNIhliy1ljtX5HVPk+XwUjo5sc4ev0XoDpYA=;
        b=ABksZ+qU2ZSkCel/HlzFi7023tQpdQ4hcUIhnQZAAEVRpnp9HbAyf3/jq+HmwNom0X
         p7+gD75WgitkaYKznaBV6TA5kiwC0D/CnzmkgYGcIK3yPbyLssUooXJ+z5eC43QOLpSD
         EruZ7OSBlCj7keDD+boN47Vkda37d2c9/ubBagBjUpvsu3MjVZuBXqz7gBAVrFhV8CB9
         rY2tTOran/3jZzJTK2cIg3W3Tk3aKMO88/c9TdcUtxbbq6cck8ecQTla1xHSwgQYYahq
         LIMpUrUuxIWryrG9Ixd87lmcsQ1C3AANFhNDvmTfj2JkZYEv++QYCRs4RdvdmdLcquJc
         BtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kFPQu+JKNIhliy1ljtX5HVPk+XwUjo5sc4ev0XoDpYA=;
        b=Z9EYnPJauUKC/9TDsu9jr0c5X/kAvSNKMPDUEZaROwY5+jFHSgUenKnFUs3xUMa1y1
         w0Wbk37CrilAGN0Squ0kFQKGhxdnwnsK168AgY7RtvcvR3VtdquLy95l3QygUQNOEOap
         YpbJxPco9oiOIScYxvk9OLcuTRYZ2fxRNfi0Gd+3qpqGOl8HY7X6fZuYoFL4ks6xY6Ug
         O2fZUDsJMXu0d8nradart3NkMhHpYAZNaERyxRXeNhL3WsZNWBPBwafLDYHz7pP/NnZZ
         T+o2kqGBtXeminO/yuMdme3qY8E8obf/F6whgebbTo6P6g8Umv9Tre3wWUKqPx1lFs1M
         +1bA==
X-Gm-Message-State: AOPr4FUckiu3q1Kbv3r6yyPIgAEGCEr/O6DZVe0vQBKo74hnLYrKGTsMr1O8cd7qQ7AdeoGgepwu25Z6Zv5RZg==
X-Received: by 10.36.55.144 with SMTP id r138mr10108276itr.73.1463420392978;
 Mon, 16 May 2016 10:39:52 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Mon, 16 May 2016 10:39:52 -0700 (PDT)
In-Reply-To: <xmqqeg99py5j.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: lOPRC1hhq7V1uyh5Pg52K-cxh6I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294760>

On Tue, May 10, 2016 at 2:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>> Subject: [PATCH 7/6] t1500: finish preparation upfront
>>
>> The earlier tests do not attempt to modify the contents of .git (by
>> creating objects or refs, for example), which means that even if
>> some earlier tests before "cp -R" fail, the tests in repo.git will
>> run in an environment that we can expect them to succeed in.
>>
>> Make it clear that tests in repo.git will be independent from the
>> results of earlier tests done in .git by moving its initialization
>> "cp -R .git repo.git" much higher in the test sequence.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> I think the same logic applies to other preparatory things like
> creation of sub/dir in the working tree etc.

Hmm, so are you suggesting a single 'setup' test at the start of
script which does the 'cp -R' and creates those other directories
needed by later tests?
