From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git compile error on AIX
Date: Fri, 14 Nov 2008 12:21:37 -0800
Message-ID: <7v1vxe9hym.fsf@gitster.siamese.dyndns.org>
References: <1226691918584-1499908.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dinakar <desas2@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L15Cm-0001UC-Q5
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 21:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYKNUWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYKNUWW
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 15:22:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYKNUWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 15:22:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49AA37D2DE;
	Fri, 14 Nov 2008 15:22:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BB9897D2C1; Fri,
 14 Nov 2008 15:21:44 -0500 (EST)
In-Reply-To: <1226691918584-1499908.post@n2.nabble.com> (desas2@gmail.com's
 message of "Fri, 14 Nov 2008 11:45:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F04E06AE-B289-11DD-B650-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101014>

Dinakar <desas2@gmail.com> writes:

> /usr/bin/getopt: Not a recognized flag: d
> Usage: install [-c DirectoryA] [-f DirectoryB] [-i] [-m] [-M Mode] [-O
> Owner]
>                [-G Group] [-S] [-n DirectoryC] [-o] [-s] File [DirectoryX
> ...]

Your "install" program is telling you that it does not understand 'd'
option ("install -d" to create a directory, I presume).

> gmake[1]: *** [boilerplates.made] Error 2
> gmake: *** [all] Error 2

> I would appreciate, if you could help me to resolve this issue.

An obvious solution would be to get a better install.

You seem to be using gmake, so perhaps you already have ginstall and can
use it like "gmake INSTALL=ginstall"?
