From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: howto handle name clashes
Date: Fri, 23 Mar 2012 14:06:01 +0100
Message-ID: <4F6C7539.3080607@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 14:16:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB4MF-0002mI-CH
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 14:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab2CWNQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 09:16:39 -0400
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:59320 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2CWNQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 09:16:38 -0400
X-Greylist: delayed 648 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2012 09:16:38 EDT
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 15EEA4224C6
	for <git@vger.kernel.org>; Fri, 23 Mar 2012 14:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=x2M+uRKhweIuTnL2xuM3ZM5Y
	ifw=; b=I4SdStp8QDISS5ktvLm8ops1wPwLouejeedi8WMzAkpLuhzHTIWqiNMW
	xr0VBg3mNuazQ+kDW1e98vCzVN44uVqhswJ62Tq68lHN60Q4pUPTzfXmGK6pFmyF
	/idtbci4P7DmJYYnHBrqU5Bakv9jZScpe5b7PNlf1zJeTlbEDag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=kx1zcKsGPNMv4DFT3e
	YA2Tc1pPTV52Yi1rITKwRMuiUlSEQ+vDo4KFjY9sFBatUQbMo8xbmzQmIo8h30J9
	Oyc9EIiACcVw4qaFk8O5laQA79KGnVYvAB0+QGucFhdp3jypqbZv36U880Zgbd9z
	Bzrq/YqnPfagAsS5VM85rkOSo=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 4B5EE422985
	for <git@vger.kernel.org>; Fri, 23 Mar 2012 14:05:27 +0100 (CET)
Received: from [139.174.101.48] (account sstri@tu-clausthal.de [139.174.101.48] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 29772412 for git@vger.kernel.org; Fri, 23 Mar 2012 14:05:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
X-Enigmail-Version: 1.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_500_599 0, BODY_SIZE_7000_LESS 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __SUBJ_ALPHA_START 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193759>

Hi,

how to handle name clashes for branches and tags? Is there anything I
can add to the refspec to make the name unique?

E.g.
- for merging "git merge --no-ff refs/branches/test" works, but
generates a not so nice default merge message. ("merged  commit
refs/branches/test" instead of "merged branch test")
- how to drop a remote tag/branch ("git push origin :test" does not work)

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
