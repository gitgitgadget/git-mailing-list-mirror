From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/24] t9300 (fast-import), series B: re-indent
Date: Fri, 24 Sep 2010 02:18:14 -0500
Message-ID: <20100924071814.GJ4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2ak-0000W1-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab0IXHVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:21:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50866 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab0IXHVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:21:03 -0400
Received: by gwj17 with SMTP id 17so858267gwj.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=l6lr2o9slRqshtDnHuR7AkDcR0Pg9tOjzi1dZR6kWo0=;
        b=d26c7XfqZspZxVJjKxwGuuSUvHhjAzzEBhD6cQPxN1kKlmIP4NyQ4lcnmBG6fMyq0S
         hQOcZUhg5s2g3kNJlug+AJHrhkZwHwj4WVMwZPlAg7/ey0bOndsHNofvznLUrWoFK8pj
         3b53GT0yCgeXekh+W9hD7zwQHIuNCchSkzACg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vx1x3F2Vt0mdWjCDNIrdTntmeNZT4nd/5pjJzzo9bbN1CaeStXPyAcepDIe+qmNsie
         DFNTW3HQXEp7ZPlK8HF8hImvCu+xFcQE/0pzhqniSaAa0Y91ck8J7AQlwJVoxrC+owEC
         nhgIjAMbmdlPBOmLZ5CPONvuU0Y1KDDZ+4cQY=
Received: by 10.150.220.9 with SMTP id s9mr4274530ybg.101.1285312861215;
        Fri, 24 Sep 2010 00:21:01 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm751752yba.0.2010.09.24.00.21.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:21:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156943>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 10dc720..a2b8950 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -319,11 +319,11 @@ COMMIT
 from refs/heads/master
 
 INPUT_END
-test_expect_success \
-	'B: accept branch name "TEMP_TAG"' \
-	'git fast-import <input &&
-	 test -f .git/TEMP_TAG &&
-	 test `git rev-parse master` = `git rev-parse TEMP_TAG^`'
+test_expect_success 'B: accept branch name "TEMP_TAG"' '
+	git fast-import <input &&
+	test -f .git/TEMP_TAG &&
+	test `git rev-parse master` = `git rev-parse TEMP_TAG^`
+'
 rm -f .git/TEMP_TAG
 
 ###
-- 
1.7.2.3
