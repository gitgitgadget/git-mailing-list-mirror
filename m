From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git notes"
Date: Fri, 15 Apr 2011 19:53:51 +0200
Message-ID: <4DA8862F.5070102@gmail.com>
References: <4DA7F73B.9050007@gmail.com> <7v7have8wo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAnDV-0002X4-1w
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab1DORx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:53:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32859 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab1DORx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:53:56 -0400
Received: by fxm17 with SMTP id 17so1963252fxm.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ucf5NQ2xSvuahz23uMfPZ2NHliaU2d1C+m7mG0LffEk=;
        b=BWkMhkWWLkC4oB8nwtzVre3fFJwixDojSFl+ZhXCarfasuTVx9YlyAwUtMvMaYMXov
         W2zCPpmOJQBJMXxaiwo3p+dF+NI/Le1ZyV8Hb6CkcUztc9oPdTQlpq6zHO9aACI/17fH
         +N+TMPDoVZdTlQAru5gQg3SlAyf3yRtUUl+N4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=hGlshhqnre4p6+1s8I6as3o8o43tgCgvwWsQjRbVhsTBm6b6ZT/Ro0DdMnK1TuKcDA
         7wu2IlifQ7tM9JDto9jdWWnrSiOtCP2npmlNL+M5fhuUYM676nZhbK7cldLw1B3tbWQS
         e4LDbbs0PQ0mEuyUUkMECHTdkJ61TPZbO6iRo=
Received: by 10.223.117.134 with SMTP id r6mr2393482faq.147.1302890034708;
        Fri, 15 Apr 2011 10:53:54 -0700 (PDT)
Received: from [130.73.68.143] (berry.zib.de [130.73.68.143])
        by mx.google.com with ESMTPS id x16sm862266fal.19.2011.04.15.10.53.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 10:53:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v7have8wo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171624>

The documentation for "cherry-pick -x" could be misread in the way that a
"git notes" object is attached to the new commit, which is not the case.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-cherry-pick.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 01db830..9d8fe0d 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -51,9 +51,10 @@ OPTIONS
 	message prior to committing.
 
 -x::
-	When recording the commit, append to the original commit
-	message a note that indicates which commit this change
-	was cherry-picked from.  Append the note only for cherry
+	When recording the commit, append a line that says
+	"(cherry picked from commit ...)" to the original commit
+	message in order to indicate which commit this change was
+	cherry-picked from.  This is done only for cherry
 	picks without conflicts.  Do not use this option if
 	you are cherry-picking from your private branch because
 	the information is useless to the recipient.  If on the
-- 
1.7.3.2.msysgit.11
