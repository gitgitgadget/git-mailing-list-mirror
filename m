From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: add submodule.* to the big configuration
 variable list
Date: Thu, 15 Jul 2010 02:51:19 -0500
Message-ID: <20100715075119.GB22244@burratino>
References: <4C3DD7EF.6010805@panasas.com>
 <alpine.DEB.2.00.1007150745340.13735@perkele.intern.softwolves.pp.se>
 <20100715074155.GA22244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jul 15 09:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZJEt-00056u-8M
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595Ab0GOHwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 03:52:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56124 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932591Ab0GOHwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:52:08 -0400
Received: by iwn7 with SMTP id 7so713757iwn.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Wa7bNyv2Xm0ruhe+qrZttcjD6iFwM78UNYq/EVvQtQ8=;
        b=PIRO9uwT31iG/G0vRUpIZbKW4b+envIcgf5Oy/aUrlcGsf8rF2DyNCylrsSFjuJsS7
         D4FJTPbcsEyt2rs9vAIVvVeTYh8wEaZmZ9o0gnW3+ACd4R5vki6gPboGC/q2hx/7J6vc
         TODDuRh/TUTah3aRo/7NaJOszbK/vb8HZyECo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=raHQ7Ezvis42Co/r1v8xSluAFrOJLCpNYxdQjjKBGbuyoEM7HCa10YqrpbxQxHb/YS
         nqGn6TIA0lVEPC/W/zTLV5pfk1EVBHpBNqe4Ai2piOWoiSa06/d5kHrlWJRRMm3x+M13
         kJ3qROjbv2+i4Xto4jYtdo970ih568fhoOUq0=
Received: by 10.231.152.210 with SMTP id h18mr13537558ibw.18.1279180328249;
        Thu, 15 Jul 2010 00:52:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm3338481ibh.4.2010.07.15.00.52.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:52:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100715074155.GA22244@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151061>

The url, path, and update items in [submodule "foo"] stanzas are
nicely explained in the .gitmodules and =E2=80=98git submodule=E2=80=99
documentation.  Point there from the config documentation.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
It=E2=80=99s late, so I don=E2=80=99t trust this to be coherent English=
 necessarily.
Thoughts and improvements welcome.

 Documentation/config.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1029bc4..f1fb5ac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1685,6 +1685,15 @@ status.submodulesummary::
 	summary of commits for modified submodules will be shown (see
 	--summary-limit option of linkgit:git-submodule[1]).
=20
+submodule.<name>.path::
+submodule.<name>.url::
+submodule.<name>.update::
+	The path within this project, URL, and updating strategy
+	for a submodule.  These variables are initially populated
+	by 'git submodule init'; edit them to override the
+	URL and other values found in the `.gitmodules` file.  See
+	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
--=20
1.7.2.rc2
