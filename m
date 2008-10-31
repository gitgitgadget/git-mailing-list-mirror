From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 13:10:06 -0700
Message-ID: <7vbpx08r1d.fsf@gitster.siamese.dyndns.org>
References: <200810312050.31167.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:11:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0LG-0002rI-I6
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbYJaUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbYJaUKU
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:10:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYJaUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:10:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D1FF477429;
	Fri, 31 Oct 2008 16:10:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 17C1A77425; Fri, 31 Oct 2008 16:10:13 -0400 (EDT)
In-Reply-To: <200810312050.31167.fg@one2team.net> (Francis Galiegue's message
 of "Fri, 31 Oct 2008 20:50:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0823378-A787-11DD-9E0F-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99633>

Francis Galiegue <fg@one2team.net> writes:

> Unless I'm mistaken (and I probably am), the $(...) construct is 
> bash-specific, isn't it?

You are.
