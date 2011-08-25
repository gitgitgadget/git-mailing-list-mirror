From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] branch: introduce --list argument
Date: Thu, 25 Aug 2011 11:34:31 -0700
Message-ID: <7vhb55l4qw.fsf@alter.siamese.dyndns.org>
References: <4E5607E0.1050300@drmicha.warpmail.net>
 <32d0954697da9ac96cc11af0d8cc1390d93fd037.1314259226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:34:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwelD-0005z4-8k
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab1HYSef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:34:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab1HYSed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:34:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D0AD4C08;
	Thu, 25 Aug 2011 14:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=scjymMMzZb8KELZwzePJWN4wFIo=; b=sd3xKQ
	tqfJaX01nI86sgA1A1NRFJE6BAUrZJ71SNEffLjHqEOncnMGQ8y1SGCKtOHi8AHT
	LufVG9vr2aJmMHv8lwag/28RWmbK8cZ9b6ioKYmn4uahHxp6FinsoxujMhx5NaDS
	Gnlfct0mxxpw0elyjPcznFrrKnVwk1mmh6Q6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhLWkQwimMoHeHhceSOVu2lAeI9RMtnx
	2kJ11jLb6IiI8U6zLjms9gHunNCECiJsqt/8xbm9I4gB/y/GMbbg9ThS0Pdes6Dp
	vypzUQ1wSNaBBXmSQgyUleKxrHLZwrmf5C/tAzkBb2Jk/MTvPpAYV139AIRTInBK
	aENU9zr1t40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 342F94C07;
	Thu, 25 Aug 2011 14:34:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7C5C4C06; Thu, 25 Aug 2011
 14:34:32 -0400 (EDT)
In-Reply-To: <32d0954697da9ac96cc11af0d8cc1390d93fd037.1314259226.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 25 Aug 2011 10:30:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0307BBA-CF48-11E0-BB77-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180098>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, there is no way to invoke the list mode with a pattern
> because this is interpreted as branch creation.
>
> Introduce a --list argument which invokes the list mode.

Probably this is --list "option", but I think this is a good idea to allow
"we are in list mode" without having to invoke "verbose" output.
