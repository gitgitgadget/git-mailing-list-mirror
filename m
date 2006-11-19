X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Patch to tutorial.txt
Date: Sun, 19 Nov 2006 23:44:50 +0100
Message-ID: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 19 Nov 2006 22:45:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lbX/8IV2zOsLJTZPd9pECMy9lg5Ad1hVBuocI3WCvzXYhYEX7KkfkycdILsrJE61+kgDwHqwxoPZllDyfyOKl16YN32ANkrPinUNf+7YFAPOt/M5pzS11CvlfGHE/2wzjkVi/mY8o38W47t4efFen5HJ7tR6PBoVP1mtuQGLvr8=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31869>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlvPI-0002fS-Kn for gcvg-git@gmane.org; Sun, 19 Nov
 2006 23:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933579AbWKSWox convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933604AbWKSWox
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 17:44:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:1825 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S933579AbWKSWow
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006
 17:44:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2099165nfa for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 14:44:50 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr4561463huf.1163976290446; Sun, 19
 Nov 2006 14:44:50 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Sun, 19 Nov 2006 14:44:50 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi all,
I'm reading the tutorial and trying to improve it while studying git.

=46irst attempt here:
=46rom 0b98769dfe16e3ba8cde698b75cb1067658c38e7 Mon Sep 17 00:00:00 200=
1
=46rom: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Date: Sun, 19 Nov 2006 23:41:31 +0100
Subject: [PATCH] One of the comment was not really clear, rephrased to
make it easier to be understood by the reader


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 554ee0a..6edfb5a 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -141,7 +141,7 @@ $ git commit -a
 ------------------------------------------------

 at this point the two branches have diverged, with different changes
-made in each.  To merge the changes made in the two branches, run
+made in each.  To merge the changes made in experimental into master r=
un

 ------------------------------------------------
 $ git pull . experimental
--=20
1.4.4.ge3d4


Regards,
--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
