From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking for today
Date: Tue, 08 Apr 2014 14:10:38 -0700
Message-ID: <xmqqr45734tt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 23:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXdI7-0005xu-4E
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbaDHVKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 17:10:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757276AbaDHVKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 17:10:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E1FF7BDA6;
	Tue,  8 Apr 2014 17:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	CIDv17olDaFQWYKGLWbzKWEeuU=; b=funlBWZxeG1EQwP0tcgNcy3bQfx0DB/Bi
	etEOvWfduYq7I9rr1JUnsvZmPUQitwlSIW1b/jTlhYzq5QNZlk9RveZJoaJGncMX
	NbMmj1GD4XEv9iv8BAvNU+ro+R3zSAlYOcXKCDjU2Y/YL7/7OsF6U5+uFWeXTWYT
	P+12zV4o7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=UH3
	Y5ZEKFtQtZXrofpFcQMT+wjk/Zlxy4zqXXFwQruSXD2/uPZVqf/S3b2OmcqQve82
	VGIfaBCG6kJ1uRGjXvRCIoNRX5Pn4LENi7MEQ8+4ekShguZXF1gR3hIbrOcAGFXj
	LtZHrpcGbugtwJ8gc3j0GxkdElR8ve/9GMKC1Tpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 296687BDA5;
	Tue,  8 Apr 2014 17:10:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BFC07BDA3;
	Tue,  8 Apr 2014 17:10:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3CEF42EE-BF62-11E3-9D37-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245957>

As I do not want to send the full "what's cooking" report back to
back, here is just a highlight of updates.

A handful of topics are now in 'master', including:

 - Fix for mis-used "nor", by Justin Lebar.

 - MSVC port fixes, by Marat Radchenko.

 - Portability fixes for gmtime sanity checking, by Peff.

Also a few topics are now in 'next', expected to be kept there for
the rest of this cycle, including:

 - Compute the patch-id in a way that is stable with use of "git
   diff -O<order>", which is unfortunately backward incompatible, by
   Michael S. Tsirkin.

 - Update the internal of "diff-tree" so that it can be used to
   compare N trees (not just 2), and use it to optimize "diff
   -c/--cc", by Kirill Smelkov.

I am also hoping that a few other topics can join 'next' to be
cooked for the rest of this cycle, including:

 - "Ref-transaction" series by Michael.

 - "Interpret-Trailers" series by Christian.

Thanks.
