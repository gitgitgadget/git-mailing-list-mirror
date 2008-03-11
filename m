From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [PATCH] Specified the expected formats of dates and timestamps in rev-list-options.
Date: Mon, 10 Mar 2008 23:41:48 -0400
Message-ID: <FC7C7E68-1D91-4719-9D11-8F65DEA43AFB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 04:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYvNy-0006SC-OW
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbYCKDlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 23:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbYCKDlz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 23:41:55 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:52448 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbYCKDly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 23:41:54 -0400
Received: by py-out-1112.google.com with SMTP id u52so3268913pyb.10
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=UVicGPni6ckoivrnIVReFAjvjsmR/7S+Nv98Z9BymSM=;
        b=mHOZhQP2S3AU2mHhtA21mUHj/K96BtvJPooUIcmP7NEolYnty2T4Agc5VKbUoucoigPlf+Vx2MMeKElw5sQN0AwKn8dB8Bsi+M1hgwSXHEX7fjhU2ubDRkjJD/JKewg8I9Ca007Z8gInV042QDgc+wF4K/MyA7/JP0+oqAl2LPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=CgZMksIDT10s4aijpXIGe16lO30Ep52OyWA4LqBJ7KsjCjE6TsZcLlmoCFXS8tGKsKVIA/krk1vxt7W1KBulMGdxCdr9AKcTW513IQPfR0uwqScFyoBliFooRH3lCvVJOmguJ6mK0v00+5odR8sSnIJVs/Wc3tloqMrwkJznptk=
Received: by 10.35.102.1 with SMTP id e1mr9076551pym.57.1205206911578;
        Mon, 10 Mar 2008 20:41:51 -0700 (PDT)
Received: from ?192.168.1.103? ( [71.126.228.202])
        by mx.google.com with ESMTPS id 3sm12388303wrh.6.2008.03.10.20.41.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 20:41:50 -0700 (PDT)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76793>

The docs didn't give users any indication of the expected format of  
dates or timestamps. Now they do.

---

Documentation/rev-list-options.txt |    9 +++++++--
1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev- 
list-options.txt
index a8138e2..bf0b881 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -124,15 +124,20 @@ limiting may be applied.

--since='date', --after='date'::

-	Show commits more recent than a specific date.
+	Show commits more recent than a date specified relatively
+	(e.g. "2 hours ago") or with any ISO 8601 or RFC 2822
+	date syntax.
+

--until='date', --before='date'::

-	Show commits older than a specific date.
+	Show commits older than a date specified relatively (e.g.
+	"2 hours ago") or with any ISO 8601 or RFC 2822 date syntax.

--max-age='timestamp', --min-age='timestamp'::

	Limit the commits output to specified time range.
+	The 'timestamp' should be the interger seconds since the epoch.

--author='pattern', --committer='pattern'::

-- 
1.5.4.1.1278.gc75be
