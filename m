From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Mon, 8 Jan 2007 20:25:25 -0800 (PST)
Message-ID: <351088.61033.qm@web31801.mail.mud.yahoo.com>
References: <1168134747394-git-send-email-jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-528781317-1168316725=:61033"
Content-Transfer-Encoding: 8bit
Cc: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 09 05:25:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H48YD-0002Lx-TY
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 05:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbXAIEZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 23:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXAIEZ1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 23:25:27 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:31648 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751039AbXAIEZ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jan 2007 23:25:26 -0500
Received: (qmail 61778 invoked by uid 60001); 9 Jan 2007 04:25:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WwS17vdffS5kE0DVZhHv7HIeFgfLxE34CkVm5jYArShBJ86BXOSdfZI848JVBRzXzEITM21c2QykzDC32oc9P/BxsDK0OseF8uCcQkgtt+XrgJUbdfpL03XZFdscY1c9cL69DdK+hu7DZl+fa43LreB+dBBeDpIE+6B2k2w5n6E=;
X-YMail-OSG: X.JrMQkVM1mFetel1xxEFaWYb.02rjezAl7o8CLc0knl4wfBt1vlrE64L7mHRISQlqzEvDulH_UeYg0QJScOIuyNqvz7WOYVRi_ewIui_.QCTrEi.f76iyN8vlGmbfN.bZVu_K49t4Y-
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Mon, 08 Jan 2007 20:25:25 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <1168134747394-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36307>

--0-528781317-1168316725=:61033
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Ok, I see that Junio has committed the fixes to "next" -- thanks!
That saved me time having to manually apply them.

Now, the results are that I see the same bug.

gitweb and gitcore as reported by the xml header
is 1.4.4.4.g7c5d, which is "next" as of a few minutes
ago, merged over twice into my branchA and branchB
(names changed).

The commit that fails looks is the attachment
with names and contents changed to protect the
innocent.

The complaint Firefox 2.0.0.1 says is the err.txt
file attached.

    Luben



--0-528781317-1168316725=:61033
Content-Type: text/plain; name="err.txt"
Content-Description: 3446761547-err.txt
Content-Disposition: inline; filename="err.txt"

XML Parsing Error: mismatched tag. Expected: </div>.
Location: http://lion.vitesse.com/git/?p=vhal.git;a=commitdiff;h=b4e81df5f58bc24bb690b5b3687fd36180e071b8;hp=bd5f8325508ee5151d84d65f50b72fd7f3ecc77a
Line Number 95, Column 3:

</body>
--^

--0-528781317-1168316725=:61033
Content-Type: text/plain; name="diff.txt"
Content-Description: 28319668-diff.txt
Content-Disposition: inline; filename="diff.txt"

$ git-diff-tree -r --no-commit-id --patch-with-raw --full-index b4e81df5f58bc24bb690b5b3687fd36180e071b8 > /tmp/diff.txt

:100644 100644 a4bf8891fc1153946b2d1531fdfe09f53a532c65 28929eb48708d0bc33d4c80c4349e753332ea4e1 M	fileA
:000000 100644 0000000000000000000000000000000000000000 36dec28bfc5ec04cff264fd1b7c4b47ab7bad3e3 A	fileB
:100644 000000 36dec28bfc5ec04cff264fd1b7c4b47ab7bad3e3 0000000000000000000000000000000000000000 D	fileC

diff --git a/fileA b/fileA
index a4bf8891fc1153946b2d1531fdfe09f53a532c65..28929eb48708d0bc33d4c80c4349e753332ea4e1 100644
--- a/fileA
+++ b/fileA
@@ -1,6 +1,6 @@

... one line change ...

diff --git a/fileB b/fileB
new file mode 100644
index 0000000000000000000000000000000000000000..36dec28bfc5ec04cff264fd1b7c4b47ab7bad3e3
--- /dev/null
+++ b/fileB
@@ -0,0 +1,89 @@

... it is obvious what happened here ...

diff --git a/fileC b/fileC
deleted file mode 100644
index 36dec28bfc5ec04cff264fd1b7c4b47ab7bad3e3..0000000000000000000000000000000000000000
--- a/fileC
+++ /dev/null
@@ -1,89 +0,0 @@

... again it is obvious what happened here ...


--0-528781317-1168316725=:61033--
