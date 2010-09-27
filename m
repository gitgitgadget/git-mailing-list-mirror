From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status.c: don't leak directory entries when
 processing untracked,ignored
Date: Mon, 27 Sep 2010 15:19:36 -0700
Message-ID: <7vmxr2x213.fsf@alter.siamese.dyndns.org>
References: <1285555753-15858-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:19:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M31-0006Rs-AH
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760058Ab0I0WTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 18:19:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0I0WTm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 18:19:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E04EDA364;
	Mon, 27 Sep 2010 18:19:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=XbYxrXwY5aseTPk/ovwUgCZ
	4N00T6x0M+EXLF0jbJcF8a9meljIOLcxONh3MYxsl6BwNYwnTYMwr7dcRtiGXnNe
	tFfUAoVWMY1Ue2Wxe7IDYutWlLQjZ+Clmoq89xhmPDYDoVefopGwdp7fZ1Ys19FO
	b9jdFLyKSfmI+3RYZ3m4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iuX9ZMFZizQmfTwjSEx4glkfV5nBBA125bTIRbp+krRvo1TyV
	epW1UwC9nj1bEhl8kdgVhULGiTAvYTI/Y5qNd3i3gN+6m3xu82jrYD4LFQQhN3Vz
	KluhNitP02MQnd0X3jWObWlbDWxo6DtT/YS9v/E7U33WmjJ9bM4eTgAwpU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B6DEDA360;
	Mon, 27 Sep 2010 18:19:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65438DA35D; Mon, 27 Sep
 2010 18:19:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 520900C8-CA85-11DF-B0DB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157369>

Thanks.
