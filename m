From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Fix documentation for core.gitproxy to reflect code
Date: Fri, 3 Aug 2007 08:45:56 +1000
Message-ID: <ee77f5c20708021545s54bc226ds4c1c4589c6617c00@mail.gmail.com>
References: <ee77f5c20708020523m1a243bf2g9778994441cd21d5@mail.gmail.com>
	 <7vtzrhvgpc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjQh-00056m-Nb
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbXHBWp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbXHBWp5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:45:57 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:63741 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408AbXHBWp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:45:56 -0400
Received: by rv-out-0910.google.com with SMTP id k20so524877rvb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 15:45:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JFrOs5PtoKgH0JsZ237gLsu+PRC89fWtGxdSiT7p+OoUZ7yup/YEP56ardGm6DJuNWiIH1xmcgt2Wue+c7fevQRYDtTnm40O/7ubwckFzVuJ7wZ9arSEpJzQz7mj2+2UttXeB/NyAgcrPx1aAxoMwg4JS3VT1Trp0834O4vucxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ptgsQZhH1t6MBE4tm86HK9vyeXXxoqaScv/BFqw6OlrZIdHo/aLiflVTrYCvH6kqi5ws+AE7sZBgFhfWYEPLgWFDP5JY3sd7G3O7v3mBFzyo+fL7Zxh24dooEM+L7dIoCCjNEXAlJ7i+4ptV3Ag7gUGPb2Q6DySn++1q4WH5tt4=
Received: by 10.140.142.7 with SMTP id p7mr829066rvd.1186094756350;
        Thu, 02 Aug 2007 15:45:56 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Thu, 2 Aug 2007 15:45:56 -0700 (PDT)
In-Reply-To: <7vtzrhvgpc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54633>

The current implementation of core.gitproxy only operates on git:// URLs, so
the ssh:// examples and custom protocol examples have been removed or edited.
---
 Documentation/config.txt     |    2 +-
 Documentation/git-config.txt |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3135cb7..de9e72b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -101,7 +101,7 @@ Example

        # Proxy settings
        [core]
-               gitProxy="ssh" for "ssh://kernel.org/"
+               gitProxy="ssh" for "kernel.org"
                gitProxy=default-proxy ; for the rest

 Variables
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 8451ccc..c3dffff 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -214,9 +214,7 @@ Given a .git/config like this:

        ; Proxy settings
        [core]
-               gitproxy="ssh" for "ssh://kernel.org/"
                gitproxy="proxy-command" for kernel.org
-               gitproxy="myprotocol-command" for "my://"
                gitproxy=default-proxy ; for all the rest

 you can set the filemode to true with
@@ -291,7 +289,7 @@ To actually match only values with an exclamation mark, you
have to
 To add a new proxy, without altering any of the existing ones, use

 ------------
-% git config core.gitproxy '"proxy" for example.com'
+% git config core.gitproxy '"proxy-command" for example.com'
 ------------


-- 
1.5.2.4
