From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] Documentation: clarify branch creation
Date: Fri, 09 Oct 2009 17:57:39 -0700
Message-ID: <7viqeodq0s.fsf@alter.siamese.dyndns.org>
References: <20091009101400.GA16549@progeny.tock>
 <20091009101940.GG16558@progeny.tock>
 <BLU0-SMTP425A9541141B09D790814EAECB0@phx.gbl>
 <20091009183408.GB2477@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLg-0005GI-W7
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbZJJA63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934741AbZJJA63
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934740AbZJJA63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCD8052C2C;
	Fri,  9 Oct 2009 20:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Wuo1YpklFF4MioMUtuUsZj61d1U=; b=JeIxlt9JfzWcwx1kQryYtFt
	jj9eCfVQ/GU7+EOc/FNLW13cTQG6ZUhgnFq7DpPa7tpxCj3rjPLF8cGuxa+RhGd4
	U4ny8V5Otqts+iOlmY13kJXLmnidnU+StuTsnWFAYhI8R7bfma5bxwHIDzRvuyge
	yWY66C4ZTcUBUAcAxfn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=J4d3jnCfuJmmz8yNlhYRCpK40p5mjEyRLKxfvA6VzTv4C1bp0
	A2C47ch0uzqLvkkccvWiy8dXp5XXXmyE99mZfqsfG6hZOyiUOZlOrPXHxJwRd5F4
	K0kbO8nghfIL/52SX+BIkBI7OmWERc7/ZGdt4Jufg9rXcbR1IlGNhxciIs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A26A752C26;
	Fri,  9 Oct 2009 20:57:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3C0352C25; Fri,  9 Oct
 2009 20:57:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB7D6816-B537-11DE-846E-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129865>

Jonathan Nieder <jrnieder@gmail.com> writes:

> So this page should probably point to the what-is-a-branch section of
> the User's Manual.  Maybe something like this?

Sounds good.  Thanks

> -- %< --
> Subject: Documentation: clarify branch creation
>
> The documentation seems to assume that the starting point for a new
> branch is the tip of an existing (ordinary) branch, but that is not
> the most common case.  More often, "git branch" is used to begin
> a branch from a remote-tracking branch, a tag, or an interesting
> commit (e.g. origin/pu^2).  Clarify the language so it can apply
> to these cases.  Thanks to Sean Estabrooks for the wording.
>
> Also add a pointer to the user's manual for the bewildered.
> ...
