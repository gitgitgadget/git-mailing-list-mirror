From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page (web version)
Date: Mon, 13 Jan 2014 09:55:58 -0800
Message-ID: <xmqq8uuj7olt.fsf@gitster.dls.corp.google.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
	<xmqqwqk37kdy.fsf@gitster.dls.corp.google.com>
	<CAEjxke-fPwTctUt9x_o1YwTKK2fX5TOPA7LStXUh+ejUVxZtpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Mon Jan 13 18:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2lkI-0003xf-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 18:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbaAMR4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 12:56:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbaAMR4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 12:56:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F0CC6138C;
	Mon, 13 Jan 2014 12:56:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r6ycgsdRSiTrfUMlJGl9qYURNx0=; b=nS/tuK
	gpnYhDV0j6oP84v/NnfM5Hq3z+H1+qvp6ij4iOaP5BgUbN5i/5EQh8nDPIh7t8+w
	w6C9E6adj6rNLC8pQc6jIgzqKInVOfY4FLgYykHmTNZxmuchXU4LUMCDxGQd2Bwz
	izOSwBa71NpoVdMOYfIG291KLTHX/OhDX8HgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nNsfgDNLvZeCYM1FE71LdQMbdSg1VT11
	kaT7SXb59LhO3pv2AoFkNYIg4ICpMfAfxEPggpD3eN7fPGqX2UsAN+CzzxF6mgJs
	DTp9681JKQBxfiMUVHdr+khCYEuGn3qL7Dm7he6MTGXHjwHD11m2Ynki6APNVmG5
	lJNuCkiRsm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DD686138B;
	Mon, 13 Jan 2014 12:56:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DB0E61384;
	Mon, 13 Jan 2014 12:56:07 -0500 (EST)
In-Reply-To: <CAEjxke-fPwTctUt9x_o1YwTKK2fX5TOPA7LStXUh+ejUVxZtpg@mail.gmail.com>
	(Jason St. John's message of "Fri, 10 Jan 2014 20:25:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA54DBE8-7C7B-11E3-8878-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240364>

"Jason St. John" <jstjohn@purdue.edu> writes:

> What AsciiDoc formatter (and version) do you use?

    $ asciidoc --version
    asciidoc 8.6.8

Checking with www.methods.co.nz/asciidoc, I am behind by about 2
months, it seems, though.
