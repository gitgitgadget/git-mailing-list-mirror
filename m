From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: [PATCH] Documentation: boolean value may be given by on/off
Date: Fri, 17 Apr 2009 22:34:25 +0200
Message-ID: <20090417223425.1abb78fa@gmail.com>
References: <7v1vrtno9z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luun7-0000My-IL
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 22:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZDQUec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbZDQUeb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 16:34:31 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:40522 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZDQUeb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 16:34:31 -0400
Received: by bwz7 with SMTP id 7so321484bwz.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=E1AdcDJcvDSP26VPUi+TmkdLme2PkSfrse/VRBDHdeA=;
        b=mnhs6G3HefOq+koPod/8kzAx+3lmTPv5POiO9t9z3iaBclvSgqBokNzYeOiRzHQXYN
         6SsxKRK3Q9mLL31FRkAr7TNeTAxc1/1njHGrqCqUi1NoapyLqSILP7UEk6xu0Uk4dNgo
         hetKTfKQlqFVP1z90l3URiK/kTBblZf72lGyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=t8uSYckDGj57cxHDQbL8qwKzJi17NEYsLHsuZe5nzyvc0VEhxwAzC5lWPeBVDIEfnL
         eQlVHnz/4aB4dZTt8QyNczZS6v7XfgTbK+iGce6w7slqr7QKAENgwRvnb8aggEWnFIQr
         8/h5kLCv3s7AO7m4rSWubw0OcjUCAp6gZfRkA=
Received: by 10.204.103.209 with SMTP id l17mr2656400bko.152.1240000469083;
        Fri, 17 Apr 2009 13:34:29 -0700 (PDT)
Received: from localhost (87-205-51-134.adsl.inetia.pl [87.205.51.134])
        by mx.google.com with ESMTPS id y15sm4058867fkd.19.2009.04.17.13.34.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Apr 2009 13:34:28 -0700 (PDT)
In-Reply-To: <7v1vrtno9z.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116787>

Junio C Hamano <gitster@pobox.com> wrote:

> ----------------------------------------------------------------
> [Stalled and may need help and prodding to go forward]
>=20
> * lt/bool-on-off (Thu Apr 9 12:40:39 2009 -0700) 1 commit
>  + Allow users to un-configure rename detection
>=20
> Still lacks doc updates.
>

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/config.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5319df5..1c64683 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -61,7 +61,7 @@ Internal whitespace within a variable value is retain=
ed verbatim.

 The values following the equals sign in variable assign are all either
 a string, an integer, or a boolean.  Boolean values may be given as ye=
s/no,
-0/1 or true/false.  Case is not significant in boolean values, when
+0/1, true/false or on/off.  Case is not significant in boolean values,=
 when
 converting value to the canonical form using '--bool' type specifier;
 'git-config' will ensure that the output is "true" or "false".

@@ -945,8 +945,8 @@ guitool.<name>.argprompt::
        Request a string argument from the user, and pass it to the too=
l
        through the 'ARGS' environment variable. Since requesting an
        argument implies confirmation, the 'confirm' option has no effe=
ct
-       if this is enabled. If the option is set to 'true', 'yes', or '=
1',
-       the dialog uses a built-in generic prompt; otherwise the exact
+       if this is enabled. If the option is set to 'true', 'yes', 'on'=
 or
+       '1', the dialog uses a built-in generic prompt; otherwise the e=
xact
        value of the variable is used.

 guitool.<name>.revprompt::
--=20
1.6.0.6
