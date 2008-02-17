From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: cant figure out how to get git working over https with a self signed certificate
Date: Sun, 17 Feb 2008 09:48:26 -0800
Message-ID: <e26d18e40802170948s4b769c5ej4d0fb01300fbad9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 18:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQndg-0008OJ-3Q
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYBQRsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbYBQRsa
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:48:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:16949 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbYBQRs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:48:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2336853wah.23
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=pjcYs9krYd1UGb0ApT+dEKS0A4zcCi5p7GG5dJ9Qing=;
        b=MmeDsmyyUCx3LmPIdXQJAITrdZZUn21z5iphyTIQHA/WUr11Bjfdt6fKv/Wg7SH/cooH0r2AQnEdwm2bl8CT5GcVyHNR394nmisWfCWOYIxdQfSWSo9wPi9ZmTeASFu48UQMqm8R/U08ZGy0m7ZfTTc5qBoeubtZettmfS2eVpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V807XZt9/N0lYmICq2lpVme3zUxyVUWzy6YqVY8M5Mryv936pfVEL9BIMKq8z24B4NNFqFH1Lk0ZIbcbRL3VH01xwTW3mDG/WpQGL37cecqoVxr3nnK+E2pFo3yfi5ArdrmyeDx2vSAqL7TyJIyD1/BxAoKgDsuH/u4+SOkdtRY=
Received: by 10.115.79.1 with SMTP id g1mr3251968wal.43.1203270506087;
        Sun, 17 Feb 2008 09:48:26 -0800 (PST)
Received: by 10.114.170.20 with HTTP; Sun, 17 Feb 2008 09:48:26 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74143>

cant figure out how to get git working over https with a self signed
certificate.  I keep getting the dreaded "Error: no DAV locking
support on remote repo"

i have DAV on that location

<Location /git>
   DAV on
</Location>

and the module is loaded, but i cant seem to get git to push
