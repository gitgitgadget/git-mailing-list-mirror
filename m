From: Junio C Hamano <gitster@pobox.com>
Subject: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 08:46:42 -0700
Message-ID: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCYbj-0004u4-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 17:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab2C0Pqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 11:46:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131Ab2C0Pqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 11:46:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5908D43E1;
	Tue, 27 Mar 2012 11:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	dznJNfBwGXpXQeoDlqU12fxbvE=; b=YJqlaRJlF1C8V3C4rvEBK3sKwebdLNAGE
	BGqseAWMCI5wopefXcFKPBNzQd6HjP2sQGrhFHQcsO0CvRks1Fnp91Tm0xNY4wKY
	576+a7xH4/QTcNOebjV0kb8kTQzsCtdMikcf/IIgqleVO6RKYK30pmsvzceD0U/Y
	H6n8d80lrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=lNYlFTAOj3wfzJxh7HnA10rsLultrK73yPprqitTgxH0DQMKqpwtmP+M
	s2J8wCJX6vf74T/aiqFG3lHqjXXqjk6oLQYywVHLppO+LWZlnqeBzzheu82epiSV
	BbZM0NZeVIMUpgW5v+JONv/LPiV3eU6q1yupNX71CUqRCOhO6sQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C39D43DF;
	Tue, 27 Mar 2012 11:46:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6FEF43D2; Tue, 27 Mar 2012
 11:46:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D68C0A4-7824-11E1-99E7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194053>

I just noticed that

	git ls-remote git://repo.or.cz/alt-git.git/

works, but neither of the following does:

	git ls-remote git://git://github.com/gitster/git.git/
	git ls-remote git://git://github.com/gitster/git/

It is just a minor irritation but it would be really nice if you can fix
it (please don't spend too much time on it if it is too involved, though).
