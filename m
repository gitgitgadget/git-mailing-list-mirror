From: Adam Mercer <ramercer@gmail.com>
Subject: Checking for a valid email address
Date: Thu, 26 Feb 2009 21:28:59 -0600
Message-ID: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?77u/R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 04:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LctQm-0004FM-DH
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 04:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbZB0D3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 22:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbZB0D3E
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 22:29:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:48649 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435AbZB0D3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 22:29:02 -0500
Received: by gxk22 with SMTP id 22so2136373gxk.13
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 19:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Tfn4q4Pzqh5EY28ClRoIGkmctDPWiit/rYxHsbQRUGA=;
        b=pIH6zRASG0j4LFaVCgOT/6bj+X+H1OLoYI5Y1gKhJSGXpPlUbuiqjnwnvUNlrvVBtX
         MsU8EiKSVVA7IQ7p+tsUkRgAZHNAv+FNzoIr/HpIg0qkru7ViDyIir4LaPytOo2Zbj/p
         Rsag53F9YinczZqETZiaYnLfCEYpHgxB3uoz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cFIFD/Dge7HCsifcyf3elRD6RlEv9TPDYmQpwAJF6OKiUTPzyeePTYHKvPXi+HmhDJ
         72OdCGOqhSNm7iZYbbC1c/ZnDTpjJeYUco9G/TjqWAQ1NiMOfgAzx3FheacigwkrDPxt
         8g+8mus0o2DMKLZMWxpcu0Vy3B8sdqmX3w1UY=
Received: by 10.90.25.11 with SMTP id 11mr1050244agy.72.1235705339899; Thu, 26 
	Feb 2009 19:28:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111628>

Hi

We are in the process of migrating some of our repositories from CVS
to Git in a two step process, first to a centralised Git setup then
(hopefully) onto a more distributed development model. In the testing
we have been doing so far the only problem we have run into is
developers not setting their email addresses correctly so the
changelogs are filled with spurious address. Does anyone know of a
pre-commit hook that could check for a valid email address prior to
allowing a commit? Or another way that this can be acheived?

Cheers

Adam
