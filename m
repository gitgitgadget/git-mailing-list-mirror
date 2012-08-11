From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: git archive --format zip utf-8 issues
Date: Sat, 11 Aug 2012 23:37:05 +0200
Message-ID: <5026D081.2040906@tu-clausthal.de>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 23:38:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0JNg-00010X-2N
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab2HKVhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Aug 2012 17:37:07 -0400
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:43458 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754655Ab2HKVhF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2012 17:37:05 -0400
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 61A7C42D971;
	Sat, 11 Aug 2012 23:37:03 +0200 (CEST)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 21E9E4227B9;
	Sat, 11 Aug 2012 23:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=RVMiXHnKf9ssPoLDrMl9kO4uB7A=; b=WKNylGwtGu1+DfwewpvfohdK0eOS
	HRHOT/vMzJkKM1P+wo8ApB0iJLom2/UEH+48hT2P5ghXdJDSH0ug2y1ETiYAaRu3
	CIR5Xt1+dQVwrZaMHGKuc/DVHhdDDEox28/K9/9UrYLmYt1d68zQ+TS+bWQDrJrh
	uJHkd1io1xi5B0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=8N+Qtd+Neo5eMddFR579LLuB/RgjIOdYxfD1IIoreGqjXBGqvq0Wcn7
	Me/LV1UmEQx1k+PVETiWQryRJK6VQyO3fOF9YwJcO395+ORmIPDS85WBRbZjH5Wl
	HWb3ZewaydOgGhqunIEHtbgAuVZt+FVmn7WWP92/twpOVq/Hd5oQ=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id B6A804227B5;
	Sat, 11 Aug 2012 23:37:02 +0200 (CEST)
Received: from [91.3.187.144] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.6)
  with ESMTPSA id 36117502; Sat, 11 Aug 2012 23:37:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5026C649.2090700@lsrfire.ath.cx>
X-Enigmail-Version: 1.4.3
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 TO_IN_SUBJECT 0.5, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1300_1399 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __HIGHBITS 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203299>

Am 11.08.2012 22:53 schrieb Ren=C3=A9 Scharfe:
> The standard says we need to convert to CP437, or to UTF-8, or provid=
e=20
> both versions. A more interesting question is: What's supported by wh=
ich=20
> programs?
>=20
> The ZIP functionality built into Windows 7 doesn't seem to work with=20
> UTF-8 encoded filenames (except for those that only use the ASCII=20
> subset), and to ignore the UTF-8 part if both are given.

I played a bit with the git source code and found out, that

diff --git a/archive-zip.c b/archive-zip.c
index f5af81f..e0ccb4f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -257,7 +257,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	copy_le16(dirent.creator_version,
 		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
 	copy_le16(dirent.version, 10);
-	copy_le16(dirent.flags, flags);
+	copy_le16(dirent.flags, flags+2048);
 	copy_le16(dirent.compression_method, method);
 	copy_le16(dirent.mtime, zip_time);
 	copy_le16(dirent.mdate, zip_date);
--
works with 7-zip, however, not with Windows 7 build-in zip.

If I create a zip file with 7-zip which contains umlauts and other
unicode chars like (=E5=9C=8B=E7=AB=8B1-=D0=BA=D0=BA=D0=BA=D0=BA.txt) t=
he Windows 7 build-in zip displays
them correctly, too.

--=20
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
