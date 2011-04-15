From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] Documentation: hints for sending patches inline with
 Thunderbird
Date: Thu, 14 Apr 2011 21:28:06 -0500
Message-ID: <20110415022806.GD19829@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>,
	Jeremy White <jwhite@codeweavers.com>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:28:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYle-0005wo-JI
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 04:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab1DOC2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 22:28:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64233 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab1DOC2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 22:28:12 -0400
Received: by iwn34 with SMTP id 34so1882715iwn.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=m4rapQ+Wr0IemoDArG/WKATQzekaXXW/87Pio5TITaE=;
        b=O9JjA9CTYoFU5U4PVN3m5uadMHOEU7/3+ePVB0ep2Xx2lqNQ4SdSY6BqBClrLmWfQs
         nkSdGsTqm5H/Sy+MUaDCrJ4YEg28sTMbxiLTIahi4mdKNpf+bVOgov17ViOW+m1C7ndG
         IeqnS2aJxVwGVhKO0KgGo/jYy2C4tIm2O8fDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f2o8PmhK8BAspN9Gnitowvp8/EeS1QjfN3DG2e1d4hHkQHPb2TOGK7jCLD5CnF1N0V
         8LBCyWBYRkwvgwyAcHg5Gs7IY0whxRh/2C0vbeGomp3DaJ9ANYvvEbEXZ/PM2vaUUs9x
         fbK9uN49Ton9MC+amJYcrLK+1LA9JHZe6FaY8=
Received: by 10.42.108.138 with SMTP id h10mr2062975icp.339.1302834491566;
        Thu, 14 Apr 2011 19:28:11 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id xg14sm1447847icb.19.2011.04.14.19.28.09
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 19:28:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110415021100.GA19829@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171579>

The standard reference for this information is the article
"Plain text e-mail - Thunderbird#Completely_plain_email" at
kb.mozillazine.org, but the hints hidden away in git's
SubmittingPatches file are more complete.  Move them to the
"git format-patch" manual so they can be installed with git and
read by a wide audience.

While at it, make some tweaks:

 - update "Approach #1" so it might work with Thunderbird 3;
 - remove ancient version numbers from the descriptions of both
   approaches so current readers might have more reason to
   complain if they don't work.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As mentioned in the cover letter, this is rough.  Help making it
accurate and consistent with git-imap-send(1) would be very much
appreciated.

 Documentation/SubmittingPatches    |   81 +---------------------------=
-------
 Documentation/git-format-patch.txt |   83 ++++++++++++++++++++++++++++=
++++++++
 2 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index 20b4101..7908119 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -416,86 +416,7 @@ it.
 Thunderbird
 -----------
=20
-(A Large Angry SCM)
-
-By default, Thunderbird will both wrap emails as well as flag them as
-being 'format=3Dflowed', both of which will make the resulting email u=
nusable
-by git.
-
-Here are some hints on how to successfully submit patches inline using
-Thunderbird.
-
-There are two different approaches.  One approach is to configure
-Thunderbird to not mangle patches.  The second approach is to use
-an external editor to keep Thunderbird from mangling the patches.
-
-Approach #1 (configuration):
-
-This recipe is current as of Thunderbird 2.0.0.19.  Three steps:
-  1.  Configure your mail server composition as plain text
-      Edit...Account Settings...Composition & Addressing,
-        uncheck 'Compose Messages in HTML'.
-  2.  Configure your general composition window to not wrap
-      Edit..Preferences..Composition, wrap plain text messages at 0
-  3.  Disable the use of format=3Dflowed
-      Edit..Preferences..Advanced..Config Editor.  Search for:
-        mailnews.send_plaintext_flowed
-      toggle it to make sure it is set to 'false'.
-
-After that is done, you should be able to compose email as you
-otherwise would (cut + paste, git-format-patch | git-imap-send, etc),
-and the patches should not be mangled.
-
-Approach #2 (external editor):
-
-This recipe appears to work with the current [*1*] Thunderbird from Su=
se.
-
-The following Thunderbird extensions are needed:
-	AboutConfig 0.5
-		http://aboutconfig.mozdev.org/
-	External Editor 0.7.2
-		http://globs.org/articles.php?lng=3Den&pg=3D8
-
-1) Prepare the patch as a text file using your method of choice.
-
-2) Before opening a compose window, use Edit->Account Settings to
-uncheck the "Compose messages in HTML format" setting in the
-"Composition & Addressing" panel of the account to be used to send the
-patch. [*2*]
-
-3) In the main Thunderbird window, _before_ you open the compose windo=
w
-for the patch, use Tools->about:config to set the following to the
-indicated values:
-	mailnews.send_plaintext_flowed	=3D> false
-	mailnews.wraplength		=3D> 0
-
-4) Open a compose window and click the external editor icon.
-
-5) In the external editor window, read in the patch file and exit the
-editor normally.
-
-6) Back in the compose window: Add whatever other text you wish to the
-message, complete the addressing and subject fields, and press send.
-
-7) Optionally, undo the about:config/account settings changes made in
-steps 2 & 3.
-
-
-[Footnotes]
-*1* Version 1.0 (20041207) from the MozillaThunderbird-1.0-5 rpm of Su=
se
-9.3 professional updates.
-
-*2* It may be possible to do this with about:config and the following
-settings but I haven't tried, yet.
-	mail.html_compose			=3D> false
-	mail.identity.default.compose_html	=3D> false
-	mail.identity.id?.compose_html		=3D> false
-
-(Lukas Sandstr=C3=B6m)
-
-There is a script in contrib/thunderbird-patch-inline which can help
-you include patches with Thunderbird in an easy way. To use it, do the
-steps above and then use the script as the external editor.
+See the MUA-SPECIFIC HINTS section of git-format-patch(1).
=20
 Gnus
 ----
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 5c60418..cbf2b9c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -332,6 +332,89 @@ If it does not apply correctly, there can be vario=
us reasons.
   patch e-mail should come after the three-dash line that signals
   the end of the commit message.
