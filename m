From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lockfile: show absolute filename in
 unable_to_lock_message.
Date: Tue, 12 Jan 2010 22:56:19 -0800
Message-ID: <7vk4vmsdbg.fsf@alter.siamese.dyndns.org>
References: <4B44DB6A.2050804@kdbg.org>
 <1262876050-345-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9c-00010g-55
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab0AMG43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957Ab0AMG41
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab0AMG41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:56:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACFD99002F;
	Wed, 13 Jan 2010 01:56:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Y7b9gnKwiZFaw/di6waGJqa
	pyMWEbcRqehi3HHeyOu2TxkN6lOzgqn63ArVYkztIxToJRty9r/hnGx+/11rK83R
	FpvYDfoUi4WQ6xDLbiq5m0c04t2BfI3F1HMY0tmt2bjf0BCeeRxaLi90PyRT6yAc
	W+B2U1/nQtUTlwkEtU9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kBv7isnOyfuVkki4MbanKIH6z0r3j/1n2jHhTJ3sq8uU/GXar
	CEVR4GqKgIfRVYm5zNULWkgQQ/SHwH7GNCrdFLlNdO48TEfVuPH7qvnKERmKXMKa
	7Bk6kXPFaZvlwaXI6HQXmSH+AAiRdJv4tKjyqvqiTIlgQ6qeMLFE5EYvAk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 889199002C;
	Wed, 13 Jan 2010 01:56:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCD109002B; Wed, 13 Jan
 2010 01:56:20 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C395D616-0010-11DF-B8E7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136781>

Thanks.
