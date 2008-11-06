From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (MINGW) Resend] Windows: Make OpenSSH properly detect tty
 detachment.
Date: Thu, 06 Nov 2008 08:55:05 -0800
Message-ID: <7vvdv0iyl2.fsf@gitster.siamese.dyndns.org>
References: <200811022011.13970.angavrilov@gmail.com>
 <49129E47.4080209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 17:57:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8AQ-0007YP-Q7
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 17:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYKFQzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 11:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYKFQzq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 11:55:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYKFQzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 11:55:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E6E04798AF;
	Thu,  6 Nov 2008 11:55:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D69F3798A4; Thu,
  6 Nov 2008 11:55:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C032415E-AC23-11DD-9D6E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100245>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The latest "What's cooking in git.git" report still doesn't mention this
> patch. The reason might be ...

Sorry, my mistake.

>> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
>> Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
>> ---
>> 
>> 	This patch appears to have been overlooked,

Indeed.  It was lost in the noise because it was marked MinGW and I failed
to see your Ack.

Do people build and test MinGW port out of my 'next'?  If so, I'll queue
this on its own topic branch and have it go through the usual "cook then
graduate" cycle.  Otherwise, I'll apply this directly on top of 'master'.

Thanks.
