From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-instaweb: fix mod_perl detection for apache2
Date: Sun, 09 Aug 2009 18:38:40 -0700
Message-ID: <7vprb45ty7.fsf@alter.siamese.dyndns.org>
References: <4C22ECF8-8FBE-4E45-A7CF-EA1203B49AA7@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Aug 10 03:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaJqk-0003zd-II
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 03:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbZHJBio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 21:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbZHJBio
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 21:38:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbZHJBio (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 21:38:44 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C360243E4;
	Sun,  9 Aug 2009 21:38:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4206943E3; Sun,  9 Aug
 2009 21:38:42 -0400 (EDT)
In-Reply-To: <4C22ECF8-8FBE-4E45-A7CF-EA1203B49AA7@mailservices.uwaterloo.ca>
 (Mark A. Rada's message of "Sat\, 8 Aug 2009 18\:24\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8AA7C6B2-854E-11DE-951F-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125396>

Mark A Rada <marada@uwaterloo.ca> writes:

> The script was looking for something that matched the '^our $gitbin'
> regex, which no longer exists in gitweb.cgi.
>
> Now it looks for 'MOD_PERL', which should be on the line that checks
> to see if the script is running in a mod_perl environment.

Thanks.  That sounds like an ancient bug that in turn perhaps suggests
nobody uses instaweb.  Will apply to 'maint'..
