From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 13:58:29 -0800
Message-ID: <7vboc9ufzu.fsf@alter.siamese.dyndns.org>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
 <20130128205834.GC7759@google.com> <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrej Andb <admin@andrej-andb.ru>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:58:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzwj8-0007TC-8l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab3A1V6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:58:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab3A1V6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 16:58:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D61BB185;
	Mon, 28 Jan 2013 16:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G0zOcOHYghJVohqL+rFrzVIbQIw=; b=asNn6C
	6Mw7PhMXmvPA1T7N24zKcRr4+k2VUWkFm7/6V9ul6Ef7Ig1Fsc6UqOmhspbKdMbT
	tmo/Z44vWciWmSLFKI7TlFQwepgVpCbYNv2pGgRrXj8SaAxhxZYSpVPIcV7Ri6hi
	y9er47V+Bk8YgymfpFknBmH5Q95KS4AQUpjWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CckHLhU7NUg4yxsV0JlXh8tBtgbgo+Ww
	MIfm0XpOGlRTJXe9Ghcqwz/+vt02dTrszV6h1bfDpIGcXE9KL8e9nGXs1+O7Qa1y
	JyC1+CCOXLyyzQ20GV7uKnaV37MPY7BgAXvI+Jscb3B8KhcEd09o9feQlqlnvNL+
	cmcFrYWhiwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42033B184;
	Mon, 28 Jan 2013 16:58:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7A0EB183; Mon, 28 Jan 2013
 16:58:30 -0500 (EST)
In-Reply-To: <7vfw1lug6f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Jan 2013 13:54:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA462284-6995-11E2-8490-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214879>

Junio C Hamano <gitster@pobox.com> writes:

>>> -			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>>> +			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>
> Hrmph.  Is that even a valid URL to refer to that external site from
> a https://my.site/some/where/ base URL?  I wouldn't be surprised if
> browsers allowed it, but I do not recall seeing such a use in RFCs.

ah, nevermind.  That's net_path in 1808.
