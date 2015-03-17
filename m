From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Tue, 17 Mar 2015 13:16:25 -0700
Message-ID: <xmqq7fufnzvq.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	<xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
	<xmqqvbi1sy4h.fsf@gitster.dls.corp.google.com>
	<003001d05f71$81845160$848cf420$@nexbridge.com>
	<CAP8UFD08xoJ2H8XgfDbPfHddX9YFpFgbrY+PZ5Tphuot7JwGvw@mail.gmail.com>
	<87a8zdguxp.fsf@fencepost.gnu.org>
	<CAGZ79kbOkgA2pfsh3Av-iuHe4qRz2XWDu6Onm9QTXJRtAoABXg@mail.gmail.com>
	<CAP8UFD0NPLF1o8h8hqBfiG76qF1HU9DOCfHqi5-z9DkrV+aEvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, David Kastrup <dak@gnu.org>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:16:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxui-000474-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 21:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbbCQUQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:16:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753211AbbCQUQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 16:16:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49B51406EE;
	Tue, 17 Mar 2015 16:16:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TIGodHn5NJA4CdG40nMHsw6uvpU=; b=HLs4vi
	KesK34Ph0emDPai6sZTrfWR5pqDDdnSJz5iWV4DB5+bAtRkye3R+2BcCKgWUyt7U
	hGMmt+HMdND/QY9cYH6LbGgZ9U9FTLvklqblBcjcEvAs4uPeEo5nU0GcU3A7JxOQ
	+6KOA+KxF8Z7NcwIlFI2ol+aEjxGg4Y4OK7Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBx68budx3nY2o0pfrIIbXJdL66YIbZm
	Woxpj22gSs2rwbKCMBzGeMFc6FHMn/ahze7hzBsb7HxRae7lgJjNlepC4xXzvapk
	sbJ2yTA5EhQ8MHLYJDr69MeNpXEyg875jnP+SUEzrL1WPAiZGG5LyKJ4y2GEfapV
	qanqSsLr6rs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 41AF7406EC;
	Tue, 17 Mar 2015 16:16:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1CCD406EA;
	Tue, 17 Mar 2015 16:16:26 -0400 (EDT)
In-Reply-To: <CAP8UFD0NPLF1o8h8hqBfiG76qF1HU9DOCfHqi5-z9DkrV+aEvw@mail.gmail.com>
	(Christian Couder's message of "Tue, 17 Mar 2015 21:08:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D7540A0-CCE2-11E4-A06A-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265663>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Mar 16, 2015 at 6:06 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Mon, Mar 16, 2015 at 2:20 AM, David Kastrup <dak@gnu.org> wrote:
>>>
>>> "Git Annotate"?
>>
>> "Git Praise" as opposed to blame?
>> "Git Who" as a pun on the subcommand structure which doesn't always
>> follows grammar?
>
> Yeah these suggestions above are nice, thanks for them, but "Git Rev News"
> also look a bit like "git rev-list" and "git rev-parse" which are plumbing Git
> commands, so it gives a somewhat "hardcore" look to the news letter which
> I like.

Call that "Git Rev List" then to be more direct?

I myself liked the "Review" (spelled in full word) as its non-nerdy
sound, as a suitable name for a publication that bridges between
hard-core developers and slightly-more-serious-than-casual
observers, but its not my call (and as I often say, I am not good at
naming things) ;-).
