From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/17] Documentation: tweak description of log.date
Date: Fri, 20 Aug 2010 05:20:36 -0500
Message-ID: <20100820102036.GA10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOjw-0006zU-R2
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab0HTKWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:22:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55105 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab0HTKWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:22:19 -0400
Received: by iwn5 with SMTP id 5so675343iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qSCvN2/OvXePpIwesZgG2oYnM6F1LUqReCtIvOqc0pQ=;
        b=KQULe48bWQ9k5GP5Wieklb7EYfWLdhQyMYE8jwtoNlvHdOz6lpcuybD5B8kDAZs+Zl
         S+XtqzRenHUUZ1bjzwazS/ZSveANMbaUxFRUIoQW0E7Vl25MbDDI+qlFBGhhaulxSIXI
         kA4OVtABrfKQvzDak9mYX1ZI1szSjF+y8bmsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LxfX6SIwnX5s88oBet5lYLe9AuiW7UgHhmtujI+cGf87MJV0nrFlJ4cT6h50pozBIs
         6AiPxxBXTSUueDB01umf6QrPvNWc0WfoBIMEAkaT2fvLN2S2ejlsKjLH6S9cv7lj5J3x
         8GhUl47Np1+S1lg59oLfIZAytYzQP1RFQireM=
Received: by 10.231.172.205 with SMTP id m13mr1465246ibz.35.1282299738523;
        Fri, 20 Aug 2010 03:22:18 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm2487905ibe.11.2010.08.20.03.22.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:22:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153996>

The markup "'git log'\'s" produces a stray backslash in the
produced man page.  Removing the backslash fixes it.

While at it, tweak the surrounding description for readability.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..72cb2c9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1289,10 +1289,11 @@ interactive.singlekey::
 	ignored if portable keystroke input is not available.
=20
 log.date::
-	Set default date-time mode for the log command. Setting log.date
-	value is similar to using 'git log'\'s --date option. The value is on=
e of the
-	following alternatives: {relative,local,default,iso,rfc,short}.
-	See linkgit:git-log[1].
+	Set the default date-time mode for the 'log' command.
+	Setting a value for log.date is similar to using 'git log''s
+	`\--date` option.  Possible values are `relative`, `local`,
+	`default`, `iso`, `rfc`, and `short`; see linkgit:git-log[1]
+	for details.
=20
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
--=20
1.7.2.2.536.g42dab.dirty
