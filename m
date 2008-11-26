From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: update Japanese translation
Date: Wed, 26 Nov 2008 13:50:31 -0800
Message-ID: <7vskpedumw.fsf@gitster.siamese.dyndns.org>
References: <20081126192144.6117@nanako3.lavabit.com>
 <20081126212828.GA20382@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:52:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5SJB-0002OB-PX
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYKZVvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 16:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbYKZVvL
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:51:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbYKZVvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 16:51:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FE4E81CE8;
	Wed, 26 Nov 2008 16:51:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6B83581CCE; Wed,
 26 Nov 2008 16:50:34 -0500 (EST)
In-Reply-To: <20081126212828.GA20382@spearce.org> (Shawn O. Pearce's message
 of "Wed, 26 Nov 2008 13:28:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 55213B5E-BC04-11DD-94A0-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101773>

--=-=-=

"Shawn O. Pearce" <spearce@spearce.org> writes:

> $ make V=1
> msgfmt --statistics --tcl -l ja -d po/ po/ja.po
> po/ja.po:1558: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:1567: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:1602: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:1883: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:1931: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:1941: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:2342: `msgid' and `msgstr' entries do not both begin with '\n'
> po/ja.po:2455: `msgid' and `msgstr' entries do not both begin with '\n'
> msgfmt: found 8 fatal errors
> make: *** [po/ja.msg] Error 1

Feel free to squash this in; I just removed the extra "\n" at the
beginning of these messages.


--=-=-=
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline; filename=1
Content-Description: po/ja.po fixup

 po/ja.po |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git c/po/ja.po i/po/ja.po
index 0cd6740..8ba6417 100644
--- c/po/ja.po
+++ i/po/ja.po
@@ -1559,7 +1559,6 @@ msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
 msgstr ""
-"\n"
 "LOCAL: 削除\n"
 "Remote:\n"
 
@@ -1568,7 +1567,6 @@ msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
 msgstr ""
-"\n"
 "REMOTE: 削除\n"
 "LOCAL:\n"
 
@@ -1603,7 +1601,6 @@ msgid ""
 "* Untracked file is %d bytes.\n"
 "* Showing only first %d bytes.\n"
 msgstr ""
-"\n"
 "* 管理外のファイルの大きさは %d バイトです。\n"
 "* 最初の %d バイトだけ表示しています。\n"
 
@@ -1887,7 +1884,6 @@ msgid ""
 "\n"
 "This operation can be undone only by restarting the merge."
 msgstr ""
-"\n"
 "競合する変更点だけが表示されていることに注意してください。\n"
 "\n"
 "%s は上書きされます。\n"
@@ -1932,7 +1928,6 @@ msgid ""
 "Error retrieving versions:\n"
 "%s"
 msgstr ""
-"\n"
 "版の取り出し時にエラーが出ました:\n"
 "%s"
 
@@ -1943,7 +1938,6 @@ msgid ""
 "\n"
 "%s"
 msgstr ""
-"\n"
 "マージツールが起動できません:\n"
 "\n"
 "%s"
@@ -2344,7 +2338,6 @@ msgid ""
 "\n"
 "%s"
 msgstr ""
-"\n"
 "ssh-keygen を起動できません:\n"
 "\n"
 "%s"
@@ -2456,7 +2449,6 @@ msgid ""
 "Could not add tool:\n"
 "%s"
 msgstr ""
-"\n"
 "ツールを追加できません:\n"
 "%s"
 

--=-=-=--
