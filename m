From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: git archive --format zip utf-8 issues
Date: Sat, 11 Aug 2012 01:53:16 +0200
Message-ID: <50259EEC.2020701@tu-clausthal.de>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 01:53:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szz19-0001uQ-Td
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 01:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760414Ab2HJXxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 19:53:17 -0400
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:15486 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760187Ab2HJXxR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 19:53:17 -0400
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 80FCD42D985;
	Sat, 11 Aug 2012 01:53:15 +0200 (CEST)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 5A8A742216B;
	Sat, 11 Aug 2012 01:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=w6ZN2EXPy5ZuHOr57ZKxYpfUD8g=; b=xPntkJiawTgUxlrBmsVii6eMKkRD
	Gg2T+hq103EdDL4Wi/+Nt3CAW7RV0XS0xpZBjSxNTROhrppjrdimiXT/DKj5L88b
	vM2jGQalxzpm8tx+TO1jUtmuqWJAKVrO4hdqK7YQ/lWIn2F5HL/WP+iOzt1PS20t
	PjTJp3bXYZCnnTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=50fwu0ZGfSPfNqLL1CmC//Mxs6aUX2Xa6ZMzO5isz9R3rySg5lqlYv6
	84ayeMsn++FfbrA7DjRSWUeCOZGOnAKdV5Db9yErlCJiHlR+16jmeGe+NNsXi042
	/5k6ZziNHSdrbn32Snh0EoZY1EovUmYO/Y5CIYoxcRc5TlWduCRg=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id DEBC9422153;
	Sat, 11 Aug 2012 01:53:14 +0200 (CEST)
Received: from [91.3.190.140] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.6)
  with ESMTPSA id 36106085; Sat, 11 Aug 2012 01:53:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vtxwagy9f.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 TO_IN_SUBJECT 0.5, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_600_699 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __INT_PROD_LOC 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203276>

Am 11.08.2012 00:47 schrieb Junio C Hamano:
> Do you know in what encoding the pathnames are _expected_ to be
> stored in zip archives?

re-encoding to latin1 does not always work and may break double byte
totally (e.g. chinese or japanese).

PKZIP APPNOTE seems to be the zip standard and it specifies a utf-8
flag: http://www.pkware.com/documents/casestudies/APPNOTE.TXT
> A.  Local file header:
> general purpose bit flag: (2 bytes)
> Bit 11: Language encoding flag (EFS).  If this bit is
> set, the filename and comment fields for this file
> must be encoded using UTF-8. (see APPENDIX D)

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
