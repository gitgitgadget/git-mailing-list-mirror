From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Wed, 08 Dec 2010 21:15:33 -0800
Message-ID: <7vaakfil1m.fsf@alter.siamese.dyndns.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <20101208180605.GD5687@burratino> <201012082051.09730.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 06:16:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQYrQ-0002WC-Bf
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 06:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab0LIFP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 00:15:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0LIFP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 00:15:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 722133FC6;
	Thu,  9 Dec 2010 00:16:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EbQDxJRQP2OhvxK7rd2SdIn7aIg=; b=f/Eyz3
	lqQ1EW42zG+zVRXXfr1RAS37xb8O3WXsFQUGtKVWsZiTgX+aw4mb6r2eyWcWpzRa
	APEdwcpMKaCHvqgy+9Cj3Je97ykMmiIrV3ZY8ccfukPCWb9vKpohWTHS0kekf5FR
	YlkOwnX6YcEPakh9MEa8zMfMEqWRkpC3+ZvOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b8DmGBwNvAk1aVYTJal78TDSOx0gnkId
	XZoAsV5Br5XkFy9pyvhILQxgxMakUdlcDKqAKCHAwPS8oGKL1FZgWze+MLHVCYPg
	l5lsXt4t4dG7BbxUrxGRaGTDyt30xp0y/B1Dhs00lUCGxNSvY9FyzKfNSrvgSsob
	AhHNtAeXrmE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F267E3FC5;
	Thu,  9 Dec 2010 00:16:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB7A33FC0; Thu,  9 Dec 2010
 00:15:58 -0500 (EST)
In-Reply-To: <201012082051.09730.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 8 Dec 2010 20\:51\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EF01FBC-0353-11E0-BF9B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163262>

Jakub Narebski <jnareb@gmail.com> writes:

> Second, consider ref^{:nth(10)/foo} in your workaround...

Feels way over-engineered to me.
