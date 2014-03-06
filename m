From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc/repack has no option to lose grafted parents
Date: Thu, 06 Mar 2014 15:26:06 -0800
Message-ID: <xmqqwqg6vrht.fsf@gitster.dls.corp.google.com>
References: <CACPiFCLqa=ZQM6Azh2G5hwBCMx96Cxa5BMN=-2aCy5x=YhBpGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhg8-00028c-UC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbaCFX0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:26:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbaCFX0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:26:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C4F97230F;
	Thu,  6 Mar 2014 18:26:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Utnl7aHBEg29Uoxth51ilG0wPI=; b=WvIMVC
	YTykffhfecmKOho2R2rinnVd88JkoTEuUxV7jmKxr5Dsgpg71oxw6XmCQVabCbxx
	oTGufBMWKuvX8qDJzcII+9O+2k82JlfrPt17jLMirFr2Y2CP+l37uBeOmZ0dgjGT
	M2HXhIugvlftTIJL9NVS9ZFcOmluPCtiRpMQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkIy7t7v88iHfeUB17PNComC84CNDILp
	aLue0CDNKV+OE/OKdtqmhTDUkOmwjvEcO4XhuoyGcZAPIStTRlbxi/DrDLmVPFBF
	cN9dvBxdvRusD8JjFrNZdtTKRODKlGDp33lz4+VyK/GTV23SZlpFgnXxBgFGtnq1
	WHmqfqNMA9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FCD7230D;
	Thu,  6 Mar 2014 18:26:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5841C7230B;
	Thu,  6 Mar 2014 18:26:08 -0500 (EST)
In-Reply-To: <CACPiFCLqa=ZQM6Azh2G5hwBCMx96Cxa5BMN=-2aCy5x=YhBpGg@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 6 Mar 2014 18:07:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B21D6F6E-A586-11E3-823D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243573>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Back in http://git.661346.n2.nabble.com/PATCH-0-2-Make-git-gc-more-robust-with-regard-to-grafts-td3310281.html
> we got gc/repack to be safer for users who might be shooting
> themselves in the foot.
>
> Would a patch be welcome to add --discard-grafted-objects ? or
> --keep-real-parents=idontthinkso ?
>
> cheers,

Given that we in general frown upon long-term use of grafts (or
"replace" for that matter), I am not sure if we want to go in that
direction.

Just a knee-jerk reaction, though.
