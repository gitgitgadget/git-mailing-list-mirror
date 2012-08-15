From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] add some bash style we prefer
Date: Wed, 15 Aug 2012 19:06:01 +0200
Message-ID: <20120815170601.GB43523@book.hvoigt.net>
References: <20120814203931.GB33843@book.hvoigt.net> <7vipcl89kg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1h2t-0008EI-BS
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 19:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab2HORGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 13:06:09 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:34375 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab2HORGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 13:06:08 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T1h2g-0007t5-A5; Wed, 15 Aug 2012 19:06:02 +0200
Content-Disposition: inline
In-Reply-To: <7vipcl89kg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203473>

During discussion of other patches these preferences have been revealed.
Lets add them to the guidelines.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Here an updated version of the patch.

On Tue, Aug 14, 2012 at 02:09:35PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > @@ -97,6 +102,7 @@ For shell scripts specifically (not exhaustive):
> >     interface translatable. See "Marking strings for translation" in
> >     po/README.
> >  
> > +
> >  For C programs:
> 
> Probably not needed, as there is no such double space between C
> and Documentation sections.

Sorry about that whitespace noise.

Cheers Heiko

 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4557711..e70d110 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -76,11 +76,19 @@ For shell scripts specifically (not exhaustive):
 
  - We do not use Process Substitution <(list) or >(list).
 
+ - We prefer writing all control structures without semicolon on the
+   same line. E.g. "then" should be on the next line for if statements.
+   The same applies to while, for, ...
+
  - We prefer "test" over "[ ... ]".
 
  - We do not write the noiseword "function" in front of shell
    functions.
 
+ - We prefer a space between the function name and the parentheses. The
+   opening "{" should also be on the same line.
+   E.g.: my_function () {
+
  - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
    [::], [==], nor [..]) for portability.
 
-- 
1.7.12.rc2.11.g5d52328
