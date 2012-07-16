From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] git-remote-mediawiki: fixes, optimizations, and
 progress report
Date: Mon, 16 Jul 2012 11:52:08 -0700
Message-ID: <7vr4sb1quf.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqqP4-0008Hf-MT
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab2GPSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:52:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab2GPSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:52:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CF8B8356;
	Mon, 16 Jul 2012 14:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3NJmPw82Wnlu6apUAXp2/bS9k84=; b=Fm1c7D
	88Zeow4xqlcXc+vuDs7TyoRO8FwMpkRq8vJJM1tay8H2N1oSACSXRcSWdNvaNKlL
	yy6hpCeA2FLO5S29g9TZK7FSA8ikkgeNTHZV06lB9nozxkzz8/7moyrm9RcPPVRQ
	KesaUrG7R583yl6wS4ZH7teOW+VPpjynGe6h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LDYsMYDgYpExtNKH4BX93v+nhx+kt2Va
	oixHWLzGuzyP9PiscMFx8ifQ2FrTN17yXMTnCta2AnPRSeb7r+pvTARo7MStKxsq
	0qZ6OklmoABn2x6We4TdBMi1Sa++ZQa7uPV5T9qZET7GVtsFhRjZxN08X4Ak9u/u
	0w8mDe8GJd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 288998355;
	Mon, 16 Jul 2012 14:52:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C638354; Mon, 16 Jul 2012
 14:52:10 -0400 (EDT)
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 16 Jul 2012 14:00:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 596DD46C-CF77-11E1-8F7C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201544>

Thanks for updates. Will queue on 'pu' as-is.
