From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: guitools: add the path in the confirmation
 dialog for tools which needs one
Date: Fri, 21 Oct 2011 15:43:42 -0700
Message-ID: <7v62ji7yox.fsf@alter.siamese.dyndns.org>
References: <2fef219736a0787ed864b5c18adf31f7a4e8acda.1319139139.git.bert.wesarg@googlemail.com> <87ipni3s3n.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 00:43:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHNod-00036x-13
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 00:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab1JUWnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 18:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1JUWnq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 18:43:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D068A6BAB;
	Fri, 21 Oct 2011 18:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SGzvBPt/vNZ/zAHUGf1OE2m0k7Q=; b=IJWirH
	UgHj6zT6b96YHD4/0wz9eFJysVbb86DZxdg4VWU7RoDwhzpb8pRd7G/qdLtrWrZy
	gqn6hgV1iPDw3/gzFo4OEZK8EVCghHh1ZihkF3uWhF/mlOMjWbl2JxQrO6QSOC/W
	mcCWYMmMVzi0Fm7/FSuZi2vRu7PBflJ4s6g/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kIqbeM8DvPetUJ+v6es/4qV3DtIPY39F
	lgS5eMvV/j9AP19oFWUujGh2+5rWFw8BGgJAt3MLpfZxkXNy7Bbaefj5Poyx8aE+
	tm5NGfcpZF4oUSTyJenAZ0IgLhIcnaPwzkBw5p/At+vtiUFPVa8NRnVRPRpzwuCc
	U+O027BhNKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C4D6BAA;
	Fri, 21 Oct 2011 18:43:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F4C36BA9; Fri, 21 Oct 2011
 18:43:44 -0400 (EDT)
In-Reply-To: <87ipni3s3n.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Fri,
 21 Oct 2011 23:19:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21A510FA-FC36-11E0-B865-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184091>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> .... I modified the string there to use positional
> parameters as sometimes translations need to re-order things and the
> msgcat format can support this using [mc {%2$s and %1$d} $first $second]

Good catch.
