From: =?ISO-8859-1?B?U+liYXN0aWVu?= Pierre <sebastien@xprima.com>
Subject: Cherry-pick particular object
Date: Tue, 28 Mar 2006 11:31:07 -0500
Organization: XPRima Corp.
Message-ID: <20060328113107.20ab4c21.sebastien@xprima.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Mar 28 23:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOLmw-0003GG-PY
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 23:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWC1Vbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 28 Mar 2006 16:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWC1Vbj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 16:31:39 -0500
Received: from ritalin.autolinq.com ([207.96.225.42]:56813 "HELO
	ritalin.autolinq.com") by vger.kernel.org with SMTP id S932215AbWC1Vbj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 16:31:39 -0500
Received: (qmail-ldap/ctrl 19086 invoked from network); 28 Mar 2006 21:31:38 -0000
Received: from unknown (HELO localhost.localdomain) ([207.96.159.2]) (envelope-sender <sebastien@xprima.com>)
          by ritalin.autolinq.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 28 Mar 2006 21:31:38 -0000
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.16; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18128>

Hi all,

This is a newbie question.

I recently wanted to "cherry" pick a particular file from my git-manage=
d project history. Using gitk, I identified which was the revision I wa=
nted (95ba0c74e03874e8c1721b91f92f161e9061621f), and then using git ls-=
tree, I managed to get the id of the file I wanted (78132af26431e649a0f=
85f22dc27e5787d80700f).

Now, what I simply wanted was to do something like:

"get the file corresponding to 78132af26431e649a0f85f22dc27e5787d80700f=
 and save it as myfile.txt"

How would one properly do that with core git ?

 -- S=E9bastien
