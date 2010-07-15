From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Get rr/svn-fe-contrib merged
Date: Thu, 15 Jul 2010 18:25:38 +0200
Message-ID: <1279211139-8629-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 18:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZRE7-0007VC-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 18:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933706Ab0GOQXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 12:23:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51317 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933701Ab0GOQXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 12:23:53 -0400
Received: by ewy23 with SMTP id 23so288033ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nNzzyBQ/5anRDf9srAwxLY3AlEFEAKA48ovKe0nuKEs=;
        b=AHKOkcx9INGSpbHTIa217VCYuE5bupjZ3QRpFqVQKUWwGenWwvMMSMcv/E0zjdZ9f+
         GSJ8EkPo8TjfIXFjMkuBc6uN8atTsSj775q5DEHiNniCiXplSjkmqHgHYqOSxnSBND7q
         7iwdiKuhSt9GraUp9TsyWKix6Cf+TbQLtgM1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WTi53luJ4lq8hI2zGd/jeLuaM5wZkl0XzcgEtlCDKTo8utujVMuEKjPLu9eD0BsSax
         yi80EtGP2xz5lpV4S4x32rnhR6rUECJdsXJiZJ1Rc6IM7lpZ4E0+kShMNLMLjwxNr7Td
         TgoHdOZl6EMKYeRoNKzr60u5G+/S7tMDkTge8=
Received: by 10.213.31.129 with SMTP id y1mr14349348ebc.42.1279211032043;
        Thu, 15 Jul 2010 09:23:52 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm9390144eeh.15.2010.07.15.09.23.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 09:23:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151095>

Hi,

Thanks to Jonathan for suggesting this. This series adds a sample user
for svn-fe in contrib/ along with some good documentation.

-- Ram

Jonathan Nieder (1):
  Add a sample user for the svndump library

 contrib/svn-fe/.gitignore |    3 ++
 contrib/svn-fe/Makefile   |   63 ++++++++++++++++++++++++++++++++++++++++++
 contrib/svn-fe/svn-fe.c   |   15 ++++++++++
 contrib/svn-fe/svn-fe.txt |   66 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 contrib/svn-fe/.gitignore
 create mode 100644 contrib/svn-fe/Makefile
 create mode 100644 contrib/svn-fe/svn-fe.c
 create mode 100644 contrib/svn-fe/svn-fe.txt
