From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: [Q] Interactive rebase and editor failure
Date: Mon, 15 Dec 2008 19:37:28 +0300
Message-ID: <85647ef50812150837y47fc66co1c4a1107716ad76a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 17:39:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGTN-0002p8-Um
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 17:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYLOQhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYLOQhb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:37:31 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34885 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYLOQha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:37:30 -0500
Received: by bwz14 with SMTP id 14so2234455bwz.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=w9ISVWC1IiZWnSQlndtzPFCVuELGGyuCcvYg8MZ7P/E=;
        b=pPYJC6FD11Nrs2Prwp/+YVYrSRfhPwTuk0sj+4RTssfOuEOpJmWHEBEGt74a/srXCF
         6Egu87fM6ROqs3gcDWML8WQvQnF/3x9KxOjXk52gb12Xj+LbpYvCKBl5I+dxk+nZltk/
         AuC94XMLc8W8qFsr+17nJOj4DeWIP15Zkh0lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=tGoTTKykHRND8vfYLEo40E+XmFX5dclqjPIe923VfANhqaBcFz4QRgtMgfk2iVwYwS
         dzxrtzAChF+q15gBxSiTLh7oi8xFzCtIxir84Yvpv3mlRRveB/BglhxN9v1+50y/9gC3
         +cGGKt+Dht6viN2vpOkqpJq/SAgVQoMUdBFI8=
Received: by 10.181.144.11 with SMTP id w11mr2596247bkn.27.1229359048234;
        Mon, 15 Dec 2008 08:37:28 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Mon, 15 Dec 2008 08:37:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103179>

The git rebase -i detects situation if the editor exits with non-zero
exit code and displays error in such case.

However in this case for some reason, the rebase operation is not
aborted. What is the reason behind this logic? Is it the bug or
feature?

Constantine
