From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 1/2] contrib/hooks: adapt comment about Debian install
	location for contrib hooks
Date: Mon, 26 Sep 2011 12:58:35 +0000
Message-ID: <20110926125835.26573.qmail@06368f96dac286.315fe32.mid.smarden.org>
References: <20110920111914.17913.qmail@d29ca435be5a3d.315fe32.mid.smarden.org> <7vr53b578t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 14:58:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Alk-00072E-Or
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 14:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab1IZM6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 08:58:38 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:56112 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751595Ab1IZM6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 08:58:37 -0400
Received: (qmail 26574 invoked by uid 1000); 26 Sep 2011 12:58:35 -0000
Content-Disposition: inline
In-Reply-To: <7vr53b578t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182107>

Placing the contrib hooks into /usr/share/doc/ wasn't a good idea in the
first place.  According to the Debian policy they should be located in
/usr/share/git-core/, so let's put them there.

Thanks to Bill Allombert for reporting this through
 http://bugs.debian.org/640949

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Tue, Sep 20, 2011 at 12:44:18PM -0700, Junio C Hamano wrote:
> > --- a/contrib/hooks/post-receive-email
> > +++ b/contrib/hooks/post-receive-email
> > @@ -11,11 +11,11 @@
> >  # will have put this somewhere standard.  You should make this
> >  script
> >  # executable then link to it in the repository you would like to
> >  use it in.
> >  # For example, on debian the hook is stored in
> > -# /usr/share/doc/git-core/contrib/hooks/post-receive-email:
> > +# /usr/share/git-core/contrib/hooks/post-receive-email:
> >  #
> >  #  chmod a+x post-receive-email
> >  #  cd /path/to/your/repository.git
> > -#  ln -sf /usr/share/doc/git-core/contrib/hooks/post-receive-email
> > hooks/post-receive
> > +#  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email
> > hooks/post-receive
>
> This one I do not have any problem with; the leading text makes it
> very
> clear that this is an example that is specific to Debian and that is
> good enough to signal readers that they may have to look elsewhere if
> they
> are on a different distribution.
>

Ok, thanks.  I stripped this patch to just touch this file.

Regards, Gerrit.

 contrib/hooks/post-receive-email |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index fa6d41a..ba077c1 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -11,11 +11,11 @@
 # will have put this somewhere standard.  You should make this script
 # executable then link to it in the repository you would like to use it in.
 # For example, on debian the hook is stored in
-# /usr/share/doc/git-core/contrib/hooks/post-receive-email:
+# /usr/share/git-core/contrib/hooks/post-receive-email:
 #
 #  chmod a+x post-receive-email
 #  cd /path/to/your/repository.git
-#  ln -sf /usr/share/doc/git-core/contrib/hooks/post-receive-email hooks/post-receive
+#  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive
 #
 # This hook script assumes it is enabled on the central repository of a
 # project, with all users pushing only to it and not between each other.  It
-- 
1.7.6.3
