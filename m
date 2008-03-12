From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] git-submodule summary: show commit summary
Date: Tue, 11 Mar 2008 21:12:07 -0700
Message-ID: <7vabl48tt4.fsf@gitster.siamese.dyndns.org>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 05:13:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZIKr-0000pR-UY
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 05:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYCLEMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 00:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYCLEMW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 00:12:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYCLEMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 00:12:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B1372DF2;
	Wed, 12 Mar 2008 00:12:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D386F2DF0; Wed, 12 Mar 2008 00:12:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76919>

I've squashed a moral equivalent of the following into this patch (I also
re-indented "case...esac").  Will perhaps queue in 'next' and after that
we can incrementally improve on it.

Thanks.

 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a0ea913..ea23b45 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -400,7 +400,7 @@ cmd_summary() {
 				160000)
 				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
 				;;
-				100644)
+				100644 | 100755 | 120000)
 				sha1_dst=$(git hash-object $name)
 				;;
 			esac
