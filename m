From: Slavomir Vlcek <svlc@inventati.org>
Subject: Subject: [PATCH/RFC] Documentation/git-stripspace: Update synopsis
Date: Wed, 19 Nov 2014 00:16:55 +0100
Message-ID: <546BD367.40301@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: conrad.irwin@gmail.com, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 00:13:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqryA-00087k-Am
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 00:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbaKRXNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 18:13:53 -0500
Received: from latitanza.investici.org ([82.94.249.234]:30639 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaKRXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 18:13:53 -0500
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id 4CFA0121383;
	Tue, 18 Nov 2014 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1416352431;
	bh=6BLZtJST58c79TOBG6IvWVr1LtrfhGZEx/30NLBZYxI=;
	h=Date:From:To:CC:Subject;
	b=SJ/jdPnLGjlsEWLcT/BK78tkEEWymgEUjpy0sg1SmZRLGhuYShwkbE/Gges5EGpys
	 LxUHUsFM/ikvQFtVApkPiSS6wyJpBzhmXGX7ZpXs39U2htYiBLr1mtOiPjPH32o1gz
	 bUBeTUnFSxifblIfJirvyQ3izUYcIr+VR8dU3Nd4=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add synopsis with the '--comment-lines' option.

Signed-off-by: Slavomir Vlcek <svlc@inventati.org>
---

Hi,
there were no mention of '--comment-lines' in the synopsis.

('--comment-lines' and '--strip-comments' options
are mutually exclusive).

I solved this by adding an extra (second) synopsis line
so it looks just like the 'usage_msg' in 'builtin/stripspace.c'.

But perhaps it would be wiser to have something like
"git stripspace [[-s | --strip-comments] | [-c | --comment-lines]] < input"
instead (and perhaps ordered alphabetically).
This approach can be seen e.g. in the git-add man page.

For the 'master'.


Also, have a few questions about stripspace generally:
a) Should 'git stripspace --comment-lines' really leave the trailing
whitespace alone (example: ' hello  '->'# hello  ')?
b) In the documentation there is:
"-s, --strip-comments
           Skip and remove all lines starting with comment character (default #)."

part. This "default" word somehow suggests some new command option that would
allow to change the comment character. Would you accept a patch implementing
this or such functionality is not desired.

Thank you.


 Documentation/git-stripspace.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index c87bfcb..6c6e989 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git stripspace' [-s | --strip-comments] < input
+'git stripspace' [-c | --comment-lines] < input
 
 DESCRIPTION
 -----------
-- 
2.0.1
