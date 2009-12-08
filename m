From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 1/8] Add remote helper debug mode
Date: Tue, 08 Dec 2009 15:34:05 -0800
Message-ID: <7v7hsx6nwy.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9ZU-0004jp-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937014AbZLHXeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937006AbZLHXeI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:34:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937003AbZLHXeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:34:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF830862C6;
	Tue,  8 Dec 2009 18:34:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iu8CJspcIYIGIetltAnO8xpAO3A=; b=YDBIxzCYfuxSBWqXMQEZRBo
	byVxoDobQeaOTBzM0NaJ/3L83EZnrbeQyG7BkA5KCnz0mLoNNgMnB1NFkvtlQUwT
	8W2TkBr9VXu6qjS3h3aMcl/YVHX1iEnacrhvk4fzSurN5beKrd9AHmDzbEpWgO5z
	bneknFOFj2CxwtHM4ZAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vb0HxRw/QVi7K/0fJ7VtgsNDZ3dfq3UX1uBDgMybrv5VYZTJn
	OgwbQnX3CyItyUI1m1KkIRZgwIQEoJ22bPZ2NoTo7prNWhNXb/uYtR1YhrTb4OUH
	F81ce1Ngpm2UGZs+Q88MLPPZ/Pq5bsIKifTNkzpRUgsiGqgTp4VE90Bw5s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0140862C5;
	Tue,  8 Dec 2009 18:34:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43504862C3; Tue,  8 Dec
 2009 18:34:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F36211C-E452-11DE-9A3C-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134921>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Remote helpers deadlock easily, so support debug mode which shows the
> interaction steps.

Also new helper functions, sendline(), recvline(), write_constant() and
xchgline() introduces abstraction that makes the whole thing a lot nicer
to read ;-).

Nice.
