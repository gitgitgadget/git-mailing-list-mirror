From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v2] git-svn log: handle unreachable revisions like "svn log"
Date: Sat, 17 Nov 2007 16:36:45 -0800
Message-ID: <7vy7cwz8wy.fsf@gitster.siamese.dyndns.org>
References: <1194761435-7286-4-git-send-email-ddkilzer@kilzer.net>
	<1194850612-6907-1-git-send-email-ddkilzer@kilzer.net>
	<20071117214738.GB22835@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David D Kilzer <ddkilzer@kilzer.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:37:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItY9v-0002Bz-Tp
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 01:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbXKRAgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbXKRAgx
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 19:36:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36525 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbXKRAgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 19:36:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BC2BC2EF;
	Sat, 17 Nov 2007 19:37:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A04A96ECF;
	Sat, 17 Nov 2007 19:37:09 -0500 (EST)
In-Reply-To: <20071117214738.GB22835@soma> (Eric Wong's message of "Sat, 17
	Nov 2007 13:47:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65326>

Eric Wong <normalperson@yhbt.net> writes:

> Acked and pushed out to http://git.bogomips.org/git-svn.git

Ok, will pull to 'master' but from git://git.bogomips.org/git-svn.git/.

Thanks.

> David D Kilzer (3):
>       git-svn log: fix ascending revision ranges
>       git-svn log: include commit log for the smallest revision in a range
>       git-svn log: handle unreachable revisions like "svn log"
>
> David Reiss (1):
>       git-svn: Fix a typo and add a comma in an error message in git-svn
>
> Eric Wong (1):
>       git-svn: add tests for command-line usage of init and clone commands
>
> Konstantin V. Arkhipov (1):
>       git-svn's dcommit must use subversion's config
