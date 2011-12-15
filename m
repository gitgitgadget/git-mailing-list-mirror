From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] test-lib: allow testing another git build tree
Date: Wed, 14 Dec 2011 19:07:35 -0800
Message-ID: <7vsjkmpm6g.fsf@alter.siamese.dyndns.org>
References: <cover.1323876121.git.trast@student.ethz.ch>
 <94f64a03398829bb9a11c18577efb39d9b153eca.1323876121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 15 04:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb1fc-0005pV-MB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 04:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521Ab1LODHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 22:07:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357Ab1LODHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 22:07:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE656E47;
	Wed, 14 Dec 2011 22:07:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fRD7C6tktzE1KF00u0Iz2qEcYx8=; b=hcaAw3
	x0A9fv1EmQ3QozO34qW8Z4MPgPMrtGkRDD1yoZ7pm71v1gfSkMWuaWIwbns/2E/+
	fEMVUQi5QEaabikybgG2opCF7V9ZGHsIOx0vLUKQkaTOdEVkbA7Ez5gpSih9Xih9
	Dw2b/n9jmjSJDDb7SlCKLJM4my1lGSkK14zaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VgpjuGK71XcNGC0DPto7oUIA2UQqPRho
	0EqYMEG2hDW6TMEAW36s2ngm9tRpFgBNbP5KfIL4n1T/BiTGJSIobTjlOqorT7ZP
	ERy49hpAChvK8C6xJojK+lf82Xa75Ze+PoQfbmyWFbaREv54MtR9a2qseovVkQnH
	VW1J55K7Mv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A540E6E46;
	Wed, 14 Dec 2011 22:07:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 347D86E45; Wed, 14 Dec 2011
 22:07:37 -0500 (EST)
In-Reply-To: <94f64a03398829bb9a11c18577efb39d9b153eca.1323876121.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 14 Dec 2011 16:23:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F10CF282-26C9-11E1-8A81-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187184>

Thomas Rast <trast@student.ethz.ch> writes:

> The perf-lib work wants this feature, so we may as well do it for
> test-lib in general.

How is this different from what GIT_TEST_INSTALLED already gives us
(other than "needs more diskspace to keep another source tree fully
built", that is)?
