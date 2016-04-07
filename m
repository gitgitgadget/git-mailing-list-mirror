From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #03; Thu, 7)
Date: Thu, 07 Apr 2016 14:36:34 -0700
Message-ID: <xmqqshyxxfrx.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuuxz1jh.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPP1aphz06Ac4ZrKinaE9uiPF4P69P_b5aNn_AYOpZ3m4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 23:36:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoHbX-0005h4-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 23:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767AbcDGVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 17:36:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757740AbcDGVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 17:36:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29F9854D93;
	Thu,  7 Apr 2016 17:36:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xKgSId/yX803D1lUkJ96pkkQfFM=; b=LWmKJK
	t08DLT2Uv1P2lpIqLRipOpbGzgaXNabHQTmooWxbIPGbskEU3tGTbPXU2mr0FGan
	77R5TR718WhuzSgcCSPju1xJQ+458w1nJn4IUXCIbNIbBNFJswQf68a7AkWuMbPS
	0DRCeYYCLZLO2LmVXON/FCVlCaaXz76Dtb6sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uKHio5qoiCUDBjVPIDCdQNlvrjOTNeJy
	2NXoB64JzZ7VWU49av5SJgjiC8JtL05a37/K88LedUoDag9qD5S60JU4sVP0bwlQ
	XaJ49AAjw7uE2+1dS/D1NtMkqkYrqszR1YQiegQtUd/F22TN70XNWE+pW05CReSS
	hLxGa1+HO+4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 215DF54D92;
	Thu,  7 Apr 2016 17:36:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 98F9C54D91;
	Thu,  7 Apr 2016 17:36:35 -0400 (EDT)
In-Reply-To: <CAFZEwPP1aphz06Ac4ZrKinaE9uiPF4P69P_b5aNn_AYOpZ3m4g@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 8 Apr 2016 02:33:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CDA595DC-FD08-11E5-8CC1-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290991>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Fri, Apr 8, 2016 at 12:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>> ...
>> * pb/commit-verbose-config (2016-03-14) 1 commit
>>   (merged to 'next' on 2016-04-06 at e5c744f)
>>  + commit: add a commit.verbose config variable
>>
>>  "git commit" learned to pay attention to "commit.verbose"
>>  configuration variable and act as if "--verbose" option was
>>  given from the command line.
>>
>>  Will merge to 'master'.
>
> Could you delay this a little bit. I am currently working on this.

Do not quote the whole thing when you only are referring to a mere
10 lines.

Will hold and expect an incremental update.  Thanks.
