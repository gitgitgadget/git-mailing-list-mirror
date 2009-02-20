From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/3] git checkout optimisation - part 3
Date: Fri, 20 Feb 2009 00:35:26 -0800
Message-ID: <7vfxi9fqup.fsf@gitster.siamese.dyndns.org>
References: <cover.1235071656.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQsa-0006ao-Ip
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZBTIfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbZBTIfg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:35:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZBTIfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:35:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 24B929B38C;
	Fri, 20 Feb 2009 03:35:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C99F29B38B; Fri,
 20 Feb 2009 03:35:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 715741CA-FF29-11DD-A919-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110817>

Kjetil Barvik <barvik@broadpark.no> writes:

> Changes sine v1 
> (v1 was posted with subject "The ext4 filesystem and racy git")
>
>
> -- patch 2/3 --
>    Added missing timestamp => timestamp.(u)sec update for
>    unpack-trees.c
>
> -- patch 3/3 --
>    New patch which removes some 14300 lstat(2) calls, and the total is
>    now at 41677 calls, or 1.382 calls/unique string to lstat() for the
>    reference 'git checkout'-test to Linux tag v2.6.27.
>
>    Total reduction so far for all the lstat/git checkout optimisation
>    patches has been 120954 - 41677 = 79277 calls.  Some 14400 fstat(2)
>    calls is added, but those should be faster than simmilar lstat()
>    calls.
>
> (patch-series based on master)

Hmm, have you noticed that the rest of the stuff are queued on 'next'?
Not that it matters in this case...
