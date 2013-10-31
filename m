From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t: branch: improve test rollback
Date: Thu, 31 Oct 2013 12:56:49 -0600
Message-ID: <CAMP44s07=XDh+Ny=NdDumXzG5Pe2UCg3KNYX7Hp8UbkLcL0Kpg@mail.gmail.com>
References: <1383211631-9244-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq1u3170l1.fsf@gitster.dls.corp.google.com>
	<CAMP44s01ABhU1tsqR+VKH6q6L+MNTDxHEgwfsCboxhP-euSmdA@mail.gmail.com>
	<xmqqsivh5l6a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:56:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxQN-0007jD-4q
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab3JaS4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:56:51 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42960 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab3JaS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:56:50 -0400
Received: by mail-lb0-f174.google.com with SMTP id q8so2740805lbi.33
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KoCLixUXWkj9bpbhO7trqcFtGpz4Z5tdTYbfqEOKI0I=;
        b=H8E5tlLQUbgeZ9HGc2FDFKMnLHb0UZMUFnvrrwMKZsJPRl5I2HpxONx5f0KJnoLRiJ
         VWBqXdOEt71PF6HkHdymJ5r1Dl5lMgz2x7sz9YI4D3szMX65WQPsQul9GrT5v7C6fSUi
         boHBMWCcRADiVopa9tFWXDvyDFI+pBTBZAp8TGBFXvpstVxHZmK0yY4nhF44IwNlk993
         ghJULLisA3rlbpv8mrsa6ixDYov/K6Smx5CP4nlH2G5YAiGIPeutY5tqVIvNXcze/L34
         880KUvHAYNGdSFGO+L+odTAsFjgdsWIFZhS1itPMfzMb5MTG0hgfRcxYjYdjhiLh9d3s
         oTBA==
X-Received: by 10.112.52.225 with SMTP id w1mr3174877lbo.31.1383245809489;
 Thu, 31 Oct 2013 11:56:49 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 11:56:49 -0700 (PDT)
In-Reply-To: <xmqqsivh5l6a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237157>

On Thu, Oct 31, 2013 at 12:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Oct 31, 2013 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>>>> index 0fe7647..33673e0 100755
>>>> --- a/t/t3200-branch.sh
>>>> +++ b/t/t3200-branch.sh
>>>> @@ -329,7 +329,7 @@ test_expect_success 'tracking setup fails on non-matching refspec' '
>>>>  '
>>>>
>>>>  test_expect_success 'test tracking setup via config' '
>>>> -     git config branch.autosetupmerge true &&
>>>> +     test_config branch.autosetupmerge true &&
>>>>       git config remote.local.url . &&
>>>>       git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>>>
>>> And "remote.local.*" setting does not follow that "pristine"
>>> principle, making the result of applying this patch inconsistent.
>>> Is that desirable?
>>
>> This patch is *improving* test rollback, it's not making it perfect.
>>
>> Let not the perfect be the enemy of the good.
>
> The patch is making it worse by stopping in the middle.

Whatever.

-- 
Felipe Contreras
