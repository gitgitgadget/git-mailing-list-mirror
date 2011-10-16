From: =?iso-8859-1?q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr.eu.org>
Subject: [PATCH] gitweb: add extensions to highlight feature map
Date: Sun, 16 Oct 2011 18:59:49 +0200
Message-ID: <201110161859.49817.lenaic@lhuard.fr.eu.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 19:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFU47-0007po-16
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 18:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab1JPQ7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 12:59:54 -0400
Received: from freebox.lhuard.fr.eu.org ([88.182.161.122]:37769 "EHLO
	coruscant.lhuard.fr.eu.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754751Ab1JPQ7y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 12:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lhuard.fr.eu.org; s=dkim;
	h=Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:To:From; bh=Amz89GahGwbTbcx39k8QE1juIKV2PbJxHkIU+l8J0/8=;
	b=MJO4XGBlxtfM/9j0MjSTP83U4GydsetzzIgNgNZZfndjkxdz9RQyaRj+w/bwlGis1B6beLIOBao8AnD0wTt8iBWU/Lu9NsR40xAmtQYElB9OpYwEu+0ganpPDgIaOAYYki4obOBfws+r7UvZDeqM4kB/XOOiVUHgE+ZHB6BWXbk=;
Received: from lenaic by coruscant.lhuard.fr.eu.org with local (Exim 4.76)
	(envelope-from <lenaic@lhuard.fr.eu.org>)
	id 1RFU3x-0002ju-Sf
	for git@vger.kernel.org; Sun, 16 Oct 2011 18:59:50 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.0-2-amd64; KDE/4.6.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183726>

added: hpp, m

Signed-off-by: L=E9na=EFc Huard <lenaic@lhuard.fr.eu.org>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 85d64b2..75e4854 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -262,11 +262,12 @@ our %highlight_ext =3D (
        # alternate extensions, see /etc/highlight/filetypes.conf
        'h' =3D> 'c',
        map { $_ =3D> 'sh'  } qw(bash zsh ksh),
-       map { $_ =3D> 'cpp' } qw(cxx c++ cc),
+       map { $_ =3D> 'cpp' } qw(cxx c++ cc hpp),
        map { $_ =3D> 'php' } qw(php3 php4 php5 phps),
        map { $_ =3D> 'pl'  } qw(perl pm), # perhaps also 'cgi'
        map { $_ =3D> 'make'} qw(mak mk),
        map { $_ =3D> 'xml' } qw(xhtml html htm),
+       'm' =3D> 'objc',
 );
=20
 # You define site-wide feature defaults here; override them with
--=20
1.7.7
