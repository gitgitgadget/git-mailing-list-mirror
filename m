From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: fix broken && chains
Date: Tue, 01 Sep 2015 09:23:51 -0700
Message-ID: <xmqqbndmt8fc.fsf@gitster.mtv.corp.google.com>
References: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
	<xmqqzj17wg1i.fsf@gitster.mtv.corp.google.com>
	<CAMpP7NZMMYyCbmnzhLTqa73TD_mqk+rO8=D0v9qb0z_UmBQ-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: erik =?utf-8?Q?elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:24:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWoLm-0000kl-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbbIAQXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 12:23:54 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36063 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbIAQXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:23:53 -0400
Received: by pacwi10 with SMTP id wi10so511055pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=4kDTOXJBKbsPa0D5ChzN1PHGWKP8hM4PEZFZO69vLZo=;
        b=U1SBNXk3aBC4+2+67rU0Q+76zXHNspKMPKtGQQ4QO3rzj1UVK+1sZljFX8pvj8WXO3
         10mgdWhUY15SpTJRMbpE3UUhQ7TQTlnC6+j0DTQLIyeu+KjKVZ7H13bJksMHcMMamzjx
         Y6zi0C7Mz+Ip+kAtbSwx+jLxyAGGYkztwhPlT0ZkVlDxer/UwfNUT8HjENHJJMNIHQ2A
         43eVGD8WPF3wUcKzBtWPDJNZyPBdVS0/8ET44oT9dWg3LNbcF3UxSK3LBc2UPObGabQE
         U2jQszJggYFb3oKjnzinqmMKoqzqRUx2YH0u3nuupx+7VAnCoR07R/jJf6hLYn8VIr43
         CBtg==
X-Received: by 10.68.57.137 with SMTP id i9mr30990033pbq.101.1441124633153;
        Tue, 01 Sep 2015 09:23:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id x6sm5561769pbt.3.2015.09.01.09.23.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 09:23:52 -0700 (PDT)
In-Reply-To: <CAMpP7NZMMYyCbmnzhLTqa73TD_mqk+rO8=D0v9qb0z_UmBQ-rg@mail.gmail.com>
	("erik =?utf-8?Q?elfstr=C3=B6m=22's?= message of "Tue, 1 Sep 2015 08:31:37
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276988>

erik elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> On Mon, Aug 31, 2015 at 6:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>
>> ...  It may have been
>> better if you didn't do "while we are here" and corrected only the
>> &&-chain in patch 1/2 and then updated the style of the tests to
>> take advantage of the newer facilities recent test-lib has in a
>> separate patch 2/2, but this will do at least for now.
>>
>> Will queue.
>>
>> Thanks.
>
> I can do a re-roll with the chain fix in the first patch and a more
> thorough modernization of t7300 in separate patches if you'd like? I
> almost went this way for v1 but decided to limit the scope for the
> first version.

I'd say it is too much work for something that we already have
reviewed and queued ;-) Let's have this patch as-is.

Modernization and clean-up from time to time is a good thing to do,
but we only have limited review bandwidth, so let's not overdo it.

Thanks.
