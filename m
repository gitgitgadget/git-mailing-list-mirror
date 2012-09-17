From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/4] Support non-WIN32 systems lacking poll()
Date: Mon, 17 Sep 2012 15:38:56 -0700
Message-ID: <7v4nmws29r.fsf@alter.siamese.dyndns.org>
References: <k36h3i$ihb$1@ger.gmane.org>
 <7v392gtl8g.fsf@alter.siamese.dyndns.org> <k383ka$nme$1@ger.gmane.org>
 <k3851v$3po$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDjyN-0006aZ-0q
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab2IQWjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:39:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374Ab2IQWi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 18:38:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA7F681E1;
	Mon, 17 Sep 2012 18:38:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKOvG+k79Y24hCAe3wdIR717HoU=; b=ISdh89
	qA7LuFKGRzo6IXixG7koxXU1IJVD7A2aKZ/jgMuP2M+1pCj4aERakLfp9qn2m141
	V86/7SjdERHGr4E7oYenPoeSb8/JLlqsO/TMFlxhaQtCmk6XL3t2NCzwZorihPc4
	dbF6u6QDEQ0iNOCSPH8eX2HBa7KcqF3ANecmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RTDLrLEM1nFZNbRplAUSbJ74XN8fLV1E
	90+d7EWSS+AKAnnQcIMTR/J2+5zMxN2EKWl37m1OBxOq0cdfq1XBLAILqxHP4EEj
	ZKSppaZ4bZEpzQnf9KaUVudTI5x3Ulq9fz7+WOvE4kDnmewEMKqumVEEveGSeCuZ
	Aj4M5zQZbzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C938F81DF;
	Mon, 17 Sep 2012 18:38:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B89D81DE; Mon, 17 Sep 2012
 18:38:58 -0400 (EDT)
In-Reply-To: <k3851v$3po$1@ger.gmane.org> (Joachim Schmitz's message of "Mon,
 17 Sep 2012 23:34:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78452D22-0118-11E2-BD31-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205763>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Posted but not properly chained... hope that doesn't matter?

Something small like this it doesn't. I am not into bureaucracy ;-)

Thanks.
