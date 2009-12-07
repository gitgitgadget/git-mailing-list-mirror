From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Sun, 06 Dec 2009 23:36:08 -0800
Message-ID: <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Dec 07 08:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHY8r-00056C-9X
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 08:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619AbZLGHgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 02:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758610AbZLGHgJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 02:36:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbZLGHgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 02:36:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C328786FA0;
	Mon,  7 Dec 2009 02:36:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SmC1Fq52L4v4iQjRbRmPnaBwKGo=; b=EBHkyA
	+JaRZ4ViFsRnzNO816w0+W51sTD3Hg/Po9MT+niviJFlCW+0kYPXuV9za1tLcuUW
	v1ZhdtYnPNImoDpDa9dpSs2ltyGbsdY2UoFfDeXlA9XyEK17FrzRXocUuR24H2HX
	ZeMvqnpiZgwUwxtK2kaX0Zn7gcvtT8ll2IFws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uqJrG7oglrvMwsKTz2lHJXntB229t6Tp
	LYbb8dEv6SEeFKhCwK0WW3KQV96duaGSvfvI6Uy+GjiLwToqsSetl3+3SitxJ7O/
	ZCToaUogTuyrzizINd2qSyUbXyycUT2IwS+FSO0bQzLVGkAboaPdgM2Uz/1LYzIB
	dsFr8s7kR3Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7747986F9F;
	Mon,  7 Dec 2009 02:36:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D39D286F9E; Mon,  7 Dec
 2009 02:36:09 -0500 (EST)
In-Reply-To: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Sun\,  6 Dec 2009 18\:28\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 319D3B5C-E303-11DE-83C2-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134721>

I queued to ease the discussion in 'pu'.  I had to fix-up some conflicts
while doing so.  Please sanity check the result.

Thanks.
