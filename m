From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 0/2] add a --delete option to git push
Date: Thu, 13 Aug 2009 22:05:47 -0700
Message-ID: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 07:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbozX-000376-O7
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 07:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZHNFGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 01:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbZHNFGG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 01:06:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:60669 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZHNFGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 01:06:04 -0400
Received: by rv-out-0506.google.com with SMTP id f6so381388rvb.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 22:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=9oUK0OdIHD/OVlx6nkpC4yTV/urXf3QNN5cESQrtzL8=;
        b=tl83aAN5JIVAYuxKWx4vYkmLPEGAg1Vkj4tHSCvmVT4wmJBbf0oDc65Osic2liPlV0
         vl10XBLDC8Hvo/xU5TKyd5sCk9SdZzK5VQs/vQR6ccFN+k6TSkyooqzAlinkCyyN25w9
         3Y9w7dGtrUUrc4CtrwrLqtvjE3FyA4UM7NDd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=Ikva7z1A/N1TCA43se8XR3AmlFFJyxnFjzvsEqIkrV0+Nnj1mChPFsybgPFF/dmh5N
         jF/Gcb51dypzalXJoky8LRxDKlTTBkXRwche7Jz5jdfhm+8LXzJWfm7CQjstSyoPbVXb
         F1VaPoYF5FgHVOBWXEalGJ/BL7HdPLo8ytvzg=
Received: by 10.140.201.17 with SMTP id y17mr908995rvf.84.1250226366037;
        Thu, 13 Aug 2009 22:06:06 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm5737547rvb.40.2009.08.13.22.06.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 22:06:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125894>

This is in reply to a brief conversation I had with jnareb on #git
about the blogpost "5 things git could learn from hg", or something
like that (can't find it right now).

Comments most welcome.

Sverre Rabbelier (2):
      add a --delete option to git push
      test that git push --delete deletes the remote ref

 Documentation/git-push.txt |    8 +++++++-
 builtin-push.c             |   10 +++++++++-
 t/t5516-fetch-push.sh      |    6 ++++++
 3 files changed, 22 insertions(+), 2 deletions(-)
