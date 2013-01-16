From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: Introduce diff.algorithm variable
Date: Wed, 16 Jan 2013 09:42:14 -0800
Message-ID: <7vbocpxbwp.fsf@alter.siamese.dyndns.org>
References: <cover.1358322212.git.mprivozn@redhat.com>
 <4e2aacd5bbf005f0e372589bf423a8cbd776bc6d.1358322212.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, peff@peff.net
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvX0Z-00062x-IP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3APRmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:42:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab3APRmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:42:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A60A7BAF2;
	Wed, 16 Jan 2013 12:42:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=98WMfJhV2v0kLyYVxWJ/3py12iA=; b=nv8z1W
	a6UskINne6ya9wYlZwsq3SnoLSmf36/46W0kX3iwnKnqh24aFduNV112gzWlrCjx
	Oh9giHPP1hlaozb17HWY2ayL9tV94/HT6ttjwJoA5HMY2vjMFfNFftxhuEpQT3vn
	l16taz0TduPEtBMRjRm4X//j2/6L32XlRXDuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAaD+Ud1jgT1Q+f7T/sPAQVXcH5BLjsF
	N4RtJD3mEX4aR7wypip/zsyNejxWDKdKDevJqdQgVtEnSa45KQm2QaO9LIbE6bKF
	hamZn6Ik9gpcS3RmwFgnvTqQMrZgB2fR+o2zso4b+zAlpRvKOTAtGO1FgdMXWy9s
	G9pQVd0tvrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84EF6BAF0;
	Wed, 16 Jan 2013 12:42:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05BA4BAEB; Wed, 16 Jan 2013
 12:42:15 -0500 (EST)
In-Reply-To: <4e2aacd5bbf005f0e372589bf423a8cbd776bc6d.1358322212.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Wed, 16 Jan 2013 08:51:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1143A3D8-6004-11E2-AB7D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213777>

Will replace the one in 'pu' with this round.  Looking good.

Thanks.
