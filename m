From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Thu, 10 Jul 2008 16:31:06 +0100
Message-ID: <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com>
	 <200807070116.39892.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:37:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyCR-0006Tc-Gv
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbYGJPbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758334AbYGJPbJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:31:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:18036 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbYGJPbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:31:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4026279rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K3hroID5hqAom8eOJUQXNVhGEbng668hqK6rs7EkUkY=;
        b=Hg1n7qk1GaJDLf+K/qhM95BXLmlEFEPeZtrqEVQTkFDz/Y3dD4Lk1H3pLETIt/OARS
         IBUEHsRLrmVUMYPzDHUea2uhq9aSZ1I3Wn30xovn1cO3w4zKRHuzzG22wrAo0dM9RZ2A
         aejbuwnejFCLvripcC+YKC91vqFj5lnyOaxPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EuBTFNYaZ55RDydw2x780vXYXIESdhpBPWMPmCicG03pVcMmhK7iHIPYIjCmLrU7nX
         ise4jkZvYGOYvpcojOlII0v9yGATHZQ7h6tdDpGBtrI3riBaMd1xToHARtOf/rFzZ0tw
         4iSNpqZK7d9S79XujY+/mVqi3TUVZ6Lmdr15U=
Received: by 10.141.136.8 with SMTP id o8mr4831136rvn.271.1215703867061;
        Thu, 10 Jul 2008 08:31:07 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Thu, 10 Jul 2008 08:31:06 -0700 (PDT)
In-Reply-To: <200807070116.39892.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87983>

2008/7/7 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
>
> This command allows us to create simple or annotated tags.
> PGP signed tags are not yet supported.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

Apologies this will be whitespace damaged, but it's trivial.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
b/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
index 110db6b..a215fbd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
@@ -47,6 +47,8 @@ class Tag extends TextBuiltin {
                String message = null;
                String ref = "HEAD";
                boolean force = false;
+               if (args.length == 0)
+                       usage();
                for (int i = 0; i < args.length; ++i) {
                        if (args[i].equals("-f")) {
                                force = true;
@@ -97,6 +99,6 @@ class Tag extends TextBuiltin {
        }

        private void usage() {
-               throw die("Usage: -m message tag [head]");
+               throw die("Usage: [-m message] [-f] tag [head]");
        }
 }

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Loving the make_jgit stuff.

Mike
