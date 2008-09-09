From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitignore patterns
Date: Tue, 09 Sep 2008 16:25:48 -0700
Message-ID: <7vprnc3nr7.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0809091521120.15561@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCbt-0003Ul-FA
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYIIXZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYIIXZz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:25:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbYIIXZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:25:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 789F75C58D;
	Tue,  9 Sep 2008 19:25:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D57965C58C; Tue,  9 Sep 2008 19:25:50 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0809091521120.15561@shark.he.net> (Randy Dunlap's
 message of "Tue, 9 Sep 2008 15:23:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A569D844-7EC6-11DD-8780-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95459>

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> In the kernel tree, I see 2 .gitignore files that use "+pattern":
>
> ./arch/blackfin/include/asm/.gitignore:+mach
> ./arch/blackfin/boot/.gitignore:+vmImage
>
> However, I can't find anything about '+' on the gitignore(5) man page
> at http://www.kernel.org/pub/software/scm/git/docs/gitignore.html .
>
> Does the '+' mean something special or is it just a character in the
> filename/dir pattern?

AFAIR, this should be just a shell glob fnmatch(3) understands, so perhaps
their build procedure leaves temporary droppings in a file whose filename
is prefixed with './+'?
