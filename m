From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] submodule+shallow clone feature request
Date: Wed, 10 Feb 2010 15:09:09 -0800
Message-ID: <7v1vgszo16.fsf@alter.siamese.dyndns.org>
References: <4B73277C.9010801@columbia.edu>
 <7vsk983fi4.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002102354010.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Schuyler Duveen <sky@columbia.edu>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 11 00:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfLgW-0002tR-CV
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 00:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab0BJXJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 18:09:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0BJXJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 18:09:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9146298617;
	Wed, 10 Feb 2010 18:09:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=whZ8Rlp8AwQcu1BfZ2xGqLfEkRI=; b=DDv4+5
	W4ICzfW/r3cackBj7YLQeeewybW8xGqB7rEGqkJK2s/19TyBDxQDiVXQ96HJZqWT
	zPdzp7HP3HyexChkd3FYI5Up+UENIi1XZc0CEjrJqh8VVKGzez2sVE6Kj06OuOq9
	fOxB2vDyIlVOtGpT9BtycmH8IvZ2OARYJ4JZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k6wXnxjlrsclDXhemNt//4Vbh9MNk8L8
	FH5ugOuLUzHy3JFCIW4VOO3P09NaboUswLGl5QJ1whOGuGrFgjhNFxdCMD0/DSOq
	uISo+WmK79JXKvPLTdOgRc0YqiOzhBE8fpHbC3bBsSdPNcxWAzE4q3JE6lt7PhgS
	cauGJeJDtYQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 582AE98613;
	Wed, 10 Feb 2010 18:09:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69B2B9860C; Wed, 10 Feb
 2010 18:09:11 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1002102354010.20986@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 10 Feb 2010 23\:57\:54 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F747D92-1699-11DF-AC58-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139566>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes. Note, though, that the problems of enhancing git-submodule are not 
> technical, as we can learn from the recent history, including the lack of 
> support for rebasing submodules (there _were_ patches!).

Sorry I don't recall.  Were they of 'next' quality?  How well were they
reviewed?
