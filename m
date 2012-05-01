From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 01 May 2012 13:33:25 -0700
Message-ID: <7vipgf8wve.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 22:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJlN-0000Eg-Nz
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab2EAUd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:33:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007Ab2EAUd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:33:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8484C69BA;
	Tue,  1 May 2012 16:33:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r6HmD0rnGjemDgJaE119sK9wuQg=; b=v+JCbB
	QFv0Wgtu3hpXy5RMYmVNZmTOyDbBo8+GS5K7ZZPcsmvGKFF75zx6PUevKXb2P6hb
	+0HN7IRw6eIfg5OJxM1/qu9LBZYazc5k4jYYOAivoYjG/p8AbV3zKImQcUZjW5dM
	xInvC82KPqZu7BZF3KdjKXg3m8fPunUTR6dJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v52gm9qxSFgy7jI7V2jH8BadFhqVfbU7
	u9FDG2ED/5OF2j2p2FRBsI8hFD13uOWEDGdeiQgyDrFrNcM9jrLnPfyCqbOozd5m
	m2XARUeHoO38se/fMrJLGxpOMK+Iodc03SZ150IHzwpyTMNZvGgGhUVSz5Kan2P7
	ll+dcWRHn8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AADF69B9;
	Tue,  1 May 2012 16:33:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFD1469B7; Tue,  1 May 2012
 16:33:26 -0400 (EDT)
In-Reply-To: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com> (Hilco
 Wijbenga's message of "Tue, 1 May 2012 13:24:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7ACCB66-93CC-11E1-A4EC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196741>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Is there any way to get (some of) the Git hooks to run for everyone
> without everyone having to install them separately? If no, is this by
> design or simply a feature nobody has asked for (yet)?

By design.  Do you want me to include "rm -fr ~hilco" in some hook of
git.git repository?
