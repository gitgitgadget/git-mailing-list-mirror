From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: report check out for non-bare clones
Date: Tue, 11 May 2010 18:55:31 -0700
Message-ID: <7vljbp994c.fsf@alter.siamese.dyndns.org>
References: <4BE7E09F.3040303@drmicha.warpmail.net>
 <3521b4733b58bfa516303fafc64d87f05760ea02.1273502583.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Harlan <pgit@pcharlan.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 12 03:56:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC1BB-0004In-GH
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 03:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab0ELB4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 21:56:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab0ELB4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 21:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41AA8B2A94;
	Tue, 11 May 2010 21:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=l8bOlW5tFL8xYCGvZEE85eNLZH0=; b=G4v1fzovfB3MwD4Gm4iHGGD
	osguYSM4Ztak1+CBdtHus1ZHzxWRZKKGM5XGTewYLjmj62zGmvrYoi4dsVzT1esg
	5c6nCJAmv/GsUphLa5/UfNoNeY9/uwRiWuap3aGy8FkviuZ9dI5wckpZHWPl8cLa
	yQPsRF/vNTJ++kGsxjFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=M4MTeDSBvAYAPxrA0wgHV7fXSWFxpf2g/T6nmnxWaomXfV9NF
	RPfPVNkjch65FPw5zhyfpKy7Fe+X0BCQlhiDEC7AgfCJ2xYomY0TeV6W1vISi8g+
	5FL7hUyRVtrCtgvGdbe0k0QkjCeg7lc6/xDvf5jiHQ6WoeklxkWjbmZq1A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E975CB2A8F;
	Tue, 11 May 2010 21:55:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9DD9B2A8D; Tue, 11 May
 2010 21:55:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FAB12FC-5D69-11DF-909D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146915>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> In the case of a detached head, (null) is the branch name.

I think that depends on your particular libc implementation that helpfully
makes printf("%s", NULL) not to at least dump core.
