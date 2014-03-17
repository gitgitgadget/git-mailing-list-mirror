From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 20:53:37 +0100
Message-ID: <CA+SSzV0+ijF=ws2OfNDsrBj1SFT--O=DbNMK47gfcxmyMdhK4g@mail.gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqr460ek3k.fsf@gitster.dls.corp.google.com>
	<CA+SSzV3CZjpNaFuf1U1DcPXiKy=rpJH8M2q1xeMvyh9uEHxvOA@mail.gmail.com>
	<CAPig+cTJz30TKmnNqQUiubFKTnjH8FHc5_v1mvt9AB5eMDBHag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdbV-0006ga-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaCQTxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:53:40 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62839 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaCQTxi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:53:38 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so6033327obc.21
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uDfizep4obHDHxZ2hJ7AkXINZnXGJ5ZIBTCJyTi+utI=;
        b=CE9Oo2kXiRBs80U22w/UNRfy1wljz4wYBzv2jgns60UYvXlPMR5hhgnVN6FKv8y+JV
         G5rYRLWAzdV88QVvshtgFPGQZ8OPwZJMFoyTcxwbk1YiAVQYNJa7ly7E0zsZrnuiiEwW
         5J6bVnYq9nECi0JgYdRijwp+J4WluelwZ6DzDE08Vg3KKBqOQn0k34N4bx+B3YcccR7k
         IzPHhkP9cDzpsCjdEvEoBpwvwTANekAzItCqoF0eVro2a5caYlkqKebE0rwjbFfyzDF9
         rkRhzbi44joSKT75xPNDUw9TySq9rBnIzqOrqncGNv6WPoHO2CD0fqTKXAtFxq8rr3T4
         MeOA==
X-Received: by 10.182.131.170 with SMTP id on10mr22580725obb.2.1395086017783;
 Mon, 17 Mar 2014 12:53:37 -0700 (PDT)
Received: by 10.76.94.143 with HTTP; Mon, 17 Mar 2014 12:53:37 -0700 (PDT)
In-Reply-To: <CAPig+cTJz30TKmnNqQUiubFKTnjH8FHc5_v1mvt9AB5eMDBHag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244276>

On Mon, Mar 17, 2014 at 8:51 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Mar 17, 2014 at 3:46 PM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
>> On Mon, Mar 17, 2014 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Benoit Pierre <benoit.pierre@gmail.com> writes:
>>>
>>>> [...]
>>>>
>>>> diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh
>>>
>>> Again, as I said, I'll rename this to t7514-commit.patch.sh while I
>>> queue this.
>>
>> I assumed the "14" was a typo, will rename, but to
>> t7514-commit-patch.sh right? (with 2 '-').
>
> Yes, two '-'.
>
> In the 'pu' branch, there is a new t7513-interpret-trailers.sh.

OK.

-- 
A: Because it destroys the flow of conversation.
Q: Why is top posting dumb?
