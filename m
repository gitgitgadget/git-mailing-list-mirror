From: "Alexander Veit" <alexander.veit@gmx.net>
Subject: Re: Per file configurable eol-style transformations with Git?
Date: Sun, 22 Nov 2009 00:49:57 +0100
Message-ID: <1050CAACABF64864A0CF79C957BF773B@helium>
References: <9ED0EB52C33C41209726C6F4DB7FC194@helium> <m3tywnbmpj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 00:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBzly-0002np-RT
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 00:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbZKUXtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 18:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZKUXtz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 18:49:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:57526 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753138AbZKUXty (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 18:49:54 -0500
Received: (qmail invoked by alias); 21 Nov 2009 23:49:58 -0000
Received: from pD9E95106.dip.t-dialin.net (EHLO helium) [217.233.81.6]
  by mail.gmx.net (mp009) with SMTP; 22 Nov 2009 00:49:58 +0100
X-Authenticated: #19984920
X-Provags-ID: V01U2FsdGVkX1+cfLlvPTGczP2ixKoH//L19pk9llTLL914cKx2rQ
	x1bNteX4bod3dz
In-Reply-To: <m3tywnbmpj.fsf@localhost.localdomain>
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acpq8CR3uI1pL70FRxyDYfDMEXX9ogAEfhVA
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6002.18005
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133416>

Jakub Narebski wrote:

> See `crlf` attribute, which can be set, unset, unspecified, set
> to "input", and used together with core.autocrlf ("true", "false",
> "input") and core.safecrlf.  Attributes can be set per path (using
> globbing patterns) in .gitattributes file in tree, or in
> .git/info/attributes (per repository).

I've already tried 

[core]
  autoCRLF = true

in the global gitconfig under Windows. After git clone an immediate
git diff shows every line changed in certain files:

diff --git a/c_crlf_text.txt b/c_crlf_text.txt
index 3b0a76f..3473745 100644
--- a/c_crlf_text.txt
+++ b/c_crlf_text.txt
@@ -1,5 +1,5 @@
-z1
-z2
-z3
-z4
-
+z1
+z2
+z3
+z4
+

file * on Windows:
c___lf_text.txt;  ASCII text, with CRLF line terminators
c_crlf_text.txt;  ASCII text, with CRLF line terminators


file * on Linux
c_crlf_text.txt:  ASCII text, with CRLF line terminators
c___lf_text.txt:  ASCII text

I don't know if this behaviour is supposed to be correct,
but to me it seems to be wrong.

git version 1.6.5.1.1367.gcd48

-- 
Cheers,
Alex
