From: Junio C Hamano <gitster@pobox.com>
Subject: Re: * [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 05 Dec 2007 18:14:57 -0800
Message-ID: <7vbq94in6m.fsf@gitster.siamese.dyndns.org>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com>
	<7veje1zibm.fsf@gitster.siamese.dyndns.org>
	<20071205152816.GA21347@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 03:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J06IC-0007uf-Lp
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 03:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbXLFCPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 21:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbXLFCPH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 21:15:07 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55198 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650AbXLFCPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 21:15:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 794E12F2;
	Wed,  5 Dec 2007 21:15:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E26109D68A;
	Wed,  5 Dec 2007 21:15:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67220>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> Before the rewrite in C git clean would refuse to remove a directory if
> you said:
>
>    git clean dir
>
> without using the -d parameter.  Per your suggestion this check causes
> git clean to remove the directory anyway since you explicitly asked it
> to.

Thanks for reminding me of that issue.
