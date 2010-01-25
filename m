From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
Subject: [PATCH] Add test-run-command to .gitignore
Date: Mon, 25 Jan 2010 16:56:21 +0100
Message-ID: <20100125165621.2a5af05d@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 16:56:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZRIk-00047F-VQ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 16:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0AYP41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226Ab0AYP40
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 10:56:26 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:35201 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab0AYP40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 10:56:26 -0500
Received: by fxm7 with SMTP id 7so167059fxm.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Sa7dm9VFr4My6GNVDyVYyRzWg4xBbiXoij3IaBWhzng=;
        b=VJcJSeFV7lU+KpPOYKzwY/ns6C0srSVPWZHGvEYyB2nSEM/t9S303+T/Brm/OuWdZt
         T6tLu6LIH/bAblgalRdsZPWH6QkTDQwYQ818GuAkM1iQI+q8wHrfLs4Gg8PzrCRbUFUR
         fMQB1OF2eGFJ6i7+i4TIFeTct9QaKKxm4E/l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=Lgpa4TK1GHbNxOEM+Ein2XtsVIX5UhlCLIT+g+kxNjQHFsNgHLdsQt/om5J0sDQcLu
         tzO9HWOaI2FQjLR7+0pZkeKIvz5AZr7PCY0+v57triEk+XJAHwLJx+56ZVQUQhcUeBt7
         KpvHHkn88xzRE1Ha/8Pkj7uG60IrtBtuEtSTs=
Received: by 10.223.164.156 with SMTP id e28mr1158145fay.27.1264434984372;
        Mon, 25 Jan 2010 07:56:24 -0800 (PST)
Received: from varda (38.Red-83-45-254.dynamicIP.rima-tde.net [83.45.254.38])
        by mx.google.com with ESMTPS id 28sm6843597fkx.58.2010.01.25.07.56.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 07:56:23 -0800 (PST)
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137969>


 Add test-run-command to .gitignore so it does not pollute
 git status output.


 Signof-of-by: Alejandro Riveira Fern=C3=A1ndez <ariveira@gmail.com>



diff --git a/.gitignore b/.gitignore
index 83cf1b7..8df8f88 100644
--- a/.gitignore
+++ b/.gitignore
@@ -166,6 +166,7 @@
 /test-match-trees
 /test-parse-options
 /test-path-utils
+/test-run-command
 /test-sha1
 /test-sigchain
 /common-cmds.h
