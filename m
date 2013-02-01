From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames
 with spaces with TortoiseGitMerge
Date: Fri, 01 Feb 2013 21:16:30 +0100
Message-ID: <510C229E.2050705@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org> <51032E96.2040209@tu-clausthal.de> <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com> <5104F009.5020606@tu-clausthal.de> <7vzjzuwm7s.fsf@alter.siamese.dyndns.org> <510C1872.3090304@tu-clausthal.de> <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1NfG-0001Nl-1d
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab3BAU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:56:26 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:16479 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757540Ab3BAU4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 15:56:24 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 3D77B42E2A2;
	Fri,  1 Feb 2013 21:56:22 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 532FC422108;
	Fri,  1 Feb 2013 21:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=1opQCcpjTduY+1iadc0tW85YJco=; b=2l0Sv/fEsaqxWhjjJ7pGTuWjtU0Z
	xs2pOx2VYdMzCEfb5xZF298Y6zSPFnPmTLdB0slNVOXYXY/Ku+9wWwzCgwxfamfn
	NftEgoP0NPmC/zrx4z5oi8d3alGDaVeKyCED1CjT9qYK3azUmyA95O1Dvh2BB5IA
	umFIyzMxD9LPj6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=8aDb6+lywTOV1U8i0sipQWDVv9kLTW7f/EotKLroE8VgD1+sowIdZmh
	xN/MXx4oP10T7g9qzxNOKIfEUEgWiAxyAUE+zE4IQdQBshI+5kp5N5sKlkmH46pf
	ax0AXB7ieeTW3jtsXWb9zeaJcsOspnr8ihP6Mo6gpFdh0+y/9ZjE=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 462B342325C;
	Fri,  1 Feb 2013 21:16:25 +0100 (CET)
Received: from [79.193.90.228] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43701348; Fri, 01 Feb 2013 21:16:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 __FRAUD_WEBMAIL! 0, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1800_1899 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215272>

TortoiseGitMerge, unlike TortoiseMerge, can be told to handle paths
with spaces in them by using -option "$FILE" (not -option:"$FILE",
which does not work for such paths) syntax.

This change was necessary because of MSYS path mangling [1], the ":"
after the "base" etc. arguments to TortoiseMerge caused to whole
argument instead of just the file name to be quoted in case of file
names with spaces. So TortoiseMerge was passed

    "-base:new file.txt"

instead of

    -base:"new file.txt"

(including the quotes). To work around this, TortoiseGitMerge does not
require the ":" after the arguments anymore which fixes handling file
names with spaces [2] (as written above).

[1] http://www.mingw.org/wiki/Posix_path_conversion
[2] https://github.com/msysgit/msysgit/issues/57

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/tortoisemerge | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index 8476afa..3b89f1c 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -6,9 +6,17 @@ merge_cmd () {
 	if $base_present
 	then
 		touch "$BACKUP"
-		"$merge_tool_path" \
-			-base:"$BASE" -mine:"$LOCAL" \
-			-theirs:"$REMOTE" -merged:"$MERGED"
+		basename="$(basename "$merge_tool_path" .exe)"
+		if test "$basename" = "tortoisegitmerge"
+		then
+			"$merge_tool_path" \
+				-base "$BASE" -mine "$LOCAL" \
+				-theirs "$REMOTE" -merged "$MERGED"
+		else
+			"$merge_tool_path" \
+				-base:"$BASE" -mine:"$LOCAL" \
+				-theirs:"$REMOTE" -merged:"$MERGED"
+		fi
 		check_unchanged
 	else
 		echo "$merge_tool_path cannot be used without a base" 1>&2
-- 
1.8.1.msysgit.1
