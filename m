From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 0/3] Move api-command.txt from ./technical/ to ./howto
Date: Fri, 21 Dec 2012 19:02:51 +0100 (CET)
Message-ID: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 19:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm6wB-00051P-Ok
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab2LUSCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:02:55 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:39712 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318Ab2LUSCx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 13:02:53 -0500
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 03FCC2D6B4C
	for <git@vger.kernel.org>; Fri, 21 Dec 2012 19:02:52 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id DCD31522003;
	Fri, 21 Dec 2012 19:02:51 +0100 (CET)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id D9B44107CC0;
	Fri, 21 Dec 2012 19:02:51 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net D9B44107CC0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356112971; bh=k28V7kgUTuNNwAzTjH2I/0RC+7OMjxtSToNp3qVXYNA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=VPd+QmpIgpvLyxP6LshD4bKKGV/UhcQ/1YS3kmxaP20ZjW8qDTkmr7VuWcINErFqT
	 WieNBbUm6b7l+PU7gurzgURjVADbxQKSYzla7z/Spl1F9Ixneob5J8s8bnCIZmV6Xn
	 WTGCct+0qAn+mGrQrK+a82tsGj1uZ50g5cssXYFs=
Received: from [178.7.24.61] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Fri, 21 Dec 2012 19:02:51 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.24.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211993>


"api-command.txt" describes a different kind of API than the other api-* documents.
So better move it to the howto documents in ./Documentation/howto and rename
to "new-command.txt".

[PATCH 1/3] Move ./technical/api-command.txt to ./howto/new-command.txt
[PATCH 2/3] Add new-command.txt to ./Documentation/Makefile
[PATCH 3/3] Amend new-command.txt to be processed correctly by howto-index.sh

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>


---
Thomas
