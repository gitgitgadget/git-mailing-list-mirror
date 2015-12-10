From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Documentation/git-update-index: add missing opts to synopsis
Date: Thu, 10 Dec 2015 10:59:53 -0800
Message-ID: <xmqq7fkmi0ye.fsf@gitster.mtv.corp.google.com>
References: <1448443802-24507-1-git-send-email-chriscool@tuxfamily.org>
	<CAP8UFD1cJdoaT=gPqqDshB9g0e_ZUGJqy21UzUTBPmPB6EkmnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:00:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a76Ri-00020W-G2
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 20:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbbLJS75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:59:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752687AbbLJS7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:59:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B9FF32AF9;
	Thu, 10 Dec 2015 13:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TkVg/2W//jXPHKUVCf61Qf5XqBc=; b=Fmc2sM
	2OLNl7eDW1KPu5wszl9+JO2HIv/k2R40fXizZVDhWtTbxU3F13Dhst5VHk2pYNi/
	rDwoky2zwFjSqwQ0hZZq2Tm8T5CTRugJEIzShOp5NkOIsLG/gF/4PlWMwv2x3s0J
	7Itcw3Q5/nfN36YmKLJBOGY17XLEgPD46xa6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGhAAn6OGEg04ldj1a/nCzCLIuiML8dn
	xmOPWbxtDhy/my0Wa7RsRNAnQZlShohVJku/Zq2gMQd4qOAsnQpGtTCnooJMarSs
	29+tN0bpel0Mc6wDNhsq3maflp1Hff2OvwknFqzvRzHjwren2LMybeBd3uRrvThh
	yrOkgmnUYog=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3325632AF8;
	Thu, 10 Dec 2015 13:59:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7106732AF5;
	Thu, 10 Dec 2015 13:59:54 -0500 (EST)
In-Reply-To: <CAP8UFD1cJdoaT=gPqqDshB9g0e_ZUGJqy21UzUTBPmPB6EkmnQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 9 Dec 2015 06:39:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32FFE2E4-9F70-11E5-93EF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282225>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Nov 25, 2015 at 10:30 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Split index related options should appear in the 'SYNOPSIS'
>> section.
>>
>> These options are already documented in the 'OPTIONS' section.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> This v4 contains only the split-index options and applies on top
>> of the new master that already contains the untracked-cache options.
>
> It looks like this patch has not been applied.
> Maybe I should have given it a different title to avoid confusion with
> a previous patch that added [--[no-|force-]untracked-cache] in the
> SYNOPSIS.

It indeed seems that this was lost in the noise.




>
>>  Documentation/git-update-index.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index 3df9c26..f4e5a85 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -17,6 +17,7 @@ SYNOPSIS
>>              [--[no-]assume-unchanged]
>>              [--[no-]skip-worktree]
>>              [--ignore-submodules]
>> +            [--[no-]split-index]
>>              [--[no-|force-]untracked-cache]
>>              [--really-refresh] [--unresolve] [--again | -g]
>>              [--info-only] [--index-info]
>> --
>> 2.6.3.380.g494b52d
>>
