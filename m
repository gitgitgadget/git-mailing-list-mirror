From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] completion: Add --full-diff to log/gitk options
Date: Wed, 3 Jun 2009 08:22:30 -0400
Message-ID: <20090603122230.GZ28808@inocybe.localdomain>
References: <pan.2009.06.02.00.34.36@fedoraproject.org>
 <7vzlcrihew.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Spura <tomspur@fedoraproject.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 14:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBpUy-0001ap-Go
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 14:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbZFCMWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 08:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbZFCMWh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 08:22:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbZFCMWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 08:22:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3F14B8570;
	Wed,  3 Jun 2009 08:22:37 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 522C3B856E; Wed,
  3 Jun 2009 08:22:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzlcrihew.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 39B1CCB6-5039-11DE-BB1B-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120605>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Junio C Hamano wrote:
> Thomas Spura <tomspur@fedoraproject.org> writes:
>
>> If running "git log -p parse-options.*", the last commit is
>> df217ed6430efe444a09fffdafd39720ae3f9864
>> There are the changes this commit makes towards parse-options.*.
>>
>> I was expecting to see the full commit with all changes and not only
>> towards the 2 files - only including the two files.
>>
>> Is my expactation wrong or is this a bug?
>
> Time to run "man git-log" and look for --full-diff, perhaps?

While this patch won't do much to help people find the option, perhaps
those who learn about it will appreciate not having to type it. :)

I *think* __git_log_gitk_options is the proper place for it, but it's
early in the a.m. and I'm not averse to being proved wrong.

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0c8bb53..2b291ea 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1117,7 +1117,7 @@ __git_log_common_options="
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="
-	--dense --sparse --full-history
+	--dense --sparse --full-diff --full-history
 	--simplify-merges --simplify-by-decoration
 	--left-right
 "
-- 
1.6.3.1

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Going to hell when I die would just be redundant.
