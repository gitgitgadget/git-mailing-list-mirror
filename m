From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add deprecated __git_complete_file ()
Date: Fri, 07 Jun 2013 13:38:16 -0700
Message-ID: <7vobbhsll3.fsf@alter.siamese.dyndns.org>
References: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:38:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3QW-0001Xa-3G
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603Ab3FGUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:38:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FGUiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:38:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DE9826CAB;
	Fri,  7 Jun 2013 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9sE5tF7z8blyL55nHQzO2bNsRLQ=; b=uNsGLv
	V9xAeXOdQ9zE1vhZ8Ii2RDQeo1MwymSBs9nJ/aa1IPhQJo+BoF8j9lxG9mkqMojv
	+QbztbMTH+xz3OoJwbgA1Xh0rjJSLmIkmBwDuEwr58rLyFPo1geHqZII2Mk1KVv1
	unZbGmIxEKKVYO25cT8Y15TM4WNMzKBp2JVho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ivQYwCPVQVkw4+jjaHm20fQqquN8SjQe
	roNzxkCavem7G9e1EaEFLq1905rhrsFJXTZxEsRQCajq9GwgW4ZQYAKS+0RPy721
	3HbCt+dcXeh6ppC5WabytE7LlmHVtacIMl8VXXrf8tfQW+00oBH6WBFONyZGPb7N
	/5mtbB2TJqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7403026CAA;
	Fri,  7 Jun 2013 20:38:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3F3126CA8;
	Fri,  7 Jun 2013 20:38:17 +0000 (UTC)
In-Reply-To: <1370632168-25298-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 8 Jun 2013 00:39:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F4FDA72-CFB2-11E2-8205-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226703>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 77c130 (completion: clarify ls-tree, archive, show completion,
> 2013-06-02) removed __git_complete_file () because it had no callers
> left in the file.  However, to avoid breaking user scripts that may
> depend on this, add it back as a deprecated alias.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Based on pu.

Will queue; thanks.  With this, I think it will be safe to push the
series in question to 'master'.
