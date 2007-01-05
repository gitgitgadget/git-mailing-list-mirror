From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [1/2 PATCH] git-svn: make multi-init less confusing
Date: Fri, 05 Jan 2007 07:37:09 +0100
Message-ID: <871wmaugh6.fsf@morpheus.local>
References: <87fyaqvgoz.fsf@morpheus.local>
	<20070105020158.GA21925@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 08:09:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2jCY-0005EQ-AJ
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 08:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbXAEHJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 02:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbXAEHJN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 02:09:13 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:59056 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030352AbXAEHJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 02:09:13 -0500
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 02:09:12 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 74D60200A1E7;
	Fri,  5 Jan 2007 07:37:12 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06339-01-33; Fri, 5 Jan 2007 07:37:11 +0100 (CET)
Received: from morpheus (c83-253-22-207.bredband.comhem.se [83.253.22.207])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 9094E200A1E1;
	Fri,  5 Jan 2007 07:37:11 +0100 (CET)
Received: by morpheus (Postfix, from userid 1000)
	id D8AF9BFBF7; Fri,  5 Jan 2007 07:37:09 +0100 (CET)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20070105020158.GA21925@localdomain> (Eric Wong's message of "Thu, 4 Jan 2007 18:02:00 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35979>

Eric Wong <normalperson@yhbt.net> writes:

> It now requires at least one of the (trunk|branch|tags) arguments
> (either from the command-line or in .git/config).  Also we make
> sure that anything that is passed as a URL ('help') in David's
> case is actually a URL.

If I understand correctly, this still allows you to write

  $ git svn svn://foo/bar multi-init

which is kindof confusing.  But I guess it's less likely that anyone
does it by mistake.

Thanks for the quick response, anyway.  The documentation patch is
also a great improvement.

Now if you could only clarify the documentation of dcommit to explain
whether it creates one svn revision per commit in your branch, or if
it creates a single svn revision with the full diff, and the
documentation would be perfect :-)

--=20
David K=C3=A5gedal
