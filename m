From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: [PATCH] CodingGuidelines: Add a section on writing documentation
Date: Sun, 24 Oct 2010 17:51:22 +0200
Message-ID: <20101024155121.GA9503@headley>
References: <20101021222129.GA13262@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 17:52:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA2sK-0007HG-CM
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 17:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906Ab0JXPwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 11:52:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49239 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab0JXPwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 11:52:42 -0400
Received: by bwz11 with SMTP id 11so1749988bwz.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UOeXNTiDIbcygffy1Yg0hhnn6uGv1muEuimJ44DI34Y=;
        b=LAsExQPmRpJKWhctrSpeLqwBJgAPsieqfqb7dRh7ogv/W4cyTO3O58Isx+rtwBcywR
         VwporTc9Syu25jCmurOKGlMTyY1LOzVLgKbSK2lEdvJdqkvZPu7hZblrhZR9cbmy5tEY
         FhktK9/Qdb00ExB5S23wV2slz5RiV4ePSRT6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bTbOHon7l3yexCZrRnPaUeu8Lcel7fNmq+Kgt3s4u+MAYmyToUV+cl7UpJAScMWMP0
         7dS1kJjRR/kmVWJfK/2C5iQEXYYKGxpQaPwoLq8xc42Uyi9KeGG70O43x6yJOYup71Ss
         dgLqediAtCEsEi4zBgSx8st54t0A7nC7dUPsA=
Received: by 10.204.24.144 with SMTP id v16mr4160378bkb.137.1287935559257;
        Sun, 24 Oct 2010 08:52:39 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id d27sm3983061bkw.14.2010.10.24.08.52.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 08:52:38 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Disposition: inline
In-Reply-To: <20101021222129.GA13262@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159881>

Provide a few examples on argument and option notation in usage strings
and command synopses.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
Jonathan Nieder <jrnieder@gmail.com> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

[...]

>> I can try to compile an initial version of such a document, based on=
 the
>> commit message of the original single-patch version
>> (<http://article.gmane.org/gmane.comp.version-control.git/158467>) a=
nd
>> including some more cases/examples.
>>=20
>> Where do you think would be the most appropriate place for it?
>> Just add a section to CodingGuidelines, or a separate
>> Documentation/WritingGuidelines or something?
>
> Sorry for the slow response.  Documentation/CodingGuidelines makes se=
nse
> to me, since it affects the usage strings in code.

Thanks, here's a patch.

 Documentation/CodingGuidelines |   53 ++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index 09ffc46..0ac7aac 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -139,3 +139,56 @@ For C programs:
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
+ Parentheses are used for grouping, often combined with vertical bar
+ to indicate alternatives:
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
+ Specific number of occurences is indicated as follows:
+   <commit>{0,2}
+   (Up to two <commit>s.)
+
+ And a somewhat more contrived example:
+   --diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]
+   Here "=3D" is outside the brackets, because "--diff-filter=3D" is a
+   valid usage.  "*" has its own pair of brackets, because it can
+   (optionally) be specified only when one or more of the letters is
+   also provided.
--=20
1.7.3.rc2.221.gbf93f.dirty
