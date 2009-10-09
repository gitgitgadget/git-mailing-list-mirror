From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Fri, 09 Oct 2009 00:38:59 -0700
Message-ID: <7vy6nl10fg.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org> <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
 <7vljjpacax.fsf@alter.siamese.dyndns.org>
 <20091005191257.GA24305@coredump.intra.peff.net>
 <20091005193516.GB20078@coredump.intra.peff.net>
 <20091009070122.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 09:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwA8t-0004jG-1T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 09:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbZJIHj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 03:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZJIHj4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 03:39:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZJIHjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 03:39:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C07A70768;
	Fri,  9 Oct 2009 03:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgpqG1OTgIchrTnNTHSbqGvkOKw=; b=xuvmK0
	sBW6km/E6fPw+dcokWOwL8abUQG6CFEJ1KUxE95lRgOMqghl01JNdiM7cknhQJ7j
	Azqcg6x9tAjCDVCVuKd+xhh7YbbUeWmiIA89gLvwnWIDJOSedKeE58U21fmdPHu3
	VerxEZtePgEBkBF6isikHVR2GOTsL9WNjNe6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OuRQ+C0mgoAoYUPj/BQHyuWwB24Gs+r4
	8nRQG8Rfo2tITZiXgmZ0e8jdNz5su9sJw3Esqp638AWfscuzQKUz0Izi/aveadvG
	WmuV4gpy1Qk/3iizQ0Rd6ASrQppvXyJvCnYhG9pT+IBcCgwwXItw3tVCiuA+luf8
	7VQTf69jO0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DADCE70767;
	Fri,  9 Oct 2009 03:39:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C8777075E; Fri,  9 Oct 2009
 03:39:00 -0400 (EDT)
In-Reply-To: <20091009070122.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 09 Oct 2009 07\:01\:22 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3CA1368-B4A6-11DE-8171-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129750>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Jeff King <peff@peff.net>
>
>> Subject: [PATCH] pull: improve advice for unconfigured error case
>> ...
> Junio, may I ask what happened to this patch?

Thanks for prodding.  Unfortunately I lost track.  Will look at it again
but probably not tonight.
