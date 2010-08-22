From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Extensions of core.ignorecase=true support
Date: Sun, 22 Aug 2010 00:23:22 -0700
Message-ID: <7vpqxb5cwl.fsf@alter.siamese.dyndns.org>
References: <cover.1281985411.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:27:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4xp-0004hz-IX
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0HVHXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 03:23:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab0HVHXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 03:23:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E842CD85B;
	Sun, 22 Aug 2010 03:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BNief8jRNRbeGoJpqC6n175esfE=; b=ZMg0oLWYFLEc7fVbizZ8+Ql
	vzLyE2/2c1R7SPVX75KmU3gF0BVUkqkIp+8DdoGC5bH/nhDeUBeyWqbcijNKhZ9S
	5RrwcWxHaxI8N3T4TAnX16j+n0mzcwFUhiKPCixhJsSrSxsBKwWzcXmLnQyP1B6S
	9Si1drI6K5ZfRXvqKqzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HQRd7o3kvTKpRRWTAW/3TyG0+Y1UThi/hKNBBOhGx1U7ENUzG
	+jmbbM+YiPmNP2VBvgqsGWTPo729GkyRw745EQvx5C/vbgmVZ/sSmfW1Hh7iJ0Em
	ePtjdYl0FpTANLvszRrdK8hxchUJsC41E7rw4T+6LoCtfC7cq3sncs6LG8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8797BCD85A;
	Sun, 22 Aug 2010 03:23:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9273CD855; Sun, 22 Aug
 2010 03:23:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28431D02-ADBE-11DF-96D0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154174>

Johannes Sixt <j6t@kdbg.org> writes:

> I support the idea of this patch, and I can confirm that it works: I've
> used this series in production both with core.ignorecase set to true and
> to false, and in the former case, with directories and files with case
> different from the index.

Thanks
