From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-multimail: update to version 1.0.0
Date: Mon, 07 Apr 2014 11:56:42 -0700
Message-ID: <xmqqd2gtm0id.fsf@gitster.dls.corp.google.com>
References: <1396884040-26014-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEjH-0004Ty-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbaDGS4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 14:56:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577AbaDGS4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 14:56:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D941C7A2CC;
	Mon,  7 Apr 2014 14:56:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=peknWFmjpIMZ
	5Q2b9g0NnQ7wzpo=; b=lxmPFD4cJ5HyP/9gHq0ljd8gitNWwbvSRN+7vauqcipn
	B41BIqThWp11rI3JB6wXjUWW/ki0f/fTWUVA3JYYy7+qEvQbCechGfAIi+HsBrUq
	bBB7Nw6gJyWx4fNc8ugfgJVtwoYTaK6ne4mT+y8Ni87vjn3vi4hNgcDeBSS4EhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XHCJvQ
	fCtXpyR5cGDJZ/PkuU2qG7rO5hQUupWXx+lCLC0ylW5VQLRIHNbz0PZrzJB4iVLi
	McyygGM7n0BTe9HMQPVpLVfoxwwVbVnCWvYtjYRFG4C9X/MnBgQ3ywWu9ltX2VCT
	jmTOJQ0xSwOOM6qmmvbYHBvsPfIYfmOt8vK+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C32F37A2CB;
	Mon,  7 Apr 2014 14:56:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C10BC7A2CA;
	Mon,  7 Apr 2014 14:56:43 -0400 (EDT)
In-Reply-To: <1396884040-26014-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 7 Apr 2014 17:20:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C7FA93C-BE86-11E3-A1B8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245889>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ...
> Contributions-by: Rapha=C3=ABl Hertzog <hertzog@debian.org>
> Contributions-by: Eric Berberich <eric.berberich@gmail.com>
> Contributions-by: Michiel Holtkamp <git@elfstone.nl>
> Contributions-by: Malte Swart <mswart@devtation.de>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Junio, how would you like other people's contributions to be recorded
> within the Git project?  I have listed them above as
> "Contributions-by".  All of these people have signed off on their
> contributions (recorded in my GitHub repo).  So should I also/instead
> add "Signed-off-by" for those people?

Either is fine, as long as somewhere in that directory:

 - we make it clear that the copy we have in contrib/ is merely for
   "batteries included" convenience;

 - we refer to the canonical source that is your repository;

 - we tell readers to go there to get the authoritative and up to
   date copy, as what we have in contrib/ is possibly stale.

In the longer term, I have a feeling that we may be better off to
make the "git core" tree not be the "batteris included" convenience
tree, though.  In the early days, Linus's rationale for including
"gitk" held true: having tools that are not quite core is a good way
to get people (especially those without C background) involved in
the still-small project in its infancy to help nurture the developer
community.  The same reasoning stood behind the merging of "gitweb".

We already are beyond that stage, and good tools like iMerge and
multimail that can stand on its own may be better off flourishing
outside "git core" tree, still within the same developer community.
