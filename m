From: Paul Talacko <gnuruandstuff@yahoo.co.uk>
Subject: Patch for git-svn.perl
Date: Fri, 5 Sep 2008 11:18:26 +0000 (GMT)
Message-ID: <257934.40788.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1376124197-1220613506=:40788"
To: normalperson@yhbt.net, brad.king@kitware.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 13:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbZSD-00032h-N5
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 13:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbYIELZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 07:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYIELZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 07:25:09 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:28204 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751325AbYIELZI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 07:25:08 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2008 07:25:07 EDT
Received: (qmail 41565 invoked by uid 60001); 5 Sep 2008 11:18:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=J4RuxHKtEIe7SCQ5fRpqXrXPLkHSEZI9rbQ7zdNLgFzu4syY1yieaN7Nft+HxriZhtCwV9dBFNBKy2ESi42CRtAB499VnNpkQZbWmNLAkmYX91QrzcpWfNh4USy+Qt1PNLqEIeor1tW7tkcSGsvh1aJPzH5fMWpL6qcfbsRpIyY=;
X-YMail-OSG: D4qhVvQVM1maqy4hKpSeyu66lzWsqJMpMy1Frh8RDwPaogctDD56iSGuXMTd2sW.mm2hLlj6fhUBi91mqqcom0LXWxbkEViIV1wyOZF3MXQsLhmbnK98syLt.Ph0q3HX_1c-
Received: from [193.179.106.23] by web27803.mail.ukl.yahoo.com via HTTP; Fri, 05 Sep 2008 11:18:26 GMT
X-Mailer: YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95006>

--0-1376124197-1220613506=:40788
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

There's an issue in git-svn as autoprops are not applied to renamed files, =
only to added files.

This patch fixes the bug.

=0A=0A=0A      
--0-1376124197-1220613506=:40788
Content-Type: application/octet-stream; name=patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"

ZGlmZiAtLWdpdCBhL2dpdC1zdm4ucGVybCBiL2dpdC1zdm4ucGVybAppbmRl
eCA3YTFkMjZkLi4wYTA0Y2MwIDEwMDc1NQotLS0gYS9naXQtc3ZuLnBlcmwK
KysrIGIvZ2l0LXN2bi5wZXJsCkBAIC0zNjM2LDYgKzM2MzYsNyBAQCBzdWIg
UiB7CiAJbXkgJGZiYXQgPSAkc2VsZi0+YWRkX2ZpbGUoJHNlbGYtPnJlcG9f
cGF0aCgkbS0+e2ZpbGVfYn0pLCAkcGJhdCwKIAkJCQkkc2VsZi0+dXJsX3Bh
dGgoJG0tPntmaWxlX2F9KSwgJHNlbGYtPntyfSk7CiAJcHJpbnQgIlx0Ulx0
JG0tPntmaWxlX2F9ID0+ICRtLT57ZmlsZV9ifVxuIiB1bmxlc3MgJDo6X3E7
CisJJHNlbGYtPmFwcGx5X2F1dG9wcm9wcyggJGZpbGUsICRmYmF0ICk7CiAJ
JHNlbGYtPmNoZ19maWxlKCRmYmF0LCAkbSk7CiAJJHNlbGYtPmNsb3NlX2Zp
bGUoJGZiYXQsdW5kZWYsJHNlbGYtPntwb29sfSk7CiAK

--0-1376124197-1220613506=:40788--
