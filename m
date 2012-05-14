From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] link to gitmodules page at the beginning of git-submodule
	documentation
Date: Mon, 14 May 2012 19:32:08 +0200
Message-ID: <20120514173207.GC58058@book.hvoigt.net>
References: <20120510185903.GF76400@book.hvoigt.net> <A406C457BFB948FC9843C8F53AD82CDE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon May 14 19:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STz85-00014S-J9
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab2ENRcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 13:32:13 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40233 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757209Ab2ENRcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 13:32:12 -0400
Received: (qmail 2825 invoked from network); 14 May 2012 17:32:08 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 14 May 2012 17:32:08 -0000
Content-Disposition: inline
In-Reply-To: <A406C457BFB948FC9843C8F53AD82CDE@PhilipOakley>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197789>

This way the user does not have to scroll down to the bottom to find
it.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Thu, May 10, 2012 at 09:30:12PM +0100, Philip Oakley wrote:
> From: "Heiko Voigt" <hvoigt@hvoigt.net> Sent: Thursday, May 10, 2012 7:59 PM
>> This option was not yet described in the gitmodules documentation. We
>> only described it in the 'git submodule' command documentation but
>> gitmodules is the more natural place to look.
>
> The gitmodules documentation is only more natural if we tell (link) the 
> reader early in the submodule documentation. A link to gitmodules should 
> be provided in the third paragraph of Description where the .gitmodules 
> is introduced.
>
> Currently the gitmodules link is the last thing mentioned (i.e. 8 PgDn's for me).

The gitmodules documentation page describes all the options you can use
there so its by definition more natural. Yes I can see that a link to
gitmodules page could be provided earlier but thats a completely
different topic independent from my previous patch. Instead of
complaining how about providing a patch next time?

Anyway here we go...

 Documentation/git-submodule.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c83a856..9e488c0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -43,9 +43,9 @@ if you choose to go that route.
 Submodules are composed from a so-called `gitlink` tree entry
 in the main repository that refers to a particular commit object
 within the inner repository that is completely separate.
-A record in the `.gitmodules` file at the root of the source
-tree assigns a logical name to the submodule and describes
-the default URL the submodule shall be cloned from.
+A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
+root of the source tree assigns a logical name to the submodule and
+describes the default URL the submodule shall be cloned from.
 The logical name can be used for overriding this URL within your
 local repository configuration (see 'submodule init').
 
-- 
1.7.10.1.488.ga84c0c8
