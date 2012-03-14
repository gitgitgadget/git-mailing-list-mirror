From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff: tweak a _copy_ of diff_options with word-diff
Date: Wed, 14 Mar 2012 12:38:06 -0700
Message-ID: <7vhaxrotwh.fsf@alter.siamese.dyndns.org>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> <b7d30afe65910ffe614a894db65386477778c4da.1331749299.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7u1X-00057n-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761462Ab2CNTiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:38:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab2CNTiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:38:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7167D6DA7;
	Wed, 14 Mar 2012 15:38:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGOl8KgNI6KTiSu/xWFdEnBbrIE=; b=ZspSic
	j+UwoDBH/UUJcmVoAYrjZiaVvScc3kl8b8TnUWmzvQu4GtsFKH8QU0buPjm1OX7u
	COT7D2sZpGdATOQdOMp0Vp2RSn5RrsqAgNLzhDPYIISTiWnR4EGUP0rsdwG2ZkSV
	XFRnWQwWKoKx5CAY14JG4NotAeQmftcIBWx4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mKqLNEgwEA13J4L8pQCglBdX/Tkyd7F2
	T1pEttJHCoR7xQKLIUal2X1L0zjorH331k/13WK9Qtymj3dZskxFlXI7y7m+Bn7e
	dgSTh6kkIYaGtUzImMkKPHDiB7+Gscs49nFyga9CUcYN3x8qdTRuVEavq6F1rOiH
	2Z3zH2ZiGBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 685ED6DA5;
	Wed, 14 Mar 2012 15:38:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3FF96DA4; Wed, 14 Mar 2012
 15:38:07 -0400 (EDT)
In-Reply-To: <b7d30afe65910ffe614a894db65386477778c4da.1331749299.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 14 Mar 2012 19:24:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39BC6ABE-6E0D-11E1-B09B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193154>

Makes sense.  Thanks.
