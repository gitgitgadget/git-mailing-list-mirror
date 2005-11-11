From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-core-arch: Missing dependency
Date: Fri, 11 Nov 2005 09:33:12 -0800
Message-ID: <7vy83vnl7r.fsf@assigned-by-dhcp.cox.net>
References: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 18:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eacm5-00021U-2Q
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 18:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVKKRdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 12:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKKRdO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 12:33:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51844 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750933AbVKKRdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 12:33:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111173215.OVEF11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 12:32:15 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl> (Horst von
	Brand's message of "Fri, 11 Nov 2005 11:46:06 -0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11620>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> The command git-archimport makes use of tla, but the relevant package(s) are
> not on the requirements

Thanks.  Should the fix be like this?

-- >8 --
Subject: RPM: arch submodule needs tla.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-core.spec.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 76d3d1c302c20b82fd976e958aabd19f7f01e7b5
a12a9bcce8347f5e5349b05fcd65629e6846a854
diff --git a/git-core.spec.in b/git-core.spec.in
index cf7e942..6a482ad 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -36,7 +36,7 @@ Git tools for importing CVS repositories
 %package arch
 Summary:        Git tools for importing Arch repositories
 Group:          Development/Tools
-Requires:       git-core = %{version}-%{release}
+Requires:       git-core = %{version}-%{release}, tla
 %description arch
 Git tools for importing Arch repositories.
 
---
0.99.9.GIT
