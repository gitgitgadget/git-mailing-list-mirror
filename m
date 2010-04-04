From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `%B' in format strings for raw commit body in `git
 log' and friends
Date: Sun, 04 Apr 2010 15:17:42 -0700
Message-ID: <7v6346zwu1.fsf@alter.siamese.dyndns.org>
References: <19370.53192.313137.191218@winooski.ccs.neu.edu>
 <m3eiiunbky.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyY8i-0008Oo-6f
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0DDWRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:17:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab0DDWRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:17:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 318D1A8958;
	Sun,  4 Apr 2010 18:17:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQkjx2bAB9JPAAFoSNY/9dfG8is=; b=eI4bvd
	GH/d5Q6t7VVsGPdQ+/xjan/VhtOCoWI+UDSjyncWUEdJ4wG3eJ63SyZtDGGJqH3J
	xahWB1HavQ8karuJDQbrPak3FYFoxwsJzcY2FSNBsQxGu+eswjRv9A6j90TfnoSJ
	hglUQTenl4YB6qZowX5/tOOdbo2bboH7z6jf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfry6qE6rS5k2b1mr1ItGqV5/JUvicq7
	haB2zpcY5lg2uOeL1lvpvW028aNY02cTJS619Dko8et3eecnYTsQljiJpJxX4THm
	4e9nbU6Jezt1QCW7JOx3WXDxqWzi7Wdm6sJ696tZhGB2kz6AyvQd2cuikGZkAXCZ
	mzzSuOG5nh0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5DEA8956;
	Sun,  4 Apr 2010 18:17:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 837A3A8955; Sun,  4 Apr
 2010 18:17:43 -0400 (EDT)
In-Reply-To: <m3eiiunbky.fsf@winooski.ccs.neu.edu> (Eli Barzilay's message of
 "Sun\, 04 Apr 2010 17\:37\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5644A9A-4037-11DF-9908-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143954>

Isn't this the same as "%s%n%+b"?
