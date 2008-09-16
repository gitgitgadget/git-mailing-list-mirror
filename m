From: Mark Struberg <struberg@yahoo.de>
Subject: git-branch manpage question
Date: Tue, 16 Sep 2008 14:46:13 +0000 (GMT)
Message-ID: <957350.34177.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 16:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfbpt-000258-Cg
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 16:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYIPOqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 10:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbYIPOqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 10:46:16 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:22838 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752641AbYIPOqP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 10:46:15 -0400
Received: (qmail 34240 invoked by uid 60001); 16 Sep 2008 14:46:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=G+iPPtnMpe+u5PiObYf5CaPai1wz0gZekJ6LvF4L1SWdDSDichzZd+oIZWvqtKbuu1aAUTDZkfqSIvcPoF7DfsaM5gcGLruA3P1hFBvOxisVPv5TVS4M9DTy4zGQ6vTzID7+h3BCwKy54fcGfGl0zmfA3eEACfNlSue2FL1iaRU=;
X-YMail-OSG: uBr.DOEVM1k5LjLIDoxwZmEXlsxzYn8IUSCoAp6qvUOgelhvGyjCv7bUeTEMWel7GMaizkDl6AWfRB0Ir1bzaiIxb2Q_NTo.3A1SpjcQJwMcUKVuWKTpFCv1jJQm7X7Co4e9x8QVvpqryVrIdZ_D1DA-
Received: from [81.19.198.7] by web27803.mail.ukl.yahoo.com via HTTP; Tue, 16 Sep 2008 14:46:13 GMT
X-Mailer: YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96007>

Hi!

I think i found an inconsistency in the documentation of the git-branch=
 command:

*snip*
--track::
	.... Set the
	branch.autosetupmerge configuration variable to `false` if you want
	'git-checkout' and 'git-branch' to always behave as if=20
	'--no-track' were given...
*snip*

and=20

*snip*
--no-track::
	Ignore the branch.autosetupmerge configuration variable.

*snip*

So, the description of branch.autosetupmerge is referencing --no-track =
and vice versa, thus the effective documentation is essentially missing=
 as far as I understand.

txs and LieGrue,
strub

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
