From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Tue, 10 Jan 2012 08:59:53 -0800
Message-ID: <7v62gjbiie.fsf@alter.siamese.dyndns.org>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
 <20120110045733.GA12460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 18:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkf3K-000820-AP
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 18:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387Ab2AJQ75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:59:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab2AJQ74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:59:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 120D97C7E;
	Tue, 10 Jan 2012 11:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UFmWS8nuHO2T/AUA9Pco8OH2l0I=; b=VfIEBr
	UdgXExSAoHUg8R94uZGjwxjxiVcZfd43uIOgjGjpqy8dLu5zdzotY6mEVJ7Rv75c
	JDtq/C+dHyhJ3dKyvKBStQH06o1zTahw8iZOWJpHjg93T5dDBxYqdpWG8Zz7ovQS
	QOIbORIinzJqq5wWT0AQWsXKbzUr84HyCETdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLte/VRwFf6jpC2MEwOYxt2mDYzGIAAV
	AuCfmjrx37/LCrUgnw35/zhlf80nJmvh7dmeTWvathNM9KtVJv1BUD/f1UaQmBJp
	QXQ7xW7FgOLMQsx2NLV/67U5UmxVQ8GAdTKJ58knqgXx+1wYb9ndtogZqCr+N0LG
	TSA/g+ETMpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CCD7C7D;
	Tue, 10 Jan 2012 11:59:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C1C7C7C; Tue, 10 Jan 2012
 11:59:54 -0500 (EST)
In-Reply-To: <20120110045733.GA12460@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 Jan 2012 23:57:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84CD3936-3BAC-11E1-8407-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188266>

Thanks, these look sane.

Will queue both to 'next' aiming for 'master' before 1.7.9-rc1.
