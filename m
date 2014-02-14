From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 11:47:12 -0800
Message-ID: <xmqqd2ipiiin.fsf@gitster.dls.corp.google.com>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
	<20140214193131.GI4582@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:47:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOjL-0006a7-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbaBNTrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:47:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaBNTrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 14:47:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42A3B6CEB8;
	Fri, 14 Feb 2014 14:47:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wqlmhZmzwrKvYRyhCFYqw8dN0JY=; b=GFwhrw
	BdallLEnKEyO7B9bXn4xuwSN30YmozcyM48B9WLth2Cps8khe90WNUoZhni4XUYK
	Trs9J7lyOKkZdKJYEcP3em3h5j7EiuBNMvJPhprHLiKPV8uKFcJZBI0uQcbWyNs9
	oVLxu1DzJKKkmazZcVHgkjSJcl+nvqrbNHCyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRFS4Xxo+zDyxdqO51ew9qdw8LlHgRly
	Xwok4KN2ipVIEcD3+Jx8HhQO3qYaCTlsMRQhP2Jg8DjOboHPocYFnbDGmwkj0JVM
	whwRrn4XN9b5/H1Yewymr65BUrSRzPD5IR4qn3cLDqpG1/ftA82JbY2sqpQ+OFS2
	KEyW22Vco7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A79236CEB7;
	Fri, 14 Feb 2014 14:47:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 228AF6CEB5;
	Fri, 14 Feb 2014 14:47:15 -0500 (EST)
In-Reply-To: <20140214193131.GI4582@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 14 Feb 2014 19:31:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CDD80718-95B0-11E3-889E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242127>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  Changes to some scripted Porcelains use unsafe variable
>>  substitutions and still need to be tightened.
>> 
>>  Will merge to 'next'.
>
> Junio, did you want a reroll with that fixed commit message, or will you
> fix it up yourself?

I haven't merged them yet---if there are need to update any one of
them, please reroll a replacement set.

Thanks.
