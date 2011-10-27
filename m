From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb/Makefile: Remove static/gitweb.js in the clean
 target
Date: Thu, 27 Oct 2011 10:49:29 -0700
Message-ID: <7vk47qz5na.fsf@alter.siamese.dyndns.org>
References: <4EA6EEA8.3000204@ramsay1.demon.co.uk>
 <1319583484.10399.41.camel@drew-northup.unet.maine.edu>
 <201110260236.59509.jnareb@gmail.com> <4EA87C06.8080808@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJU5B-0006n1-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab1J0Rtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:49:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab1J0Rtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:49:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 822AB51D2;
	Thu, 27 Oct 2011 13:49:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3SUaDTyqc7o3VOG5XmiV4Yz98YA=; b=jHJvph
	C+CkGxe6l0P/tvlBLm9ZAcZsPd1gcIoycagfaxJaYeSDg4LMNEHFnL9ug+DjuPpK
	u6KNM273Ps+CYGHSAi5jSd3Zr3czUZ8oEZnd+2Hgj2CpXU6lLrI91mO2N45ZRXjr
	UluUcv4y74azshcy6XCpHFtjXTZbf8vrp3l7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qu4uaB1xTDUFiO2617nCK6+9KxURNp8n
	JYBMrMPWlveL82yv/9DlzRSfWKePpeWXDmqA2Jk2d9/Z93BNEnt3iFMFWHsuYhEw
	AY45UxA3wl0JTeW4W/iaB7F8KEmWBkrpduukXABqtwyW/zywdAkm/L09jveNMMib
	xWzonO3+CJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7946851D1;
	Thu, 27 Oct 2011 13:49:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 068B351D0; Thu, 27 Oct 2011
 13:49:30 -0400 (EDT)
In-Reply-To: <4EA87C06.8080808@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 26 Oct 2011 22:30:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05E61E80-00C4-11E1-92E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184309>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> gitweb.js is nowadays a generated file.  Though that bit should be
>> in commit message...
>
> Yep, will do ...

Thanks; here is what I already queued.

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Tue, 25 Oct 2011 18:15:20 +0100
Subject: [PATCH] gitweb/Makefile: Remove static/gitweb.js in the clean target

Since 9a86dd5 (gitweb: Split JavaScript for maintability, combining on
build, 2011-04-28), static/gitweb.js has been a build product that should
be cleaned upon "make clean".

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 5d20515..c360284 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -183,7 +183,9 @@ install: all
 ### Cleaning rules
 
 clean:
-	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
+	$(RM) gitweb.cgi static/gitweb.js \
+		static/gitweb.min.js static/gitweb.min.css \
+		GITWEB-BUILD-OPTIONS
 
 .PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
 
-- 
1.7.7.1.552.g2c3d8
