From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] bash completion: git rm has grown a --force option
Date: Fri, 8 Aug 2008 19:41:34 -0400
Message-ID: <20080808234134.GH5655@inocybe.teonanacatl.org>
References: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl>
 <7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 01:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRbbb-0003pd-Bx
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 01:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbYHHXln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbYHHXln
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 19:41:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYHHXlm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 19:41:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CC944F1AA;
	Fri,  8 Aug 2008 19:41:41 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-69-248-23-23.hsd1.pa.comcast.net
 [69.248.23.23]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTPSA id B3F504F1A9; Fri,  8 Aug 2008 19:41:36 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, Pieter de Bie
 <pdebie@ai.rug.nl>, Lee Marlow <lee.marlow@gmail.com>, "Shawn O. Pearce"
 <spearce@spearce.org>, Git Mailinglist <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
X-Listening-To: Time Lapse Consortium - Cholula
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: 8D383A7C-65A3-11DD-8359-CE28B26B55AE-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91727>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Junio C Hamano wrote:
> I think this makes sense even this late in -rc cycle.  Thanks.

Perhaps this is worth adding as well then, since Lee went to the
trouble of adding completion for git rm just the other day? ;)

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3396e35..2d0e468 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1361,7 +1361,7 @@ _git_rm ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--cached --dry-run --force --ignore-unmatch --quiet"
 		return
 		;;
 	esac
-- 
1.6.0.rc2

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In some cultures what I do would be considered normal.
