From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] Only run aggregate-results over actual counts
Date: Fri, 16 Jul 2010 13:26:55 -0700
Message-ID: <7vfwzjrx4g.fsf@alter.siamese.dyndns.org>
References: <AANLkTil4HfoMPD4ds0uXRPruYrz4CtpAy-4TfEk0E_yT@mail.gmail.com>
 <3ce03e702e005a978d3229fa74860d6529296921.1279272868.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 16 22:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZrV1-0002bp-Jn
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 22:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255Ab0GPU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 16:27:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759192Ab0GPU1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 16:27:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C979BC5524;
	Fri, 16 Jul 2010 16:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=BTAobj
	PKSuANb8vCKiOjeNNRZBy8tl+X9bXKr4+Vh+D6pOL0pvaegFVkGqzBjnAgoavHnn
	mcTR+ihYmmeFrKTXMHTQu+xS9lvVq+X6AHLyhaAgiP+1Nt4k52chBWIhIRJWJvMd
	p9ia+cwJ+06x5a42VnTRAt4j74Nd0zs9zD3Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjIUvAOyKqzdiz8Jhpr5Zq5JZH/KFw8s
	kYf2QFDKNsDPiSpFICMF/zHICZ5g01asiIZtDoMTxz57f+SoiD0YtMzR/biuuwxh
	AvvGqj8oWPcM2kOzyH4ouf/DW0ZbugLI5BFVbpup4//jWvVTfjDHS3wXUEt/LdhO
	GUYAVXFv2TQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A719DC5523;
	Fri, 16 Jul 2010 16:26:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15B6DC5522; Fri, 16 Jul
 2010 16:26:56 -0400 (EDT)
In-Reply-To: <3ce03e702e005a978d3229fa74860d6529296921.1279272868.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 16 Jul 2010 11\:37\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C640E18-9118-11DF-8ECB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151168>

Thanks.
