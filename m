From: Frank Li <lznuaa@gmail.com>
Subject: How let git think UTF-16 file as text file
Date: Mon, 2 Feb 2009 08:43:51 +0800
Message-ID: <1976ea660902011643h379e41f1nd2f2c5f7b8d729f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 01:45:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTmwD-0005dW-QD
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 01:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbZBBAnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZBBAnx
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 19:43:53 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:55981 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZBBAnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 19:43:53 -0500
Received: by gxk14 with SMTP id 14so1020614gxk.13
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ywIgNG5RuHgzquGvy43z0XHOoMoZfW+zqahV4zERoYg=;
        b=PxTyRP8uHjpBSc9R2MAkHaq+ORsmTEpBKPZykcgQDV664BhQXq871aFs/NhJl1C+ih
         pV9weqyNoa6ubDMNr6hh5W2PgB7AQRqcImgPD8Hnst1hG7o5l3Gco8VsAtSMX5xzWzhz
         1nDNdUgFfWITbuYhq0gcYakBECc11PiE4tR6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bRJnRmfg46Oa6yOakw9ipiEMmP9uULfinjK5KuBruHrCCwyGd7h5JM4ZgV25RoW6b3
         MyH7RelmnDHLKUB1Uh+ipgGwgjfR2f1+eWcX7MdR9FWGIcup7VxR6S9GfHtFaWciD/bB
         3paKt+VIh9UNxT/USt0wC9He3AHVN8XLCaTqw=
Received: by 10.150.198.11 with SMTP id v11mr3892771ybf.15.1233535431896; Sun, 
	01 Feb 2009 16:43:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108029>

VS project resource file and resource header file use UTF-16 as unicode.
Default git think it is binary file.
How to let git think it is text file.
