From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git file listing is inconsistent
Date: Wed, 26 Nov 2014 13:47:45 -0800
Message-ID: <xmqqd289prb2.fsf@gitster.dls.corp.google.com>
References: <CAGOJM6+DTSn2qa-KTWceqyraaugX_YVZhirkdc+t+cDfFB4OyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Woody Gilk <woody.gilk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:48:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtkRl-0003Jr-Na
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbaKZVsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:48:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbaKZVsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:48:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E990221EDE;
	Wed, 26 Nov 2014 16:48:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aDluHRweqMVXdvpB13ffglM149E=; b=NAXrVS
	VtZzeh1k43CnPL6uXW4vkLvM4XdGAEtA0WRm4j6YK7QfUn96Wz91GTBTWU834XY0
	c5vbgCzO5NRG/l+swF1X+8Fc4qy3U5CDD0ol3W5A1XixHQfmu27IuafiuvJNX0Yx
	Epith6j3krXSkH9BP7CKAqqS+hfBa4B8Flc2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IevqjkyAVdbRwZW3GwjPv5DT3O9lTfqJ
	Mo62fZtyJH0flwHYoYF5j2Dt3kgPT6kJvzS1hzWEJqbCTzNVGpLrEWWbNtyEg4ks
	AECkI4pgO0i7JwJOHCAG7ZAmHQQtdKFgM0dDodCcJUVl/la5ZOOLJxD/4iCaMPIx
	EHEulAd1cCk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1D3221EDC;
	Wed, 26 Nov 2014 16:48:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 816DA21E9C;
	Wed, 26 Nov 2014 16:47:46 -0500 (EST)
In-Reply-To: <CAGOJM6+DTSn2qa-KTWceqyraaugX_YVZhirkdc+t+cDfFB4OyQ@mail.gmail.com>
	(Woody Gilk's message of "Wed, 26 Nov 2014 15:10:33 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DBD104A6-75B5-11E4-ABB4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260310>

Woody Gilk <woody.gilk@gmail.com> writes:

> git diff --name-only
> git grep --files-with-matches
>
> I think --files-with-matches should be deprecated and replaced with
> --name-only for consistency.

That longer name comes from "GNU grep" consistency.

Why anybody does not use a shorter and sweeter "grep -l" is beyond
me, though ;-)
