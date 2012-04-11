From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Wed, 11 Apr 2012 16:48:58 -0700
Message-ID: <7v8vi1j0d1.fsf@alter.siamese.dyndns.org>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:49:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI7Hj-0005nH-2T
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897Ab2DKXtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 19:49:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933995Ab2DKXtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 19:49:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D595CAF;
	Wed, 11 Apr 2012 19:49:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ohIXgdIWiXFblluIiisFphMjbNU=; b=BqooPi
	mToh7WZFoMva+3TfKSR7bw2JmqlSS+/jd/6w3I/5f/QG23EX2gzAUonmjbbqcCqF
	7mqksM9U9fMUhYlhAJDH+J6mL4smbUC/AFoGd0IJGbs8jgR/m/4CWEx/eehzWssd
	n5FozcJdtG6otOWmA8WfdVMu9+AW3hq1yHyL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPs1mwAdJEk4NVBlD0uHjLwmcZyakPNm
	AMnN8SNq4epqpa0VCr/MqLiweYAykhkwTZMiQrJ2D0SnlvfmBXwsKSlHQij4h9SO
	ok0PmPbyXnkx2a8QKvrwIBJ5RFXCRVZt4wUjf+dejzIsS+zYG43v6D/2Sz6v348K
	0dVjDJq2tvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC2D5CA5;
	Wed, 11 Apr 2012 19:49:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F361A5CA3; Wed, 11 Apr 2012
 19:48:59 -0400 (EDT)
In-Reply-To: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 12 Apr 2012 00:57:03 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9040764-8430-11E1-B285-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195284>

The trailing whitespaces are not visible when reviewing tests, so I'll
squash this in, but otherwise looks good.

Thanks.

 t/t9902-completion.sh |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbda6b5..51227ac 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -84,30 +84,30 @@ test_expect_success 'basic' '
 '
 
 test_expect_success 'double dash' '
-	cat >expected <<-\EOF &&
-	--paginate 
-	--no-pager 
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	--paginate Z
+	--no-pager Z
 	--git-dir=
-	--bare 
-	--version 
-	--exec-path 
-	--html-path 
+	--bare Z
+	--version Z
+	--exec-path Z
+	--html-path Z
 	--work-tree=
 	--namespace=
-	--help 
+	--help Z
 	EOF
 	test_completion "git --"
 
-	cat >expected <<-\EOF &&
-	--quiet 
-	--ours 
-	--theirs 
-	--track 
-	--no-track 
-	--merge 
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	--quiet Z
+	--ours Z
+	--theirs Z
+	--track Z
+	--no-track Z
+	--merge Z
 	--conflict=
-	--orphan 
-	--patch 
+	--orphan Z
+	--patch Z
 	EOF
 	test_completion "git checkout --"
 '
