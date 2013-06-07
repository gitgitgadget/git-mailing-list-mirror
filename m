From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] sequencer: trivial fix
Date: Fri, 07 Jun 2013 15:49:20 -0700
Message-ID: <7vsj0tr0y7.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5TL-0004xg-CQ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab3FGWtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:49:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FGWtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:49:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F718265A9;
	Fri,  7 Jun 2013 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TO2tjxo1C/HxOsigQn/x+WFQu48=; b=FzxYYG
	PCjGlJJMktVZUTJV2VImqEdCnodB61+g9DDPtECIpWiDEmHiu2EoiJ5pGizgCKfE
	VlUVjweX2WY5XP3pBgaGY6NNPkbjKpQmpg+y5xTWIZ2nRcnQurZNsJrLfEmnlDI1
	/XbvK5E10mOYZ2KXvvnhSuKyovevPWrcV7sis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WlssAQFFrV7otSOubjexnJGUCTaHLn71
	MLjIK6RH4lJE11QupbSGUgE2wrBnQwZqp4KvRTc2GdQ2iEKPd7KqqV8sDbADZRtX
	oY6miHR0R7VyvxcWovr+tiNLpCgP2ZmIAqZKk3qYAOi9sD925Y0ICf2WHK5nnDKO
	DO8j0ztuFn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 234F1265A8;
	Fri,  7 Jun 2013 22:49:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99417265A7;
	Fri,  7 Jun 2013 22:49:21 +0000 (UTC)
In-Reply-To: <1370637143-21336-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 7 Jun 2013 15:32:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E70C4D8-CFC4-11E2-A0C0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226762>

Thanks.

I thought the conclusion was that combination of c8d1351 and 706728a
we already queued was the right change.  Is this meant to replace
them?
