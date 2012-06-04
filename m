From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Mon, 04 Jun 2012 12:31:13 -0700
Message-ID: <7vpq9eswla.fsf@alter.siamese.dyndns.org>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org> <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 21:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbczq-0000f1-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 21:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab2FDTbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 15:31:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab2FDTbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 15:31:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B8268E19;
	Mon,  4 Jun 2012 15:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wtrLZ/xTxcALAtRzSHd0N4Eep7k=; b=Gy4Um4
	uGkKKWCZscjx6v5bgV2jDk3sB8z8PVKz1hCROG/DoP8nlyhRCsL2naH+2wJY9spX
	fEzr2TAYlZP/jyrF+llA3IO+nAOEq+1hSN2U7NKb9r+MSDfsNsmsZg762PnK7Z+g
	6Jo9kvK07vUsCUvto9asjK+m0OK4gfaBZHD2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mAKJajlz8Y4FijD+M+3yJCv8Rq/USk6I
	nHeTqpvEmZah2VBrJeQBg+4cnTA14FHtg3IKDJee6wMe9IZdNPqGwdzs3/NiNege
	Flk6axlj+ZP3HsgqTlI2kevwGKeZnYSfdsaZDqG5jWv10StU3fs3E6guv+3kso+O
	4GnVq2PBHcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51F448E18;
	Mon,  4 Jun 2012 15:31:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D61F18E15; Mon,  4 Jun 2012
 15:31:14 -0400 (EDT)
In-Reply-To: <20120604115630.GC27676@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 4 Jun 2012 07:56:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D95E4F2A-AE7B-11E1-8340-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199171>

Jeff King <peff@peff.net> writes:

>> On my machine (Debian stable), the HTML formatting is correct (and BTW,
>> the other instance of linkgit in technical, "(see
>> linkgit:gitattributes[5])" is broken).
>
> There is also a broken reference to linkgit:git-config[1] in
> api-config.txt.

Thanks; we should queue somthing like this.

-- >8 --
Subject: [PATCH] doc: fix xref link from api docs to manual pages

They are one-level above, so refer them as linkgit:../git-foo[n] with "../"

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-config.txt | 2 +-
 Documentation/technical/api-merge.txt  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index edf8dfb..bd4d8b8 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -2,7 +2,7 @@ config API
 ==========
 
 The config API gives callers a way to access git configuration files
-(and files which have the same syntax). See linkgit:git-config[1] for a
+(and files which have the same syntax). See linkgit:../git-config[1] for a
 discussion of the config file syntax.
 
 General Usage
diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index 9dc1bed..25158b8 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -36,7 +36,7 @@ the operation of a low-level (single file) merge.  Some options:
 	ancestors in a recursive merge.
 	If a helper program is specified by the
 	`[merge "<driver>"] recursive` configuration, it will
-	be used (see linkgit:gitattributes[5]).
+	be used (see linkgit:../gitattributes[5]).
 
 `variant`::
 	Resolve local conflicts automatically in favor
-- 
1.7.11.rc1.2.g33fe195
