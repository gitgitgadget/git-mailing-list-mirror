From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prune, rm, show remote: exit with error code 1 on failure
Date: Sun, 30 Sep 2007 02:54:19 -0700
Message-ID: <7vve9sh41g.fsf@gitster.siamese.dyndns.org>
References: <ps01nxvd.fsf@blue.sea.net> <641soeuv.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Sep 30 11:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbvVT-0005Da-9X
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 11:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbXI3Jy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXI3Jy1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 05:54:27 -0400
Received: from rune.pobox.com ([208.210.124.79]:51181 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbXI3Jy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 05:54:26 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 5919C13EB9E;
	Sun, 30 Sep 2007 05:54:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DAA6A13EB8C;
	Sun, 30 Sep 2007 05:54:43 -0400 (EDT)
In-Reply-To: <641soeuv.fsf@blue.sea.net> (Jari Aalto's message of "Sun, 30 Sep
	2007 09:18:48 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59531>

Thanks.

Because this is a bugfix patch, we would want the fix applied to
'maint' to become part of 1.5.3.4, but your patch contained the
fix for "remote rm" that is not (and will not be) part of 'maint'.

I split the patch into two, applied the bits without "rm" part
to 'maint', merged the result into 'master' and applied the fix
for "rm" on 'master'.
