From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: [PATCH v2] CodingGuidelines: Add a section on writing documentation
Date: Thu, 04 Nov 2010 18:12:48 +0100
Message-ID: <87lj59gghb.fsf_-_@gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
	<AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
	<87wrp12p00.fsf@gmail.com>
	<AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
	<87fwvl2d4d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 18:15:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3PB-0001iv-Lx
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab0KDROW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 13:14:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64136 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab0KDROU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:14:20 -0400
Received: by bwz11 with SMTP id 11so1863188bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=xNbGaN7W4IOCiSo/woPxfj2/vWF9pomtZP1nrOToVow=;
        b=imnpngbQccFQYF5WaWEDo1YGpy37Tsc0UM7Z9JhsWhablWjzL+dU9QI2f2Le83mQPf
         rCBOQuJsZkNHILKeKaxCat/tYdeVBMV3fbU1jVq8AS+M2tbeEMaeSBrTURpPItB+Mxfk
         TY2/wy65OY5gyRgp8q9S6xfC7XyLHdP2j5n54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=BPAPpcfNv0H9GtQ4rQn91oy7pEWPzHWxoZBPd7VMt3qeJtaVbNVSkz/936fqY8Tp4+
         mwlYr/h4LUbYpqJg8K7Li9zxzbLDyC4za4H8gwbpB3C5RnPlNsu+muKkRE6gd2JUBn5i
         wqCKF6mJmsHx9DXPeLOLYCu92pwAYoql2BJ5E=
Received: by 10.204.103.66 with SMTP id j2mr852243bko.160.1288890859308;
        Thu, 04 Nov 2010 10:14:19 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id d12sm154419bkw.19.2010.11.04.10.14.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 10:14:16 -0700 (PDT)
In-Reply-To: <87fwvl2d4d.fsf@gmail.com> (=?utf-8?B?IsWgdMSbcMOhbiBOxJtt?=
 =?utf-8?B?ZWMiJ3M=?= message of "Mon, 01
	Nov 2010 18:00:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160733>


Provide a few examples on argument and option notation in usage strings
and command synopses.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Changes since the last version:

 - add a separate subsection on vertical bar without parentheses (sugge=
sted
   by Mark Lodato)

 - do not include the <thing>{M,N} usage for fixed number of occurences
   (Mark Lodato and Sverre Rabbelier)
=20
 Documentation/CodingGuidelines |   52 ++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index 09ffc46..5aa2d34 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -139,3 +139,55 @@ For C programs:
=20
  - When we pass <string, length> pair to functions, we should try to
    pass them in that order.
+
+Writing Documentation:
+
+ Every user-visible change should be reflected in the documentation.
+ The same general rule as for code applies -- imitate the existing
+ conventions.  A few commented examples follow to provide reference
+ when writing or modifying command usage strings and synopsis sections
+ in the manual pages:
+
+ Placeholders are enclosed in angle brackets:
+   <file>
+   --sort=3D<key>
+   --abbrev[=3D<n>]
+
+ Possibility of multiple occurences is indicated by three dots:
+   <file>...
+   (One or more of <file>.)
+
+ Optional parts are enclosed in square brackets:
+   [<extra>]
+   (Zero or one <extra>.)
+
+   --exec-path[=3D<path>]
+   (Option with an optional argument.  Note that the "=3D" is inside t=
he
+   brackets.)
+
+   [<patch>...]
+   (Zero or more of <patch>.  Note that the dots are inside, not
+   outside the brackets.)
+
+ Multiple alternatives are indicated with vertical bar:
+   [-q | --quiet]
+   [--utf8 | --no-utf8]
+
+ Parentheses are used for grouping:
+   [(<rev>|<range>)...]
+   (Any number of either <rev> or <range>.  Parens are needed to make
+   it clear that "..." pertains to both <rev> and <range>.)
+
+   [(-p <parent>)...]
+   (Any number of option -p, each with one <parent> argument.)
+
+   git remote set-head <name> (-a | -d | <branch>)
+   (One and only one of "-a", "-d" or "<branch>" _must_ (no square
+   brackets) be provided.)
+
+ And a somewhat more contrived example:
+   --diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]
+   Here "=3D" is outside the brackets, because "--diff-filter=3D" is a
+   valid usage.  "*" has its own pair of brackets, because it can
+   (optionally) be specified only when one or more of the letters is
+   also provided.
--=20
1.7.3.rc2.221.gbf93f.dirty
