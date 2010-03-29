From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] Documentation/remote-helpers: Clarify "curl" family of 
	remote helpers
Date: Mon, 29 Mar 2010 09:34:58 +0530
Message-ID: <f3271551003282104m1c273450pacc5d5c84125fa54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 06:05:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw6EL-0005rX-EG
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 06:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab0C2EFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 00:05:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63456 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab0C2EFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 00:05:19 -0400
Received: by gwaa18 with SMTP id a18so3816652gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=VA7Sm1WTAC+kkg2KG5gtw//WFB/9P8rnJqUzTTNjKcQ=;
        b=OV6oOve2mn6+14twgPELlQsHSriRSlhsBkOmm3oLhI2WfvsMg/a+gBQonLQrqGS2Fs
         uFZKC7ntDe2LLmUHY6MGLf9Ts879sS1IrjA/m2i9eNLCNaogTLDreEgzdc5DSnOUQ43h
         AxQEGpQ23YFtt1YjY3DCTgBWd22pzpPkG/TI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=kYeBWO/vErmR+jl4fgo0ImuJgVKb2bcNcjaEdEa3rpN0TDjghtNgfnN+6pkafbzCur
         SB6DcezomR2di9lPwn5loBdEQl+Q3tdE8bWJIn66FvYS/FuaMjxf9ZKRZ8o/D4ZuhWfw
         aYjn4h3cBBBBPqL4sQxmE0dIQSbkdGzNCr+mY=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 21:04:58 -0700 (PDT)
Received: by 10.90.23.37 with SMTP id 37mr372687agw.75.1269835518202; Sun, 28 
	Mar 2010 21:05:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143432>

Rewrite paragraph about "curl" family of remote helpers to clarify
different invocations of the same program.
---
 Documentation/git-remote-helpers.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 58533e5..f1fc736 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -33,10 +33,9 @@ reachable via those refs to local, and update the
local object
 store. Using the 'push' capability, they can transfer objects from
 local to remote, and update the corresponding refs as necessary.

-Git comes with a "curl" family of remote helpers, specifically
-'git-remote-http', 'git-remote-https', 'git-remote-ftp' and
-'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
-and 'push'.
+Git comes with a "curl" remote helper, which can be invoked as
+'git-remote-http', 'git-remote-https', 'git-remote-ftp' or
+'git-remote-ftps'. See INVOCATION below.

 INVOCATION
 ----------
-- 
1.7.0.3
