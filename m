From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: multiple .gitignore-s
Date: Mon, 23 Apr 2007 00:36:22 +0300
Message-ID: <f36b08ee0704221436g661396b6m4ed8e16676175f4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 23:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfjjQ-0008BM-5F
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbXDVVg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbXDVVg0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:36:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:7265 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXDVVgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:36:23 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1573743wxd
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 14:36:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hnPpoo07IO2LuPkHoQFbwsZg3YJ1PZii4I5GqxkPIZlgs3kM3+/P/emi95MnSpo4UnUyUD++TY19Sf3uRXTxbNy9JFQtrNq3LLwdM3LhIAiLOjmdTbMS65/8HldKRAG7i4EtrVnQUsc0msGu0u6SIov1XUMB8Fa/UwbwThy/1+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ndr815X7UL0x4KjNByWoMQUxAH3FRKbVDgN1jI6Fua+hTUSOwTFtmzYbSwXtmH3MyqTGlgoCSmUKte7RPItg3RUc1k7QFVd3X2BZoOpQmD4zYmmY0C1AL31cxxYz9f+2UEcRMpYdTtF3jrq2cBukoA6ABfIn3uDkopdUQaQQtDM=
Received: by 10.90.30.20 with SMTP id d20mr4267264agd.1177277783005;
        Sun, 22 Apr 2007 14:36:23 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Sun, 22 Apr 2007 14:36:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45276>

If repo has toplevel .gitignore, and subdir A/B
has also .gitignore, then how these two .gitignore-s
interact to affect A/B ? Are they shadowed, or accumulated ?

Thanks
Yakov
