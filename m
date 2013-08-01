From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v3] Provide some linguistic guidance for the documentation.
Date: Thu,  1 Aug 2013 14:49:54 -0400
Message-ID: <1375382994-30010-1-git-send-email-marcnarc@xiplink.com>
References: <7vfvuts25p.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 20:49:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4xwc-0006uK-AL
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 20:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab3HAStq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 14:49:46 -0400
Received: from 175-249-254-64.static.cogecodata.net ([64.254.249.175]:17288
	"EHLO cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753812Ab3HAStq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Aug 2013 14:49:46 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 7A65460051;
	Thu,  1 Aug 2013 14:49:44 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <7vfvuts25p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231499>

This will hopefully avoid questions over which spelling and grammar should
be used.  Translators are of course free to create localizations for
specific English dialects.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

On 13-08-01 02:21 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> + The documentation generally follows US English (en_US) norms for spelling
>> + and grammar, although most spelling variations are tolerated.  Just avoid
>> + mixing styles when updating existing text.  If you wish to correct the
>> + English of some of the existing documentation, please see the documentation-
>> + related advice in the Documentation/SubmittingPatches file.
> 
> Is that accurate?  My impression has been:
> 
>     The documentation liberally mixes US and UK English (en_US/UK)
>     norms for spelling and grammar, which is somewhat unfortunate.
>     In an ideal world, it would have been better if it consistently
>     used only one and not the other, and we would have picked en_US.
> 
>     A huge patch that touches the files all over the place only to
>     correct the inconsistency is not welcome, though.  Potential
>     clashes with other changes that can result from such a patch is
>     simply not worth it.  What we would want is to gradually convert
>     them, with small and easily digestable patches, as a side effect
>     of doing some other _real_ work in the vicinity (e.g. rewriting
>     a paragraph to clarify, while turning en_UK spelling to en_US).

I was focused more on just describing what the documentation should be rather than what it is.  I don't feel strongly about it & I think your phrasing is fine.  I do think the topic needs to be in both CodingGuidelines and SubmittingPatches.  How about this?

(The SubmittingPatches change also switches "I am " to "we are" in the following paragraph, because I found the jump a bit too jarring.)

		M.


 Documentation/CodingGuidelines  |  8 ++++++++
 Documentation/SubmittingPatches | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 559d5f9..8acf557 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -242,6 +242,14 @@ Writing Documentation:
  processed into HTML and manpages (e.g. git.html and git.1 in the
  same directory).
 
+ The documentation liberally mixes US and UK English (en_US/UK)
+ norms for spelling and grammar, which is somewhat unfortunate.
+ In an ideal world, it would have been better if it consistently
+ used only one and not the other, and we would have picked en_US.
+ (If you wish to correct the English of some of the existing
+ documentation, please see the documentation-related advice in the
+ Documentation/SubmittingPatches file.)
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.  A few commented examples follow to provide reference
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d0a4733..b3477ba 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -65,7 +65,19 @@ feature does not trigger when it shouldn't.  Also make sure that the
 test suite passes after your commit.  Do not forget to update the
 documentation to describe the updated behaviour.
 
-Oh, another thing.  I am picky about whitespaces.  Make sure your
+Speaking of the documentation, it is currently a liberal mixture of US
+and UK English norms for spelling and grammar.  A huge patch that
+touches the files all over the place only to correct the inconsistency
+is not welcome, though.  Potential clashes with other changes that can
+result from such a patch are simply not worth it.  We prefer to
+gradually reconcile the inconsistencies (in favor of US English), with
+small and easily digestible patches, as a side effect of doing some
+other real work in the vicinity (e.g. rewriting a paragraph for clarity,
+while turning en_UK spelling to en_US).  Obvious typographical fixes are
+also welcome ("teh -> "the"), preferably submitted as independent patches
+separate from other documentation changes.
+
+Oh, another thing.  We are picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
 in templates/hooks--pre-commit.  To help ensure this does not happen,
 run git diff --check on your changes before you commit.
-- 
1.8.3.1
