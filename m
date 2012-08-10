From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool,difftool: Document --tool-help consistently
Date: Fri, 10 Aug 2012 08:04:44 -0700
Message-ID: <7vk3x6lreb.fsf@alter.siamese.dyndns.org>
References: <1344574365-5534-1-git-send-email-davvid@gmail.com>
 <CAHGBnuMCLkALCCAp1MiwQ1J+TuUhD=4k3LTGP2BMrp1LThb=HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szqlh-0004E7-Un
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759285Ab2HJPEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:04:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758269Ab2HJPEr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:04:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 384ED9D29;
	Fri, 10 Aug 2012 11:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8dvbEs8Ni/CX7jyGqVjmo6hv74g=; b=Em+DLV
	5S331znhM1ZnrYdTys/Z/Or4s3BuEsr2kDPRNrnIHIjex9T776hFUiNWG+hJa7SS
	z1xoErOdg29e7Ej3gxyGKd8r4a8HAHQXNkfwo84A5eelaz+CZQju3YUYt9H5SWcc
	JkYVWAImbYTKRofi7bftO4Xgcyp+MuHluzIAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IJUbthU+RIsBlko2PZSVrnuU7boCPuOa
	gFI9LxSvTHxDj2QyFH95RX7I7IjWZvO90F3bDOWr898wSnQ2Z/Ty7zuCeZlWPYZB
	GwIKT14ZkRA3rcFM2AQSqVhC66GdVPboyIbKb/ZUpuQXgWb7xX5FK3kckp9U+3az
	xWSMkFtiHLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 237FA9D28;
	Fri, 10 Aug 2012 11:04:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8148C9D27; Fri, 10 Aug 2012
 11:04:46 -0400 (EDT)
In-Reply-To: <CAHGBnuMCLkALCCAp1MiwQ1J+TuUhD=4k3LTGP2BMrp1LThb=HQ@mail.gmail.com>
 (Sebastian Schuberth's message of "Fri, 10 Aug 2012 09:17:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B93F060C-E2FC-11E1-8DBE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203224>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Fri, Aug 10, 2012 at 6:52 AM, David Aguilar <davvid@gmail.com> wrote:
>
>> Add an entry for --tool-help to the mergetool documentation.
>>
>> Move --tool-help in the difftool documentation so that it is
>> listed immediately after --tool so that it is easier to find.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>
> Funny, I was doing almost the same thing in [1], so I obviously
> like it. Back then Junio found it "Meh" because "it already is
> mentioned in the description of --tool above", but I still think
> all available command line option should be listed as such.

Either way is fine by me.  Even though I do not think it adds much
value, there is no reason to hiding the option; it is not like we
are discouraging the use of it.

Let's take the version with the description of --tool-help, then,
and have it next to the description of --tool.

Thanks for sanity checking.

>> --- a/Documentation/git-mergetool.txt
>> +++ b/Documentation/git-mergetool.txt
>> @@ -64,6 +64,9 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
>>  Otherwise, 'git mergetool' will prompt the user to indicate the
>>  success of the resolution after the custom tool has exited.
>>
>> +--tool-help::
>> +       Print a list of diff tools that may be used with `--tool`.
>> +
>
> This should say "list of merge tools", however.

Will amend while queuing.

Thanks.
