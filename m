From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag deletions not rejected with receive.denyDeletes=
 true
Date: Mon, 12 Dec 2011 09:16:44 -0800
Message-ID: <7v62hl677n.fsf@alter.siamese.dyndns.org>
References: <12967682.2821323698766430.JavaMail.root@promailix.prometil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jerome DE VIVIE <j.devivie@prometil.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 18:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra9Ui-0001bN-SN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 18:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab1LLRQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 12:16:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab1LLRQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 12:16:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF72613D;
	Mon, 12 Dec 2011 12:16:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xBaCZNixLYEng4Bchy+7VVzXTFQ=; b=OaNPdo
	E2kazLoOPvLwybN3P0IgzArRTX5MlkaDuq6OeWEIcEurXX3r4/kb3n539bzJD8MY
	H95eiINiEOsxmdCmsNR72SpeQBsF1sjoWD9iGub46l/2Qx7F2faSQY4AyMb4BkWm
	2Jjil93LIODy3Pcyu2f55ogSBp8W2X3oESxMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fDR8ltKmeeA07xKoF6CQt5Gz6Xgb6QFw
	mB6elOVXjT7PALUJJH4v1FG3+retxb0cE1OURJDVU0bGT6BPz85G1GOslYzG4Pzm
	ILEJxSsf1/i5be5ovBNOCV3fMuZbLpw1CifeRqZQA3mlIWVBreQBp1YpkWdDI8Lp
	9wqWng0M69c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D72BA613C;
	Mon, 12 Dec 2011 12:16:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CDF26139; Mon, 12 Dec 2011
 12:16:46 -0500 (EST)
In-Reply-To: <12967682.2821323698766430.JavaMail.root@promailix.prometil.com>
 (Jerome DE VIVIE's message of "Mon, 12 Dec 2011 15:06:06 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11D3A966-24E5-11E1-86E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186919>

Jerome DE VIVIE <j.devivie@prometil.com> writes:

> Junio C Hamano <gitster@pobox.com> writes :
>> Our documentation can also use some updates, as it dates to the days back
>> when we more liberally used "refs" and "branches" interchangeably.
>
> Ok, I have turned the patch below for documentation.

Err,.. what I meant by "documentation update" is more like this.

 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8a7d2d4..8eda8e4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1653,15 +1653,15 @@ receive.unpackLimit::
 	`transfer.unpackLimit` is used instead.
 
 receive.denyDeletes::
-	If set to true, git-receive-pack will deny a ref update that deletes
-	the ref. Use this to prevent such a ref deletion via a push.
+	If set to true, git-receive-pack will deny an update that deletes
+	the branch. Use this to prevent a push from deleting a branch.
 
 receive.denyDeleteCurrent::
-	If set to true, git-receive-pack will deny a ref update that
+	If set to true, git-receive-pack will deny an update that
 	deletes the currently checked out branch of a non-bare repository.
 
 receive.denyCurrentBranch::
-	If set to true or "refuse", git-receive-pack will deny a ref update
+	If set to true or "refuse", git-receive-pack will deny an update
 	to the currently checked out branch of a non-bare repository.
 	Such a push is potentially dangerous because it brings the HEAD
 	out of sync with the index and working tree. If set to "warn",
