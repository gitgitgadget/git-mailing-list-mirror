From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.1.0-rc1
Date: Tue, 05 Aug 2014 11:31:09 -0700
Message-ID: <xmqqd2cepz4i.fsf@gitster.dls.corp.google.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
	<53E10BAE.5070600@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjW9-0005H7-JP
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbaHESbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:31:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62010 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbaHESbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:31:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 601D22ED64;
	Tue,  5 Aug 2014 14:31:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D4MZ232OjS1EBU4YcFzJxvIZMos=; b=Ual85d
	lvvSuTBCily7c0VA/Wi2Ij8j0tVeDCcizgw19llkjTtNSa/gRv2FYskE2imBFrLh
	IimhpwmCvipxIbcGmhAu0UigNv62xTLcEUZH1QodOsYWd5Xvd61CQ16iEeuL5m4J
	5N8t9xpk8dOjhHDRoTMSgssm8a+XkfW8Ec580=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLgEikMQ46zJYZBno3PNnEImkEP2PGdf
	0xa3zPEdOVRjuCLIOQiYPi93OCp4Q5SVoZWRoWzYdJ45vKBRbUJDH/JsiuGBrakL
	wD8jgRClfrCjF9JXYK9Xz6OFiSf23MebKTaP0KLlDBQKZ4XoBF6BYV1MQXwTzL+N
	Mw5Nc9lv5AU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54E3B2ED63;
	Tue,  5 Aug 2014 14:31:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 229612ED4C;
	Tue,  5 Aug 2014 14:31:11 -0400 (EDT)
In-Reply-To: <53E10BAE.5070600@xiplink.com> (Marc Branchaud's message of "Tue,
	05 Aug 2014 12:51:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC89E2C0-1CCE-11E4-B910-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254817>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 14-08-04 06:31 PM, Junio C Hamano wrote:
>> 
>>  * "git grep" learned grep.fullname configuration variable to force
>>    "--full-name" to be default.  This may cause regressions on
>>    scripted users that do not expect this new behaviour.
>
> Should this be noted in the backward compatibility notes?

I debated it myself, but decided that it was minor enough (in the
sense that it is obvious when it breaks and it also is obvious how
to adjust the script in a way that is also compatible with older
versions of Git).

Thanks for a careful reading.
