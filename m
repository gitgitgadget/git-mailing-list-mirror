From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: avoid tracking intermediate build
 products
Date: Sun, 08 Nov 2009 11:08:02 -0800
Message-ID: <7vvdhkdect.fsf@alter.siamese.dyndns.org>
References: <20091108112009.GA23790@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 20:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7D7c-0004Nm-UC
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 20:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbZKHTIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 14:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbZKHTII
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 14:08:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbZKHTII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 14:08:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE74778A08;
	Sun,  8 Nov 2009 14:08:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=Ez02jwTN8XJB7ufXJf4tRaSn60Q=; b=YiBqVj
	KyZgLTT/1Leq5+rZ6qhy/1rUnw82zX3Gi//PKvTkEyDznRDUvIJnr8kTCEpo9HNi
	l/DTR8IheNIdF613qOVnSutSm5TqKFk0IwoY1V3zVgYGO5M3MlwNNCw3IdEKSvyT
	W3TmqNkkE8+HJH/7WgEU4S8B6PekaE9LhWXyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yGWqBn3PnX0snxgdOGZ1et0UhRBwb8E3
	XUKFK1RMqmcqbKj+YxNWtgDai2+O33KRPwrrRaCxwEyhBbdnIgMWzESz2tCFOcQz
	91TmdnUCWHY9RIfESKGuNy42fQ6GKXO22aNlTBNryw3lXYykI5iYeqCl+ctMcyRa
	yupLheKVPIc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B449C78A06;
	Sun,  8 Nov 2009 14:08:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C364978A04; Sun,  8 Nov
 2009 14:08:03 -0500 (EST)
In-Reply-To: <20091108112009.GA23790@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 8 Nov 2009 05\:20\:09 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D4151DC-CC9A-11DE-83A4-7C40EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132411>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Add *.xml+, *.html+, *.texi+, and *.texi++ to .gitignore.
>
> Cc: Chris Johnsen <chris_johnsen@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Some of these files appeared in the "git status" output after an
> interrupted build.  I hope I caught them all.

Thanks; I think "*+" would suffice, though.
