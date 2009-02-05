From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] Add log.mailmap as configurational option for
 mailmap location
Date: Thu, 05 Feb 2009 12:22:22 -0800
Message-ID: <7v63jod475.fsf@gitster.siamese.dyndns.org>
References: <cover.1233819451.git.marius@trolltech.com>
 <cover.1233819451.git.marius@trolltech.com>
 <565c86bdbc8d6303d7d468fa196fb54ff7bd2352.1233819451.git.marius@trolltech.com> <7vljskeq21.fsf@gitster.siamese.dyndns.org> <498B3F24.6080305@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAlQ-0006gU-Aj
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbZBEUWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756083AbZBEUWa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:22:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbZBEUW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:22:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9777B2A81B;
	Thu,  5 Feb 2009 15:22:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BDFE52A818; Thu, 
 5 Feb 2009 15:22:24 -0500 (EST)
In-Reply-To: <498B3F24.6080305@trolltech.com> (Marius Storm-Olsen's message
 of "Thu, 05 Feb 2009 20:33:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4EE84B0-F3C2-11DD-947A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108609>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Given that in total shortlog, blame, log, diff-tree, rev-list, show
> and whatchanged use it (the latter 5 through the pretty option), I'm
> tempted to say that it justifies its own option (mailmap.file?); but
> it would still have to be handled by git_default_config(). Renaming it
> would give it stronger reason to *be there* though.

We are in total agreement then ;-)

I also agree that it would be a good idea to introduce a shared
documentlet similar to pretty-format.txt that can be included in the
documentation pages of commands that use this name-rewriting mechanism.
