From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] fetch doc: update refspec format description
Date: Tue,  3 Jun 2014 15:16:29 -0700
Message-ID: <1401833792-2486-7-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx1D-0005Or-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965680AbaFCWRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:17:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64659 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbaFCWRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:17:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3760E1DD82;
	Tue,  3 Jun 2014 18:17:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gG4R
	+Sfb4VjK2e+5zOgXyoQ2Rxs=; b=ZxhXjCaB2hawHiwydmcp0hGYg7Fo+Xsv2JVj
	drprw5mMuGa8O5Z+yLKuMoTfATzM9AyKP5Jcevb71KiRoHWk3XXM/MSkqluirCS6
	D1NeqwJaHX/PI0vctB5Vwx2DPBehRyL5SjSeGQweja3msf+CC+valM8AVgMaNt4U
	wccj71E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Yni9Yu
	1/tdRFpZEYiCR4SCqPa3OE5pVkPncQ607IeARXL5Btrf6pS56v3xn0ROk4xR3Agr
	A9FucjgEOCp6Vink/WkxdS7CVw5w9tKhZRPg7GMUA7Dwh1ITwFNGMTf30yWlFvP8
	PF3c03QyMTwINFYfdNWtFT+3lYWRNotb+NJWk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F3871DD81;
	Tue,  3 Jun 2014 18:17:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7C1321DD7E;
	Tue,  3 Jun 2014 18:17:03 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CA5A5FAC-EB6C-11E3-AEA2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250701>

The text made it sound as if the leading plus is the only thing that
is optional, and forgot that <lhs> is the same as <lhs>:, i.e. fetch
it and do not store anywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 25af2ce..a090d4a 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -15,6 +15,7 @@ endif::git-pull[]
 	The format of a <refspec> parameter is an optional plus
 	`+`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
+	The colon can be omitted when <dst> is empty.
 +
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
-- 
2.0.0-511-g1433423
