From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add Pascal/Delphi (.pas file) funcname pattern.
Date: Fri, 01 Aug 2008 13:16:59 -0700
Message-ID: <7v8wvgsd6s.fsf@gitster.siamese.dyndns.org>
References: <1217619915-9331-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <gitster@pobox.com>, <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP14k-0007DH-Ch
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbYHAURJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYHAURI
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:17:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbYHAURH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:17:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C80B4626D;
	Fri,  1 Aug 2008 16:17:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EF10E4626C; Fri,  1 Aug 2008 16:17:01 -0400 (EDT)
In-Reply-To: <1217619915-9331-1-git-send-email-apenwarr@gmail.com> (Avery
 Pennarun's message of "Fri, 1 Aug 2008 15:45:15 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CFEFF140-6006-11DD-B6B8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91088>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Finds classes, records, functions, procedures, and sections.  Most lines
> need to start at the first column, or else there's no way to differentiate
> a procedure's definition from its declaration.
>
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
> ---
>
> The Ruby funcname pattern patch inspired me.  Although unlike him, I didn't
> check with anyone else for confirmation.  How many Pascal programmers can
> there possibly be? :)

> +	{ "pas", "\\(^\\(procedure\\|function\\|constructor\\|"
> +			"destructor\\|interface\\|implementation\\|"
> +			"type|initialization|finalization\\).*$\\)"
> +			"\\|\\(^.*=[ \t]*\\(class\\|record\\).*$\\)" },

Is Delphi the only surviving Pascal?  Why is the name "pas", not "pascal"
or even "delphi-pascal"?

The keys are not file extensions ("ruby" example did the right thing by
not saying "rb").