=20
+MUA-SPECIFIC HINTS
+------------------
+Here are some hints on how to successfully submit patches inline using
+various mailers.
+
+Thunderbird
+~~~~~~~~~~~
+By default, Thunderbird will both wrap emails as well as flag
+them as being 'format=3Dflowed', both of which will make the
+resulting email unusable by git.
+
+There are two different approaches.  One approach is to configure
+Thunderbird to not mangle patches.  The second approach is to use
+an external editor to keep Thunderbird from mangling the patches.
+
+Approach #1 (configuration)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Three steps:
+
+1. Configure your mail server composition as plain text:
+   Edit...Account Settings...Composition & Addressing,
+   uncheck "Compose Messages in HTML".
+
+2. Configure your general composition window to not wrap.
++
+In Thunderbird 2:
+Edit..Preferences..Composition, wrap plain text messages at 0
++
+In Thunderbird 3:
+Edit..Preferences..Advanced..Config Editor.  Search for
+"mail.wrap_long_lines".
+Toggle it to make sure it is set to `false`.
+
+3. Disable the use of format=3Dflowed:
+Edit..Preferences..Advanced..Config Editor.  Search for
+"mailnews.send_plaintext_flowed".
+Toggle it to make sure it is set to `false`.
+
+After that is done, you should be able to compose email as you
+otherwise would (cut + paste, 'git format-patch' | 'git imap-send', et=
c),
+and the patches will not be mangled.
+
+Approach #2 (external editor)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The following Thunderbird extensions are needed:
+AboutConfig from http://aboutconfig.mozdev.org/ and
+External Editor from http://globs.org/articles.php?lng=3Den&pg=3D8
+
+1. Prepare the patch as a text file using your method of choice.
+
+2. Before opening a compose window, use Edit->Account Settings to
+   uncheck the "Compose messages in HTML format" setting in the
+   "Composition & Addressing" panel of the account to be used to
+   send the patch.
+
+3. In the main Thunderbird window, 'before' you open the compose
+   window for the patch, use Tools->about:config to set the
+   following to the indicated values:
++
+----------
+	mailnews.send_plaintext_flowed  =3D> false
+	mailnews.wraplength             =3D> 0
+----------
+
+4. Open a compose window and click the external editor icon.
+
+5. In the external editor window, read in the patch file and exit
+   the editor normally.
+
+Side note: it may be possible to do step 2 with
+about:config and the following settings but no one's tried yet.
+
+----------
+	mail.html_compose                       =3D> false
+	mail.identity.default.compose_html      =3D> false
+	mail.identity.id?.compose_html          =3D> false
+----------
+
+There is a script in contrib/thunderbird-patch-inline which can help
+you include patches with Thunderbird in an easy way. To use it, do the
+steps above and then use the script as the external editor.
+
=20
 EXAMPLES
 --------
--=20
1.7.5.rc0
