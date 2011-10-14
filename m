From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7800: avoid arithmetic expansion notation
Date: Fri, 14 Oct 2011 12:00:30 -0700
Message-ID: <7vfwivz9dd.fsf@alter.siamese.dyndns.org>
References: <837ad77348b459aa5f5f79e556dbeeeba41027e7.1318594392.git.git@drmicha.warpmail.net> <7v4nzb1mjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:00:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REmzl-00061y-SS
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab1JNTAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:00:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab1JNTAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 15:00:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A1705A6F;
	Fri, 14 Oct 2011 15:00:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VLfADL3deiYmEiv7cCQu5Jbgx1w=; b=oStRW8
	abFWKWNRkXN9payeO6hbh1CSKSI6Bx950Yn5+aOuMKcLbnLiyLCj9x2G14rwiEew
	/0SkBYVPdne0o/sCY7ETOgs8I3O8V3Zbrhw/PWg12x0MJmJdDtI9KVsychmjjEu8
	y03+67Qeo+jBhLIGWPkalH1BJHwwveHVBpsbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CIk2h4eZcO7KVAHDSikw4hDsgM7fzY8L
	7xE+imxjEYrjYjMJ77emDo0SncDf3+szKZoGzS8W/TUyTO+/vxu79E0JWzux//tu
	mZK7IsoQYhp74BasA1GGjnfDeNwdhJaN0vbRykZkJ3ck8gsyN20AqxGEWwFHc3fZ
	X8YgcjvMXoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903CB5A6E;
	Fri, 14 Oct 2011 15:00:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2816D5A6D; Fri, 14 Oct 2011
 15:00:32 -0400 (EDT)
In-Reply-To: <7v4nzb1mjd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 14 Oct 2011 11:00:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA5D4474-F696-11E0-ABAB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183596>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> ba959de (git-difftool: allow skipping file by typing 'n' at prompt, 2011-10-08)
>> introduced shell code like
>>
>> $((foo; bar) | baz)
>>
>> which some shells (e.g. bash, dash) interpret as an unfinished arithmetic
>> evaluation $(( expr )).
>
> Ahh, thanks, I should have caught this. I recall I rewrote a similar one
> to $( (command; command) | command ) more than once before.

Forgot to mention that I love to see the issues on topics discovered and
corrected before they are still cooking in 'next', like this ;-)

Thanks all.
