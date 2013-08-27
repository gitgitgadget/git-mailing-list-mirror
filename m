From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 15:33:11 -0700
Message-ID: <xmqqli3mahnc.fsf@gitster.dls.corp.google.com>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
	<CALWbr2wrHsa7LwZcEPYKe=kCrSHKsdrU6Bwevtb=2MwLrXtMnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Joern Hees <dev@joernhees.de>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 00:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VERpN-0005sj-TN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 00:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab3H0Wda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 18:33:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879Ab3H0Wd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 18:33:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236433C2EB;
	Tue, 27 Aug 2013 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CN32wMDV92ecVvVs86K2dD2S1rM=; b=PJfiQw
	becrxe1K3A+JAGijgvVnI5CBRs86OXmYuuwHYoVOQtshqkiZ6iykURlNxw9D0M4B
	S6cFmi+3vaSmv6kqCgcK1SzYPPazmnLoL4KtEeD9mQbRZvXIP6mbXY2Paw6Wjfjj
	g7VQ29kkUeygtcY7oDWmcTt4w34tC1WyeHW0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mDLHZ9SUnxm9K5VlgmhUKzitRSOAu/HX
	sHSOKXiXSPuMwACS2fnuYLmahqBfEqtlga31UshcloN2MVMGh0JZs5Y/mvbWSa0Z
	rlvFySt0RO8UvZ2XNELVW8Xe8eBuRm2PNj0L5IHR4m2/VhSh4jypBkRlTs10+d8r
	JjMAzgC/nlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 163B13C2EA;
	Tue, 27 Aug 2013 22:33:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D7633C2E7;
	Tue, 27 Aug 2013 22:33:28 +0000 (UTC)
In-Reply-To: <CALWbr2wrHsa7LwZcEPYKe=kCrSHKsdrU6Bwevtb=2MwLrXtMnw@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 27 Aug 2013 23:25:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1B8CD2A-0F68-11E3-8163-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233168>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Tue, Aug 27, 2013 at 9:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * jh/remote-hg-fetch-fix (2013-07-25) 2 commits
>>   (merged to 'next' on 2013-07-25 at 33161ad)
>>  + Revert "remotes-hg: bugfix for fetching non local remotes"
>>   (merged to 'next' on 2013-07-24 at 9c96641)
>>  + remotes-hg: bugfix for fetching non local remotes
>>
>>  Originally merged to 'next' on 2013-07-25
>>
>>  Reverted.
>>
>>  Waiting for the final patch to replace, after discussion settles.
>
> I think it has already been replaced by:

Surely, of course.  I think I just ignored the text altogether when
I moved it to the "discarded" section.

Thanks.
