From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Wed, 31 Oct 2007 18:12:17 -0700
Message-ID: <7vlk9ig45q.fsf@gitster.siamese.dyndns.org>
References: <1193861145-20357-1-git-send-email-mh@glandium.org>
	<alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InObx-0003vp-N3
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 02:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103AbXKABMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 21:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758023AbXKABMY
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 21:12:24 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:43558 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbXKABMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 21:12:23 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3C7692F0;
	Wed, 31 Oct 2007 21:12:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BE15F90DD8;
	Wed, 31 Oct 2007 21:12:40 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 31 Oct 2007 17:46:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62904>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 31 Oct 2007, Mike Hommey wrote:
>> +	if type cpio > /dev/null 2>&1; then
>> +		local=yes
>> +	fi
>
> Isn't "type" a bashism?

I seem to recall that it is in POSIX.
