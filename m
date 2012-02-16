From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff
 and Git
Date: Thu, 16 Feb 2012 13:04:25 -0800
Message-ID: <7vfweaxzfq.fsf@alter.siamese.dyndns.org>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
 <7v8vk2zghl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 22:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry8VH-0002pQ-No
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 22:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab2BPVE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 16:04:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab2BPVE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 16:04:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0EC26BFA;
	Thu, 16 Feb 2012 16:04:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/OpSzSyx+ekocozK9F+moG+BljU=; b=IBtJ4t
	sotFH7LsxFMT4a6GOuj0ioH5VgRUjxWOT5cmHKl4XtVykr9V9J289FT1iFUVKssh
	pjaJ5w8igoI7Bsu2dTgcNkpLHXqglrIL4VsGitR5cPpeWj5XNYpVamyfjHDrLxld
	HscWYK6rMh92ItDHCr0FIpVwDcHuzaFcNTCdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vvql1rgTXKSJpG2q9smc7nXB8CzbsyJl
	ULS0HW7/J3k9m04Znuy7MllzUCDKtNJioaNqznXsH4gQZfEz15yS9zbrr4w3LuYv
	9odPAk86V1tDy+O2WYOZ5GQtD7cHKkQBDBptutHceA1Y/sjR1WAasyVOPQwAV1Ng
	VGnVwLfP7FA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8BC86BF9;
	Thu, 16 Feb 2012 16:04:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 725116BF8; Thu, 16 Feb 2012
 16:04:26 -0500 (EST)
In-Reply-To: <7v8vk2zghl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 16 Feb 2012 12:10:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF30EC5A-58E1-11E1-838B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190910>

Junio C Hamano <gitster@pobox.com> writes:

> Honestly speaking, this is looking more like an "useful application for
> latex users who happen to use git to store their document source", and not
> a "useful addition for all git users", to me.

Sorry, un-proofread draft escaped.

Please replace "for all git users" with "to git to help users who happen
to have latex documents in their repositories."
