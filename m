From: Junio C Hamano <gitster@pobox.com>
Subject: Re: email address handling
Date: Fri, 01 Aug 2008 13:00:16 -0700
Message-ID: <7viquksdyn.fsf@gitster.siamese.dyndns.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
 <20080801124550.26b9efc0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0ob-0007bq-Ov
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYHAUAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYHAUAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:00:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbYHAUAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:00:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B39AE46085;
	Fri,  1 Aug 2008 16:00:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BBEE446083; Fri,  1 Aug 2008 16:00:18 -0400 (EDT)
In-Reply-To: <20080801124550.26b9efc0.akpm@linux-foundation.org> (Andrew
 Morton's message of "Fri, 1 Aug 2008 12:45:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7999A356-6004-11DD-BEA0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91083>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 1 Aug 2008 12:34:58 -0700 (PDT)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> And Andrew, this is true of Signed-off-by: lines too, btw. If you actually 
>> want to send emails to them, _then_ you need to add quotes to follow the 
>> email rules. 
>
> That's how I noticed it - copied, pasted, MTA barfed.
>
> Converting a usable name+email-address into an unusable one seems ... unuseful.

Name is used not just for pasting into your MUA.  For example, if your
shortlog output showed this, it would be "funny looking":

    "Zhang, Rui" (4):
            ...

    Andrew Morton (20):
            ...
            ...
