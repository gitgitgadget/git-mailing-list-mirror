From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the git metapackage require the same version of the subpackages.
Date: Sun, 06 Jan 2008 12:24:49 -0800
Message-ID: <7vprwe4s8e.fsf@gitster.siamese.dyndns.org>
References: <20080106173501.GB9349@spitfire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBc3j-0004EC-Q7
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 21:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYAFUZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 15:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbYAFUZA
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 15:25:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYAFUY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 15:24:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A9EB88BEA;
	Sun,  6 Jan 2008 15:24:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F356C8BE7;
	Sun,  6 Jan 2008 15:24:52 -0500 (EST)
In-Reply-To: <20080106173501.GB9349@spitfire> (James Bowes's message of "Sun,
	6 Jan 2008 12:35:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69743>

James Bowes <jbowes@dangerouslyinc.com> writes:

> Without explicit version deps in the rpm spec file, 'yum update git'
> effectively does nothing. Require explicit versions of the subpackages, so that
> they get pulled in on an update.
>
> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>

I am asking as an RPM illiterate, not questioning the validity
of what your patch does.

The approach your patch takes feels like the right way we should
have taken from the beginning.  Does this supersede the "fix" in
5587cac28be66acf5edc2a4b83b67c8cfffbc5e9 (GIT 1.5.3.1: obsolete
git-p4 in RPM spec file)?  IOW, if we had Requires for the same
version from the beginning, we wouldn't have had the problem
when we dropped git-p4 package?
