From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/24] t9300 (fast-import), series I: re-indent
Date: Fri, 24 Sep 2010 02:23:51 -0500
Message-ID: <20100924072351.GP4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2g8-0002Oq-LX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0IXH0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:26:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0IXH0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:26:38 -0400
Received: by iwn5 with SMTP id 5so2165045iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fckuxKnqYo/2zD6s86h4GU7BQ1zwVCd3VtJgkus88ao=;
        b=SgqJKs2q4fATRCtzj9lnm2bbnDJygWANlWFS6dmbwEJ7zm8T8tKSAsvicF/OAceEY/
         agk2ALHRQJFKTnzWKrA9lJO5vSKCKdHC6Ob3Q6mIulZ/aez12aCLM4ke767dfz20itI1
         XIhnvW8H9jYYsudXTJqUFZ69gq4CLO+WC8NUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JMFCKNYa3s/VBNDJjDMeXlI74k/mxte6L+InDC/TbxjMo2lk4Iq2Qw4H0MWfwH8E/A
         bH4D2i626DIIx22ouJCPdQ0H5z6aw2varwtnM5jPKxGpgVR2E26Udd76soO91gvlYLy2
         XaZsUWuyDv7J/GQ0U7Z/ytULRAXy9UoQZGuss=
Received: by 10.231.11.3 with SMTP id r3mr3415425ibr.53.1285313198119;
        Fri, 24 Sep 2010 00:26:38 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm1961666ibh.16.2010.09.24.00.26.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:26:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156950>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 875a951..fda1911 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -613,17 +613,17 @@ COMMIT
 from refs/heads/branch
 
 INPUT_END
-test_expect_success \
-	'I: export-pack-edges' \
-	'git fast-import --export-pack-edges=edges.list <input'
+test_expect_success 'I: export-pack-edges' '
+	git fast-import --export-pack-edges=edges.list <input
+'
 
 cat >expect <<EOF
 .git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
 EOF
-test_expect_success \
-	'I: verify edge list' \
-	'sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	 test_cmp expect actual'
+test_expect_success 'I: verify edge list' '
+	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series J
-- 
1.7.2.3
