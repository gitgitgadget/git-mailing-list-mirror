From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: fast-import and core.autocrlf option
Date: Sun, 22 Jul 2007 15:59:26 -0700
Message-ID: <a1bbc6950707221559m63fb1295jc26b1327e71687e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 00:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkOj-0001AF-B2
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765452AbXGVW7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765421AbXGVW73
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:59:29 -0400
Received: from qb-out-0506.google.com ([72.14.204.231]:30131 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765401AbXGVW72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:59:28 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2093062qbe
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:59:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l37H7jRZg/3uqnJJMrVcWdsroLy23rB7uOWgs37CqahdvbDQejtvytCnx+otTLLREIfT6La6pJ8KIE2LpqJe67dxe8SiWYq1INk7dWyOqf08uL7p6HkKVfGiJBHEoYMIcGX9VAwwaYs/fmYawBLCTVVYSK/rtLD1MLD2wWQlKjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SX+syNsAexcvEcJ/AdOhPdLU6uZC6EHYIGMFtbuUNEXNb7/dLgNZehUPcbR/MyV6WB6+njaljdreGxSJ15kyeaiIn7EMZpUZoNNt+fQIME3Ts6A6daZfwC9erYI2sXqrDgz8Nc2NRIiXOGEsWYazRmsHFQo4BJzvhP36/6CHM8Y=
Received: by 10.141.202.12 with SMTP id e12mr758372rvq.1185145166634;
        Sun, 22 Jul 2007 15:59:26 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Sun, 22 Jul 2007 15:59:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53362>

It looks to me that CR/LF conversion does not happen during
fast-import even if I have core.autocrlf set to 'input'.
Is this a bug or is there a reason for that?
