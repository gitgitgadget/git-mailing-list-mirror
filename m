From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/githooks: Explain pre-rebase parameters
Date: Sun, 24 Feb 2013 00:13:25 -0800
Message-ID: <7v621i6sey.fsf@alter.siamese.dyndns.org>
References: <20130220163621.GI14102@odin.tremily.us>
 <c8b19dc074a81b009399ff1011102737761658ec.1361633106.git.wking@tremily.us>
 <7vobfa7mko.fsf@alter.siamese.dyndns.org>
 <20130223213513.GF1361@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9WiZ-0002ur-6W
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 09:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab3BXIN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 03:13:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab3BXIN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 03:13:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F8ECA2EB;
	Sun, 24 Feb 2013 03:13:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CgWg2TKg+brx6Zm/X7NJ2KhFkaQ=; b=IUSvtn
	RELhimIkga+pbhTMwyCWpU8Hrml/9Z5ogV2Bv4iF4b2Y2Q9yYbbussGoNaoueZTN
	2Nkj+tykFRxt3781xm4apodYICNgUWF+CzX6xGc09UDSP06GhXl13SUg9/R6o9Bs
	IaA1PHStj2dsx5YHUTSgbUh8UlbPeVt2mBpRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EylV0VrdHVuammmwuNAdfeektQABgn6r
	m2X/r2a+lIAbUiLeq5pMFLrnA2Rda5r5Gp9M1cxlkjVvaxSHnDbBpddTDPkX391Z
	eLwoi7QrPFLdEmyTrrjpn/7hnIebKeF1lYF7nXlm7/PUuiTCsnrktVoPHramXypb
	IG14BlSHlUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64315A2EA;
	Sun, 24 Feb 2013 03:13:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C16F2A2E9; Sun, 24 Feb 2013
 03:13:26 -0500 (EST)
In-Reply-To: <20130223213513.GF1361@odin.tremily.us> (W. Trevor King's
 message of "Sat, 23 Feb 2013 16:35:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10C4817E-7E5A-11E2-AD85-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216978>

"W. Trevor King" <wking@tremily.us> writes:

> On Sat, Feb 23, 2013 at 01:21:59PM -0800, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> 
>> > +This hook is called by 'git rebase' and can be used to prevent a
>> > +branch from getting rebased.  The hook takes two parameters: the
>> > +upstream the series was forked from and the branch being rebased.  The
>> > +second parameter will be missing when rebasing the current branch.
>> 
>> takes one or two parameters?
>>
>> Other than that, looks good to me, but it took me two readings to
>> notice where these two parameters are described.  I have a feeling
>> that a comma s/forked from and/forked from, and/; might make them a
>> bit more spottable, but others may have better suggestions to make
>> them stand out more.
>
> How about:
>
>   The hook may be called with one or two parameters.  The first
>   parameter is the upstream from which the series was forked.  The
>   second parameter is the branch being rebased, and is not set when
>   rebasing the current branch.

Much nicer.  Thanks.
