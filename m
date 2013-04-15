From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 08:53:45 -0700
Message-ID: <7vk3o3zt6e.fsf@alter.siamese.dyndns.org>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URlj7-0003B7-9K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab3DOPxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:53:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3DOPxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:53:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 814DA1675D;
	Mon, 15 Apr 2013 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5xV3G8woJf+S1U1Z8/2S66VsUp8=; b=mOhS1z
	nxayBhlWAY7KZ/0V6uTMCiSMiCv4LsJJ4kTZ7fVpt7JZ42QDrPPnTQmfzlC5i04S
	zFU+tTMFKNd9ep8I/dsu/sRstU04btoZf6uYdhNetN82uLDt3Z5WAljXaS4V5op/
	Ur+nDi6fcXkJGr7fPHuVC68iIW3vWf+DeQ3Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usnORL9Jxbd62HF1XOu+F+Z1m2jdIXul
	mjVwjiETTElwqtjYFY9QxAIJbX5hoevBR36PTcF1zwmv2p+meVPNPuJgVkZcKDnl
	Y1Cv96AoA6e8IkGXkCiNEOFlK2p3PHzL8XZxZOH/HSqUCSbmycr1u7X0Put70rAd
	nqTpqlCINrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 788B61675B;
	Mon, 15 Apr 2013 15:53:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F347316756; Mon, 15 Apr
 2013 15:53:46 +0000 (UTC)
In-Reply-To: <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 20:48:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8586968-A5E4-11E2-963D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221241>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> - Make the -3 and -c switches in git am configuration variables.  I
> have an alias.

 - Make failed "git am --3way" due to "unusable index" a bit more
   helpful. Right now, the information on which hunk failed to apply
   is lost, and there is no "git am --no-3way" (the user needs to
   know the trick ">.git/rebase-apply/threeway").
