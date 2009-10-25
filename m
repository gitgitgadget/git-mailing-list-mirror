From: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 3/3] format-patch documentation: Fix formatting
Date: Sun, 25 Oct 2009 19:47:21 +0100
Message-ID: <4AE49D39.7000904@gmail.com>
References: <4AE47546.6040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N288K-0008VX-Oj
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZJYSrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbZJYSrU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:47:20 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:63319 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbZJYSrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:47:19 -0400
Received: by ewy4 with SMTP id 4so3052373ewy.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=iOG0EA6SFW+6lB4JUrb/uTbI7yWz3Q0DUi7v9acNePU=;
        b=U1R51snTEru3P7bn1zXi094IITDbP2HdiK3K373/a7YrPbJYEl+kET3zu9mWj5ZbtD
         2t+BsVfacI5Mi9/mszTZMAta7QunySwQ80aZVpLGTQE3WVWqjKs251c2y+bh0UU0Es+c
         VBMd6iTz8ZX9luNJZbTevOPwoEFYfBXzB1VJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uqoBMp9fShvwtHPBX8LcAdHIIXOgkW5UcBPEO1WEXJkjmF15F9kuDA3PlVepI95Q7o
         c8bDOz/PfGJcvOMuJmL80ZkiIeW7i2SnJjnk36gdB/NDlox8+0vqFG9PP63lNFYeO+wt
         /ZNrT/ya+FRa+ZqCWRgbHwP+4qIq1Yxg8b5oQ=
Received: by 10.211.155.11 with SMTP id h11mr3900421ebo.62.1256496442991;
        Sun, 25 Oct 2009 11:47:22 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm1499980eye.39.2009.10.25.11.47.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:47:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <4AE47546.6040804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131234>

Bj=F6rn Gustavsson wrote:
> Format git commands and options consistently using back quotes
> (i.e. a fixed font in the resulting HTML document).

I missed a few places. Here is an additional patch to be applied
on top of the original patch.

I'll send out a new combined patch later, but I'll wait for comments
on the series first.

/Bj=F6rn

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 86d3d80..14265b8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -43,19 +43,19 @@ endif::git-format-patch[]
=20
 --stat[=3Dwidth[,name-width]]::
 	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by "--stat=3Dwidth".
+	output width for 80-column terminal by `--stat=3Dwidth`.
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
=20
 --numstat::
-	Similar to \--stat, but shows number of added and
+	Similar to `\--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.
=20
 --shortstat::
-	Output only the last line of the --stat format containing total
+	Output only the last line of the `--stat` format containing total
 	number of modified files, as well as number of added and deleted
 	lines.
=20
@@ -63,8 +63,8 @@ endif::git-format-patch[]
 	Output the distribution of relative amount of changes (number of line=
s added or
 	removed) for each sub-directory. Directories with changes below
 	a cut-off percent (3% by default) are not shown. The cut-off percent
-	can be set with "--dirstat=3Dlimit". Changes in a child directory is =
not
-	counted for the parent directory, unless "--cumulative" is used.
+	can be set with `--dirstat=3Dlimit`. Changes in a child directory is =
not
+	counted for the parent directory, unless `--cumulative` is used.
=20
 --dirstat-by-file[=3Dlimit]::
 	Same as `--dirstat`, but counts changed files instead of lines.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 79d77f7..f1fd0df 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -160,7 +160,7 @@ will want to ensure that threading is disabled for =
`git send-email`.
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<Subject-Prefix>]'. This
 	allows for useful naming of a patch series, and can be
-	combined with the --numbered option.
+	combined with the `--numbered` option.
=20
 --cc=3D<email>::
 	Add a `Cc:` header to the email headers. This is in addition
