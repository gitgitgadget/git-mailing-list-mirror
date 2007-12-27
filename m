From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Point out merged submodule maintainers as better addresses for patches
Date: Wed, 26 Dec 2007 20:37:18 -0800
Message-ID: <7v1w98kb29.fsf@gitster.siamese.dyndns.org>
References: <20071227041220.GA22256@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 05:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7kVN-0007hR-3E
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 05:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXL0Ehd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 23:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbXL0Ehd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 23:37:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbXL0Ehc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 23:37:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BDD9B540;
	Wed, 26 Dec 2007 23:37:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B07C8B53F;
	Wed, 26 Dec 2007 23:37:25 -0500 (EST)
In-Reply-To: <20071227041220.GA22256@spearce.org> (Shawn O. Pearce's message
	of "Wed, 26 Dec 2007 23:12:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69258>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio doesn't directly manage the git-gui or gitk-git subdirectories
> within git.git; these are currently managed by other individuals
> and then periodically merged to git.git.  Users often send patches
> to Junio for these directories when they should be directed at the
> current maintainer instead, so we should point out these special
> cases in the SubmittingPatches documentation.

This is a good start, but I think it would be good to mention
that contributors should at least Cc: the people who have been
heavily involved in the past in the surrounding area of the code
or documentation (not necessarily the last person who touched
the area) the patch attempts to improve and/or enhance.

Parts of the system are "actively managed" by people other than
me even though they aren't merged with the subtree strategy.
The areas I mentioned in MaintNotes (in 'todo') are:

 - git-svn is generally deferred to Eric, unless the patch is
   truly trivial.

 - Documentation/user-manual.txt is primarily JBF's bailiwick.

 - Nico is the guy around pack generation.

 - Jakub, Luben and Pasky are more familiar than I am with
   gitweb.

In fact, I would rather see any nontrivial patch to be first
sent "To: " such people with "Cc: " the list.  After it has been
improved into a good enough shape in the discussion that follows
(i.e. success stories to back it up, and without regression
reports and objections), I can pick up the last round directly
from the list, or the active maintainer in the area (if exists;
it might be a better wording to call them "subsystem
maintainers") can forward it to me to apply after a final
submission is made.  Sending the final submission to the
subsystem maintainer who forwards it to the higher level is what
the kernel folks regularly do, but I do not think we are large
enough to require such a formality.
