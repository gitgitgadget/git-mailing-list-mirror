From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Build error with current source release
Date: Tue, 24 Feb 2015 11:06:22 -0800
Message-ID: <xmqqvbirqgcx.fsf@gitster.dls.corp.google.com>
References: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "J. R. Westmoreland" <jr@jrw.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQKoR-0002UY-4L
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 20:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbbBXTG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 14:06:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbbBXTGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 14:06:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBB323ACF1;
	Tue, 24 Feb 2015 14:06:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1026FPUX3a2LAEqu1w2RPklEbxE=; b=PLaFqM
	4ZdVA5C2bn62fKhZQBV7gW6cN7++dbYcMeulUgCl7UR+bVTeFI6VD1GglDyCGTrR
	SXgjUt3IcLMSDiHQI323BSnxcUB/NccJyyEY4IFikez+J/M8MU6+D/qzJHkx98Dc
	/SSIRt1d/w0VhEr4cCs4EZEK9b14kJrTHV4fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bJ/m2HYUBM2tQfCfKcqbr6rahcPOW3J5
	zFKnTPx0/SRoF1qX+8BvmYfdSipdYVr7mpSjrQuaAD//w5T0xTvrFWuPjNtLgo7k
	Ix2rtKZbNHzyeIJj4C34tnUGugCn1vx5Aa+rFwCUw54Hhc4mOwCdregCjFqxSmVP
	kxlwVAPE92E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D18C83ACF0;
	Tue, 24 Feb 2015 14:06:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 562ED3ACEE;
	Tue, 24 Feb 2015 14:06:24 -0500 (EST)
In-Reply-To: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
	(J. R. Westmoreland's message of "Tue, 24 Feb 2015 07:23:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39F78666-BC58-11E4-AEC2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264339>

"J. R. Westmoreland" <jr@jrw.org> writes:

> I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> /Users/jr/Documents/projects/git/Documentation/git-add.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"

It has been long since I had to deal with a problem like this in my
set-up but it was a host configuration error that always wanted to
download these docbook DTDs by not having proper XML catalog entries
(and failing to download them, which as you can see is the error you
are getting).

Sorry, no, I do not do Macintoshes, so even if I remember exact
steps I took to fix my host configuration error several years ago on
my Debian box, I suspect that the solution would not apply to you.
