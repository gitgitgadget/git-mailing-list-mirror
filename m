From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/6] git-fetch.txt: document fetch output
Date: Sun,  5 Jun 2016 10:11:36 +0700
Message-ID: <20160605031141.23513-2-pclouds@gmail.com>
References: <20160603110843.15434-1-pclouds@gmail.com>
 <20160605031141.23513-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OU2-0004PM-81
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbcFEDMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:12:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36315 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:12:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so15001649pfd.3
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73+N2jWbqQwx8FrHlb13ZKZarWBCc5PNaver1tr0zRU=;
        b=We4Sf06A5bnMTifbtotQ1LT/ufM3Qo+yxbix9Dk+8Jzr/TYcPp7hfzMxLXM2IxLUpx
         ONRoWNUXT6XtP4naVk62HyV8s7DKG2x32QEmHPoI+fSCsjw50Dj//y1wV/By6t9nDvnb
         9KNF/O+IFN+nxHfAU063k8CO/QUjR7POAUoAceC4Enaxq5IV//ZlIx92KX531yiLN/Hn
         4cJMjyXorKvvHflieO9rpatTrnYfFV2JbYsRHYtcsNDocRaiooe/qQZx7WL53JoYQoVC
         mONS1XBguTZdvNFX/zklK/4OYD+cf440KlXbezLR/prKu/7/hzQwIHABCMjUEV1RtjNO
         MrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73+N2jWbqQwx8FrHlb13ZKZarWBCc5PNaver1tr0zRU=;
        b=MoMxAf5TYU3VORnl2USa0J6UWVFXvUToebiKE13EPt+496PFdFw0kfoEwvoL7z6x78
         NjSqLqvuYGpTKo7sYjoZJGM+kJoNq/psKhb5tIUhMdoc/0X88TJ+safi/nFtxsWxnMeX
         NtG+Ka3yV5QDXxs+Cllt3cnYiNXSQPnIaiXuMMrtnCDgwyNpZb68476jYBc5OMkfIUEv
         RONSsqaTgbVulO7qNHgy4DeQYroY1r4mAF8dbMzSV3l2KAMQcO0dVE5Y6M5ANWIx8V9J
         adlfH+ENvIaMMMVCBaxIH49Ro/B4KPNyEubTrFanEELpXH/jPX8iMBNDDHzBMfmbBbk2
         gJbA==
X-Gm-Message-State: ALyK8tIwClUCO7E9Bv5pwgAaFj2YUonJB4v2IU2wkhF7MbrB3Js7/r4HexB9Y53/7IEyrQ==
X-Received: by 10.98.204.5 with SMTP id a5mr16091148pfg.37.1465096320446;
        Sat, 04 Jun 2016 20:12:00 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id c15sm18012412pfj.65.2016.06.04.20.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:11:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:11:54 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296452>

This documents the ref update status of fetch. The structure of this
output is defined in [1]. The ouput content is refined a bit in [2]
[3] [4].

This patch is a copy from git-push.txt, modified a bit because the
flag '-' means different things in push (delete) and fetch (tag
update).

PS. For code archaeologists, the discussion mentioned in [1] is
probably [5].

[1] 165f390 (git-fetch: more terse fetch output - 2007-11-03)
[2] 6315472 (fetch: report local storage errors ... - 2008-06-26)
[3] f360d84 (builtin-fetch: add --prune option - 2009-11-10)
[4] 0997ada (fetch: describe new refs based on where... - 2012-04-16)
[5] http://thread.gmane.org/gmane.comp.version-control.git/61657

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch.txt | 46 +++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index efe56e0..a0d0539 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -99,6 +99,52 @@ The latter use of the `remote.<repository>.fetch` va=
lues can be
 overridden by giving the `--refmap=3D<refspec>` parameter(s) on the
 command line.
=20
+OUTPUT
+------
+
+The output of "git fetch" depends on the transport method used; this
+section describes the output when fetch over the Git protocol (either
+locally or via ssh).
+
+The status of the fetch is output in tabular form, with each line
+representing the status of a single ref. Each line is of the form:
+
+-------------------------------
+ <flag> <summary> <from> -> <to> (<reason>)
+-------------------------------
+
+The status of up-to-date refs is shown only if --verbose option is
+used.
+
+flag::
+	A single character indicating the status of the ref:
+(space);; for a successfully fetched fast-forward;
+`+`;; for a successful forced update;
+`x`;; for a successfully deleted ref;
+`-`;; for a successful tag update;
+`*`;; for a successfully fetched new ref;
+`!`;; for a ref that was rejected or failed to update; and
+`=3D`;; for a ref that was up to date and did not need fetching.
+
+summary::
+	For a successfully fetched ref, the summary shows the old and new
+	values of the ref in a form suitable for using as an argument to
+	`git log` (this is `<old>..<new>` in most cases, and
+	`<old>...<new>` for forced non-fast-forward updates).
+
+from::
+	The name of the remote ref being fetched from, minus its
+	`refs/<type>/` prefix. In the case of deletion, the name of
+	the remote ref is "(none)".
+
+to::
+	The name of the local ref being updated, minus its
+	`refs/<type>/` prefix.
+
+reason::
+	A human-readable explanation. In the case of successfully fetched
+	refs, no explanation is needed. For a failed ref, the reason for
+	failure is described.
=20
 EXAMPLES
 --------
--=20
2.8.2.524.g6ff3d78
