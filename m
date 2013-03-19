From: Junio C Hamano <gitster@pobox.com>
Subject: [Notice] The tip of 'next' rewound, 1st wave of topics graduated
Date: Tue, 19 Mar 2013 16:31:37 -0700
Message-ID: <7vr4jbge5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 00:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI60o-00028Z-UK
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 00:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090Ab3CSXbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 19:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755048Ab3CSXbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 19:31:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C066760;
	Tue, 19 Mar 2013 19:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	6ZM29Y2Sy+BRpZMTepqwUVHo1Y=; b=cZXyDe3rn+SSG3JwHCEmF99Q0mteFfq+R
	Cl1iIjXHtcxt3knBUj54d9dyOysF9WAqZHVkVjCJm+ynintU1BPIFJf/s7ThaXOv
	oOi7/90YLQ30js2Tdz9NjHRB0+hJ4ViI1Os3qML+lHCHo4gIhAS8c5doOVH4OhYB
	Nbs5zBjUPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Xgp
	w4HuIwa8OIjDC0/nQhnx6OKOgS+Bt44OEUpB7eWWZl2ZqgEBJAaq43jDLPdlpCJf
	AdWgAA7nkmrqELunkp2EtdL/mFG8VLn7L+3x7ApRAvv7mTV6eRRssAXXxZ7du1mX
	BdPMmAVJ+BLlfnG9JoMuu6kzfftdIYkn3z1oZ0oQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBC52675F;
	Tue, 19 Mar 2013 19:31:39 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59075675E; Tue, 19 Mar 2013
 19:31:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25FFF938-90ED-11E2-87F1-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218567>

The subject says it all.  I didn't get around to Jonathan's
add-u/-A, Thomas's packed_object_info() work, .gitattributes
regression that made plain pattern not to match directories, or
longstanding apply --whitespace=fix breakage today.
