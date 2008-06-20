From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 01:38:03 -0700
Message-ID: <7v7icko61g.fsf@gitster.siamese.dyndns.org>
References: <20080620082034.GA24913@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jun 20 10:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9c9E-0004Mk-PJ
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 10:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYFTIiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 04:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYFTIiN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 04:38:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYFTIiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 04:38:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 657951E9F7;
	Fri, 20 Jun 2008 04:38:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8F34C1E9F5; Fri, 20 Jun 2008 04:38:06 -0400 (EDT)
In-Reply-To: <20080620082034.GA24913@elte.hu> (Ingo Molnar's message of "Fri,
 20 Jun 2008 10:20:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37485AB4-3EA4-11DD-9CD9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85607>

Ingo Molnar <mingo@elte.hu> writes:

>     a) -R is not recognized by git-diff (so i cannot just standardize 
>        myself on -R and have to waste neurons on remembering the 
>        distinction ;-)

Huh?  Have you actually tried "git diff -R"?  My copy of git 1.0.0 knows
about it.  What year are you still in ;-)?

If you apply the output of

	git diff -R HEAD^..HEAD

to your tree, you can revert the tip commit.  It is the same as

	git diff HEAD..HEAD^

If you want to write a forward diff in an obscure way, you could say

	git diff -R HEAD..HEAD^
