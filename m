From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git send-email: add --annotate option
Date: Sat, 01 Nov 2008 23:23:55 -0700
Message-ID: <7vskqa3atg.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225450632-7230-2-git-send-email-madcoder@debian.org>
 <1225450632-7230-3-git-send-email-madcoder@debian.org>
 <1225450632-7230-4-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 07:26:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwWPe-0007jr-G8
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 07:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYKBGYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 01:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYKBGYJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 01:24:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbYKBGYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 01:24:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66EDB77C4E;
	Sun,  2 Nov 2008 01:24:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5110077C4D; Sun,  2 Nov 2008 01:24:02 -0500 (EST)
In-Reply-To: <1225450632-7230-4-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Fri, 31 Oct 2008 11:57:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA746108-A8A6-11DD-B15D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99818>

Pierre Habouzit <madcoder@debian.org> writes:

> This allows to review every patch (and fix various aspects of them, or
> comment them) in an editor just before being sent. Combined to the fact
> that git send-email can now process revision lists, this makes git
> send-email and efficient way to review and send patches interactively.

Without your patches, you run format-patch (with or without cover), you
use the editor of your choice to massage them and feed the resulting files
to send-email.

Only because you wanted to allow format-patch parameters to be given to
send-email, you now need to also allow the messages to be massaged before
they are sent out.

Is it only me who finds that this series creates its own problem and then
has to solve it?  What are we getting in return?
