From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 03/15] pthread.patch
Date: Tue, 16 Mar 2010 00:21:17 -0700
Message-ID: <7v7hpcohoy.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054311.332443000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:21:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR5l-0002vx-Ef
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937498Ab0CPHVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:21:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937471Ab0CPHVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:21:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 461E0A2F68;
	Tue, 16 Mar 2010 03:21:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=gfEDImz0ejfhqq0C5vqvaehM8mk=; b=b02a9IuJ7CoXfqfk76VNE/G
	6uni8B8UzS4SXMQaK2vFPIt9NgC1GkKeU//GPQ4luH90ifRakTWAj7fkTdJtyY6H
	V5zxXG/6CvzyG3jOma+S5lRI/BJ9C7WWPSf98Smv+PUzMeUMtnHylmVQFBirZCTs
	DQ4uVPf1AFi/RIiQaPXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=afg1R16x2KtyOe23jKgL/X/MWoPS0EVd+g/zQArbZ9F5Gq9z6
	OGG7m6+rAgyQrQ5vjUlkeuatbCaYlD800PsUMKXAVkRAM4azqMYEeM56Y5L6kh8K
	OPj3HcqwnnWSEePHVWWKHqZrReN7BLdPwbS8Un1AKfP7IVXOQ0nXgQPbHk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FAF7A2F66;
	Tue, 16 Mar 2010 03:21:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8090CA2F64; Tue, 16 Mar
 2010 03:21:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8534B062-30CC-11DF-8A3C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142325>

Looked sane (I didn't apply nor test, only read it through, though);
thanks.
