From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page (web version)
Date: Wed, 15 Jan 2014 16:29:29 -0800
Message-ID: <xmqqbnzc22hi.fsf@gitster.dls.corp.google.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
	<xmqqwqk37kdy.fsf@gitster.dls.corp.google.com>
	<CAEjxke-fPwTctUt9x_o1YwTKK2fX5TOPA7LStXUh+ejUVxZtpg@mail.gmail.com>
	<xmqq8uuj7olt.fsf@gitster.dls.corp.google.com>
	<CAEjxke9NACjYWP+v1-ZB0epJk9Hwo4g15qBPZexxVNRaKPC3Nw@mail.gmail.com>
	<E942D642-562F-43E3-B896-A38CC5FCBDB9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 01:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3aq1-0002BU-R7
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 01:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbaAPA3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 19:29:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbaAPA3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 19:29:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA76064920;
	Wed, 15 Jan 2014 19:29:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rv9FawS/iLJ17+83Oio65276KvQ=; b=aYnRz1
	Ubq3RMGCm0mrMRB+DfEwPxBjw4uSvzkOt6P3/6a7oAUr2b6SCmnX5FgH9ElkjwIZ
	ioJHA08qeReWhx5mLEZJnz7GD2hEZnp6sTX4IkaDO2erFmH9eZqoei5tWa1Ay+en
	gBLBcJ9OK/Lja5Jy4eE0UlW+Dp4gM97Ff0ypU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mW0Dg4xYfhsQKuxlrfCxOVIMAMa7M1hv
	yOsWcZRWZP7/S2fzAKweVC9bxeLWsFrUG3p4x/oonstReSYdACgrOKv+GWrbUPT6
	75oY+1T6zR7FlzTHSIEQCoFqGaY3inCFEiLvfRm78RmgHbR5oqEx5Le7Zz3r7nCR
	KFOBhUtvCUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE2156491F;
	Wed, 15 Jan 2014 19:29:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 350616491E;
	Wed, 15 Jan 2014 19:29:32 -0500 (EST)
In-Reply-To: <E942D642-562F-43E3-B896-A38CC5FCBDB9@gmail.com> (Kyle J. McKay's
	message of "Wed, 15 Jan 2014 03:29:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44BC1F00-7E45-11E3-B176-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240495>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> in the docbook-xsl sources.  Debian includes a patch file
> "8530_manpages_lists_indentation_fix.dpatch" in [1]:
> ...
> And once I have applied that I suddenly get a correct git-config.1
> file on System A.
> ...
> --Kyle
>
> [1] http://ftp.de.debian.org/debian/pool/main/d/docbook-xsl/docbook-xsl_1.75.2+dfsg-5.diff.gz

Thanks for digging and sharing the result for others.
