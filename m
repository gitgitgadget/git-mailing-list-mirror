From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Fri, 16 May 2008 17:03:40 -0700
Message-ID: <7v7idteqzn.fsf@gitster.siamese.dyndns.org>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <djpig@debian.org>
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sat May 17 02:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx9vo-0003us-BT
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759773AbYEQAD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 20:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759765AbYEQAD6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 20:03:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759531AbYEQADz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 20:03:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 218045681;
	Fri, 16 May 2008 20:03:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F1A73567F; Fri, 16 May 2008 20:03:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCDDEBD2-23A4-11DD-AF30-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82323>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> This series of patches extends git-cvsserver to support telling the
> CVS client to set the -kb (binary) mode for files that git considers
> to be binary (and not for text files).  It includes updates to
> documentation and tests.

I am unfortunately not familiar with this part of the system and I'd need
to summon help from experts, but it looks rather nicely done.

I saw a few places that said "crnl" instead of "crlf" in the
documentation, which I munged locally before queuing.

I noticed kopts_from_path in patch 3/3 takes $srcType of "sha1Or-k" but I
could not spot which caller gives such token to the function.
