From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ls-tree: migrate to parse-options
Date: Mon, 16 Nov 2009 22:22:00 -0800
Message-ID: <7vpr7hisc7.fsf@alter.siamese.dyndns.org>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
 <1258173248-31059-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHSD-0005CM-OB
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZKQGWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbZKQGWE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:22:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbZKQGWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:22:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 297D89F41A;
	Tue, 17 Nov 2009 01:22:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=c/NDzTQIR7WknHARlH1+cCx6c2o=; b=m97Hd46WGuhfzndid92AmPD
	I3PGZmZ4ZiYDv5pAq1G9vGHwXGaNSPMuAC2fOjrH+VJ+sQx/poTa9OBNgY2r/Uvk
	OmFSjwKiPOaC3BFce/pLQ7VxsiI1LdzRain/6uDU+13MIXtc2vePZHqfx2S3aj/1
	buGapKMUCqWjKh7kLSMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xp2etqv/XRQqLldm7VEr8M70jYItLz2zGDx97j5yip9qWPOJI
	L96U7qUKcGcETBrovzNDvdzEEEw4Mm9eSBgJ4Tlz8SNGYub84uI3FuFZEu00jVx6
	1D9dw2PmcVL/UFibojD82mmy3U7Rhro4bwF53iU4ZsQT70k0z8co9yqktc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 083F99F419;
	Tue, 17 Nov 2009 01:22:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E52949F418; Tue, 17 Nov 2009
 01:22:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86760676-D341-11DE-AFFA-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133061>

Thanks.

As parse-options infrastructure gives much better per-option help text,
there is not much point to keep the list of options that can go stale
in the usage text.

I'd squash this to yours.  Ok?

---
 builtin-ls-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 04408df..14a913a 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const  char * const ls_tree_usage[] = {
-	"git ls-tree [-d] [-r] [-t] [-l | --long] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]",
+	"git ls-tree <options> <tree-ish> [path...]",
 	NULL
 };
 
-- 
1.6.5.3.283.g4b054
