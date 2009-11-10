From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: [PATCH] git-update-index.txt: Document the --really-refresh option.
Date: Tue, 10 Nov 2009 19:11:51 +0100
Message-ID: <20091110181151.GC12012@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 19:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7vCD-0007O6-66
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 19:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017AbZKJSLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 13:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756071AbZKJSLt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 13:11:49 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:55687 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbZKJSLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 13:11:49 -0500
Received: by fxm21 with SMTP id 21so301840fxm.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=U17YpUny/+rHjoPAUf3DPhnw6VGIDBm2IZbgi+65Ods=;
        b=e8QhV6A6AJ6c+OttZiAstE2l7AnnVOS9qKUAOD/4Rbs/mxxBnW6e+TsjnUx4XG7NDC
         wnndSala2AugoPnC20g2zOvEaO++prxXCPSagux2TsgjLu0nNsDnBUL0UBO4CG8+2KTh
         vwUPZ1mFe4UbUx1tXWCJKHsNCTuD3DnAUZTwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=ZY/2bru+9L2igcOZ+dED5bVl14AlH54WqfG6pTXxG5gU5llG90yCDYnE4lsRcz6VG3
         g60mvTfwdaBvswHCf07qTdfTbzph1FvZjmKZonG7Khk5YqnTlu1R5PyrRUwTOCoRqERU
         VK0eGgsAW8kSljyZWkbChPv+lVsFHB/FqO59M=
Received: by 10.204.34.13 with SMTP id j13mr434262bkd.32.1257876713604;
        Tue, 10 Nov 2009 10:11:53 -0800 (PST)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id 18sm1485687fkq.7.2009.11.10.10.11.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 10:11:52 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132582>


Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
I sent this patch last week, but it seems to somehow have got lost amon=
g
other mails. Of course it's nothing fabulous, still I expect at least
somebody to tell me I'm not making any sense ;-)

 =C5=A0t=C4=9Bp=C3=A1n


Original message:

I noticed that --really-refresh is included in SYNOPSIS, but otherwise
undocumented, although mentioned in the text and example.
This is an attempt at fixing that.

 Documentation/git-update-index.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 25e0bbe..6052484 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -99,6 +99,10 @@ in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
 you will need to handle the situation manually.
=20
+--really-refresh::
+	Like '--refresh', but checks stat information unconditionally,
+	without regard to the "assume unchanged" setting.
+
 -g::
 --again::
 	Runs 'git-update-index' itself on the paths whose index
@@ -308,7 +312,7 @@ Configuration
 -------------
=20
 The command honors `core.filemode` configuration variable.  If
-your repository is on an filesystem whose executable bits are
+your repository is on a filesystem whose executable bits are
 unreliable, this should be set to 'false' (see linkgit:git-config[1]).
 This causes the command to ignore differences in file modes recorded
 in the index and the file mode on the filesystem if they differ only o=
n
--=20
1.6.5.2.74.g610f9.dirty
