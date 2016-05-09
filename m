From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 09 May 2016 10:41:18 -0700
Message-ID: <xmqqzirzuo1t.fsf@gitster.mtv.corp.google.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
	<cover.1462774709.git.johannes.schindelin@gmx.de>
	<4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
	<20160509080315.GA14383@sigill.intra.peff.net>
	<alpine.DEB.2.20.1605091557050.4092@virtualbox>
	<20160509142711.GA9552@sigill.intra.peff.net>
	<alpine.DEB.2.20.1605091710310.4092@virtualbox>
	<xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
	<20160509165139.GA10048@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 19:46:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpBN-0001QS-UW
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcEIRlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:41:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751154AbcEIRlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:41:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 116BB18352;
	Mon,  9 May 2016 13:41:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aL5JAcIsoEaSIUPrwb97krOfDGw=; b=odg38q
	LG7D9wid1c4GUlws2jKgcrFZy8uyXsYrLsVLDgC9mPhWDmKjd3kQnVh1+Qul8yRb
	kug5NtWxcJJnIfAY1N8/taw+9GWoGLv5dm0OQb4Cgx7ag/8qp3ifMxDauLvJZAnF
	Zvf31oYXRCD4ZYMOqNHwfmfgcz+ioFb09dAew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rYDUqsBIETtmFZzsVbaSd7uw87hWcnnl
	ExyX2M+o8dQ1JM9/nGVzIuXtUG2108nARt2NAF4DuSdkm5g8Qx7zkpq9xqZc0DaB
	atMQzT6AWykozv1I6URTZwjOYTSa//7wa2ShDPno3Gwk0W4BmbdufTojkslVJiY7
	zLtSr5tJCBA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09AB518351;
	Mon,  9 May 2016 13:41:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7096D18350;
	Mon,  9 May 2016 13:41:19 -0400 (EDT)
In-Reply-To: <20160509165139.GA10048@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 May 2016 12:51:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CF90D52-160D-11E6-99C4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294026>

Jeff King <peff@peff.net> writes:

> On Mon, May 09, 2016 at 09:42:32AM -0700, Junio C Hamano wrote:
>
>> > Hopefully your patch to remove the -c ... sanitizing makes it to `master`
>> > soon, then I can submit my next iteration.
>> 
>> Or we can just merge that "do not sanitize" branch in, and then
>> queue the "next iteration" which I'd assume would only be the test
>> addition?
>
> I think we'd also want the change to the test script to make sure that
> it fails with only a single header (Dscho's patch 2).

I think so, too.
