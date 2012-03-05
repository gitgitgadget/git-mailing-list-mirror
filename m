From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] http: support proxies that needs authentication
Date: Mon, 05 Mar 2012 09:30:55 -0800
Message-ID: <7vzkbv0xbk.fsf@alter.siamese.dyndns.org>
References: <4F54D8BB.4080305@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4bkV-0007GQ-4u
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab2CERa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:30:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2CERa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:30:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55F247535;
	Mon,  5 Mar 2012 12:30:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UbNhgHCXAz5gsipfq6A2a59NC0U=; b=sP97+8
	zeQEAVc2Txs1NQu7GudlgLG8rHQJAEPGTfsTyT9ZHZ+6He+oJRZfuWiw7oTpv+Es
	BCQhwrfB+y7HYTaLETiV3k7gogknKHrObfN36qwILUqU8Bu/acXuAboLqU59nJ9U
	5oHdAAOMWn8lKezXYRXcIJxMmCAWJ9U0899gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsa64OAaGE3E14UDYpaY3PSGkHIQJeqw
	I9eI9WMp0W4RS5Ly6ZddifCxK5+YR3d+mRWaASX3n/75PxEsXML9jke7CVVz140v
	CN6O6OVGOF9KYliC5wF3QSmXv+nJiALoAnhE8/Lx1OxBSXY2IW5hAU/LE4TTkWvW
	s+95R6I0yeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4908C7533;
	Mon,  5 Mar 2012 12:30:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC9847532; Mon,  5 Mar 2012
 12:30:56 -0500 (EST)
In-Reply-To: <4F54D8BB.4080305@seap.minhap.es> (Nelson Benitez Leon's message
 of "Mon, 05 Mar 2012 16:16:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F77E026E-66E8-11E1-803A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192256>

Thanks; I think I already have the same change.
