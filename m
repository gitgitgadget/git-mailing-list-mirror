From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over
 https://.
Date: Mon, 28 Jan 2013 19:03:44 -0800
Message-ID: <7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	giuseppe.bilotta@gmail.com, jnareb@gmail.com
To: Andrej E Baranov <admin@andrej-andb.ru>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U01UX-0006mU-4T
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 04:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab3A2DDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 22:03:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360Ab3A2DDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 22:03:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AEA8B367;
	Mon, 28 Jan 2013 22:03:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=K1WPS6
	DUopHyZuTBW3Yo9cx01XfAMVjPqcPxUNnpP0TEWyp2YULAFinP1CRqtpbo8L1aYb
	Z7DexxI/66zd1ZAGqPhr9+s63p8136GvOgf2EvxFipZSAPgfkWJ9UeauZ0PJORqS
	I4cNiBzShPyeqDj1r2JviSJvHmSV6mHbLoChs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nM+e5Hh7vdvmiGGpWxAJd+hEO0N6z06y
	80gi87nk8X3QaVx5iRjcXIw4J31SSMcLJCWDXE6wVrUvrJTsi8NivTE/uptH7SWZ
	WYu5bIsMf5Z1TfDTS6MimULtEU/CIXvD9KkLhJ4jDsok6RFsW5sn+pIHweJdkkhU
	gOQ1p1gEPyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE5DB366;
	Mon, 28 Jan 2013 22:03:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7BC8B362; Mon, 28 Jan 2013
 22:03:45 -0500 (EST)
In-Reply-To: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru> (Andrej
 E. Baranov's message of "Tue, 29 Jan 2013 00:41:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EDD6468-69C0-11E2-A2AB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214895>

Thanks; will queue.
