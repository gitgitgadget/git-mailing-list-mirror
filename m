From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk: Failure of new tabbed preferences dialog
Date: Mon, 02 Apr 2012 15:03:54 -0700
Message-ID: <7vzkatdc51.fsf@alter.siamese.dyndns.org>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
 <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
 <7vty12gl8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	<git@vger.kernel.org>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 00:04:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEpM1-00008r-T6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 00:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab2DBWD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 18:03:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2DBWD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 18:03:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DD6635A;
	Mon,  2 Apr 2012 18:03:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qPY/8TlIT4iBXhDZt7hCJWQAtiw=; b=ngs1lQ
	JSmpwA7hbMGD5CmakYATWyKd3ENqCGHOudjBVKFtVacXR+l42yIvBgL00yldOYaE
	VDdC0ED5Q+IC3jP4xd9tmOjkNOLDNQ1EUwvFP+b6djku0J59MFBRcrQCp4QXEZcP
	XzLmTEnNqX3Hs8HkS1f1Ihx67ccpn+6K7uvtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xslO/trDTsb7aHB8Pt5UWiuLYvbmFbtf
	oP+V8zMIb8EuW1Dy/7mN6zO38lwvs3krNaDishSS7SD5niO0Fv/vZ6ndyF8z8HYg
	UB/G1S0vPqaFmxzXn58am1mwUp5b3ijrfsgENcW9ccTlL9RCn/uNXNH2z903DbGg
	HalrNmc3dkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 196C36359;
	Mon,  2 Apr 2012 18:03:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D73B6357; Mon,  2 Apr 2012
 18:03:55 -0400 (EDT)
In-Reply-To: <7vty12gl8r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Apr 2012 09:19:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD967634-7D0F-11E1-8DEC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194569>

Paul, Ramsay and Pat noticed and fixed two buglets that made the "Font"
setting dialog unusable in the version in 1.7.10-rc3.  I've queued the
fixes below, tested them (before and after applying the patches) locally.

I would like to merge them and tag 1.7.10-rc4 tonight.

In order to keep us in sync, could you please pull back from me?  The
branch "pt/gitk" corresponds to your repository (i.e. without the rest of
git.git, and gitk-git/Makefile as the top-level Makefile).

Thanks.

-- -- --

The following changes since commit b2b76d10696d945bf19318831b64d009d119e051:

  gitk: Teach gitk to respect log.showroot (2012-03-24 16:44:12 +1100)

are available in the git repository at:

  git://github.com/gitster/git.git pt/gitk

for you to fetch changes up to 39ddf99c1db8b230ec7bdefc6ce3c769d1cf4ab6:

  gitk: fix setting font display with new tabbed dialog layout. (2012-04-02 10:21:10 -0700)

----------------------------------------------------------------
Pat Thoyts (2):
      gitk: fix tabbed preferences construction when using tcl 8.4
      gitk: fix setting font display with new tabbed dialog layout.

 gitk |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 651b740..22270ce 100755
--- a/gitk
+++ b/gitk
@@ -10795,7 +10795,7 @@ proc fontok {} {
     if {$fontparam(slant) eq "italic"} {
 	lappend fontpref($f) "italic"
     }
-    set w $prefstop.$f
+    set w $prefstop.notebook.fonts.$f
     $w conf -text $fontparam(family) -font $fontpref($f)
 
     fontcan
@@ -11012,6 +11012,7 @@ proc doprefs {} {
     lappend pages [prefspage_general $notebook] [mc "General"]
     lappend pages [prefspage_colors $notebook] [mc "Colors"]
     lappend pages [prefspage_fonts $notebook] [mc "Fonts"]
+    set col 0
     foreach {page title} $pages {
 	if {$use_notebook} {
 	    $notebook add $page -text $title
