From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 16:56:49 -0700
Message-ID: <7vbq2qrni6.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
 <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
 <7v3ao2tawd.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
 <20080528223858.GA15107@sigill.intra.peff.net>
 <20080528224819.GA15252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Irving <irving@naml.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 29 01:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VX7-00083P-Vb
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYE1X5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYE1X47
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:56:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYE1X47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:56:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF92E390A;
	Wed, 28 May 2008 19:56:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E5DBE3908; Wed, 28 May 2008 19:56:51 -0400 (EDT)
In-Reply-To: <20080528224819.GA15252@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 May 2008 18:48:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C119D582-2D11-11DD-AA92-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83151>

Jeff King <peff@peff.net> writes:

> doc/git-gui: make gitk "see also" a link
>
> Even though git-gui and gitk are both maintained separately,
> the documentation is part of core git, and thus it makes
> sense to use the linkgit macro to create an href in the HTML
> documentation.
> ---
>  Documentation/git-gui.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
> index 6d6cd5d..cf2541f 100644
> --- a/Documentation/git-gui.txt
> +++ b/Documentation/git-gui.txt
> @@ -81,7 +81,7 @@ git gui browser maint::
>  
>  See Also
>  --------
> -'gitk(1)'::
> +linkgit:gitk[1]::
>  	The git repository browser.  Shows branches, commit history
>  	and file differences.  gitk is the utility started by
>  	git-gui's Repository Visualize actions.

Hmm.

First a bit offtopic to avoid duplicated work.  Please nobody waste your
time sending s/See Also/SEE ALSO/ clean-up patch.  I've done that already.

Now, I do not think it is customary to say anything but the name of the
manual page if you refer to one in SEE ALSO section.  I am wondering if we
would want to remove the three-liner for consistency (but haven't done so,
neither the short description of qgit and others in gitk manual page is
gone yet).

 Documentation/git-gui.txt |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 6d6cd5d..cea8f8a 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -79,12 +79,9 @@ git gui browser maint::
 	selected in the browser can be viewed with the internal
 	blame viewer.
 
-See Also
+SEE ALSO
 --------
-'gitk(1)'::
-	The git repository browser.  Shows branches, commit history
-	and file differences.  gitk is the utility started by
-	git-gui's Repository Visualize actions.
+linkgit:gitk[1]
 
 Other
 -----
