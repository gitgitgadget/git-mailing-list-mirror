From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: add convert-grafts-to-replace-refs.sh
Date: Tue, 27 May 2014 15:00:10 -0700
Message-ID: <xmqqwqd6evbp.fsf@gitster.dls.corp.google.com>
References: <20140527182719.14437.62235.chriscool@tuxfamily.org>
	<CAPig+cR4G916TwqGDRMr9fAH=SZkUB8kqGy3Hy5YBHZLgUw8ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:00:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpPQ9-0008P0-5m
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 00:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaE0WAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 18:00:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52550 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363AbaE0WAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 18:00:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F1F91A94F;
	Tue, 27 May 2014 18:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8n4j5uG0SdknE43iLcqTq2x4AKw=; b=MiqvqN
	V2/jzSvWtbHlvdT0rfHRT9Cb0Rx6+r/qENO0ryKn4ZoG4jjL/my7IeedC+PTJCl6
	MlBBisC7xnMmHOUn0e7z+PNSF4U/0wgkgXIoeZuWGMTiYWFgvecd85RRcQeKaK8+
	127W0WsCBz0bh4FCShBJgGJbdXUkzH2S+ehSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mA7kdtEMefcC1IYKlr8Efgiq4JAWI0gm
	wOGg/h9xTfxw1dJTaZylsvsPiQ32uRe6kemQBF/x36gHL8sS3+Hqh3IrR15/Wama
	Su7LIj/FXPYBA1nne+Nez/CR1eG0q8n45/42a89mWoC2/dbfB8v5BngQ1Hqo/rj0
	ryNDyOrzJxo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE4101A94D;
	Tue, 27 May 2014 18:00:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 688D01A934;
	Tue, 27 May 2014 18:00:12 -0400 (EDT)
In-Reply-To: <CAPig+cR4G916TwqGDRMr9fAH=SZkUB8kqGy3Hy5YBHZLgUw8ig@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 27 May 2014 17:19:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46D08328-E5EA-11E3-A554-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250242>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +echo "Success! All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
>> +echo "You should now move away or delete the grafts file: '$GRAFTS_FILE'"
>
> Rather than merely giving advice, would it make sees for the script
> rename the file (adding .bak or some such) and report that it did so?

Yeah, I would say so.
