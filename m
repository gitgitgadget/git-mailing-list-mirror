From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disambiguate duplicate t9160* tests
Date: Fri, 16 Sep 2011 14:06:11 -0700
Message-ID: <7viposdwos.fsf@alter.siamese.dyndns.org>
References: <1316202903-5085-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty8cdxun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bjacobs@woti.com, rchen@cs.umd.edu
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 23:06:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fc4-00018S-QQ
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 23:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251Ab1IPVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 17:06:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab1IPVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 17:06:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5252A59B8;
	Fri, 16 Sep 2011 17:06:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQGsHSq9yFpHIrM18Ag2hgbGnfk=; b=RHbSiI
	QHXMXL5gTEGFQO9IRu6AZBPg/sb/ZgOKV27hpwn+FpU+lY8rkpGg2Hno9pEqGkqL
	bVvq7dsdXGcXdGXKwAlDKxIGoxpgVuGe6c0NomR6AkanRak0t2X9SdsWTs57b20j
	XkGzvidFqIdI3DkUHa9c7WyzfTkjSaP3rj3YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yV4Ff8KvYEsAQpmLUUUks9GkMvqq4hb/
	iwRaVTp6iFBpKZBIPLiB+jGXaKF4iw+AxhAb/oO3RqK+t4z1i5zP5IMizp2LAXcp
	BAKLVw0XaM7pRKKlI1XUghz10yXYvmHoPl7zHfIwAKrVE0girKi66fU2lJRB4q92
	uHK+o10I6SI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 495C359B6;
	Fri, 16 Sep 2011 17:06:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C27D959B3; Fri, 16 Sep 2011
 17:06:12 -0400 (EDT)
In-Reply-To: <7vty8cdxun.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Sep 2011 13:41:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B55D902E-E0A7-11E0-9B93-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181558>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.

Heh, I spoke too early. It still refers to contents of t/t9160/ directory.
We would need this squashed into your patch (no need to resend).

 t/t9161-git-svn-mergeinfo-push.sh |    2 +-
 t/{t9160 => t9161}/branches.dump  |    0
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index 216f3d7..6ef0c0b 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -10,7 +10,7 @@ test_description='git-svn svn mergeinfo propagation'
 
 test_expect_success 'load svn dump' "
 	svnadmin load -q '$rawsvnrepo' \
-	  < '$TEST_DIRECTORY/t9160/branches.dump' &&
+	  < '$TEST_DIRECTORY/t9161/branches.dump' &&
 	git svn init --minimize-url -R svnmerge \
 	  -T trunk -b branches '$svnrepo' &&
 	git svn fetch --all
diff --git a/t/t9160/branches.dump b/t/t9161/branches.dump
similarity index 100%
rename from t/t9160/branches.dump
rename to t/t9161/branches.dump
