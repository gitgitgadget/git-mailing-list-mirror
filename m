From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] prompt: squelch error output from cat
Date: Fri, 14 Jun 2013 11:19:09 -0700
Message-ID: <7vobb8o8rm.fsf@alter.siamese.dyndns.org>
References: <1371198485-32663-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 20:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnYai-0003LL-CW
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 20:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab3FNSTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 14:19:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab3FNSTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 14:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 276FB28D24;
	Fri, 14 Jun 2013 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z2QpEj+qgKikNrLRcYuZLQ4rdmg=; b=TxlFjD
	Sj0CIMlPVVGYH++nB6ZV7KLJ9Wdvur55JHHu8x3x/GkZL1eFnJs2iWF3aVIUi29y
	47O7IRy8te6T60NkLs60xCO5S8xTrcqSHWAYB2LOQycosOGNINNea2rmS/L46ElT
	U9JV9YN6uKoi8mFfsKhx8rZ3DtOqs6lb7c73M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXQ0vc7oEG3Dn6Fx7DAEco2rVa70beg5
	mkChBKGHmXahBZ1SmIMosUlJw9noevFEs5kWfM0dISH1Lc0/19x8uUpV2lbyNXC7
	zPOCXm1/LmqCWI5c5ifRkhjkJkgceEVY2c3KAwTaJXx494zRxBQ+rfXZfUwYIsmZ
	qufAEWBp678=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BA4F28D23;
	Fri, 14 Jun 2013 18:19:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92DE828D1F;
	Fri, 14 Jun 2013 18:19:10 +0000 (UTC)
In-Reply-To: <1371198485-32663-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 13:58:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8CE1AD8-D51E-11E2-A9AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227907>

Will queue.  Thanks.
