From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] git am: Improve error messages
Date: Wed,  2 Jun 2010 10:33:34 +0200
Message-ID: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 10:32:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJjN9-0007Bl-Tr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 10:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab0FBIcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 04:32:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:2515 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0FBIcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 04:32:17 -0400
Received: by ey-out-2122.google.com with SMTP id d26so297496eyd.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=W8jO9GKHepABXmttdTd7iIbrKWD9vbhRNxmNCXiZAck=;
        b=OYoEcFnlggbQK+WZQVKX/ZsbpUgZs6MRfv6EoUw8oSEpL2ZjMLtvQasmMBNf8l3sQz
         zsasP7DUV0YyOfDFOb9hAyElb6MxWsReuVBjQdgcy6e2lIy/ruFeqRFwFm16jFuExRnA
         rdni3Rxp5qtGutBvGn9ep3RgMI7CfvyXPPNkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wSQ0I0wXqQo6v2ZrFouQ8MO2totKYT3eJvoiPAW5YNOrz1DRmF6uspB0Phsj6K8VzD
         m51bVvZufrNVzRXKymr1wmiXAVl1EQEQMKa4XUKe5cowqKmuDFx92MJpBS2dyKNrPJ90
         2bhLtLlBDjOt5MLsccJXkfbPklb1mmSlWOYkc=
Received: by 10.213.108.73 with SMTP id e9mr4557261ebp.42.1275467535857;
        Wed, 02 Jun 2010 01:32:15 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm4340891ewy.10.2010.06.02.01.32.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:32:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148226>

What changed since v1:
0. Use TAB to indent
1. Revert to hardcoding "git am" instead of "$0" (Johannes Sixt)
2. Use "test -f", not "test -e" (Junio)
3. Set $FIRSTLINE to an empty string if the test fails (Junio)

Ramkumar Ramachandra (3):
  git am: Set cmdline globally
  git am: Display some help text when patch is empty
  git am: Remove stray error message from sed

 git-am.sh |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)
