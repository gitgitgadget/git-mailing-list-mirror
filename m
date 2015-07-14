From: Olaf Hering <olaf@aepfle.de>
Subject: git log fails to show all changes for a file
Date: Tue, 14 Jul 2015 09:30:35 +0200
Message-ID: <20150714073035.GA22707@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 09:30:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEuft-0006OF-5j
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 09:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbGNHak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 03:30:40 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:35381 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbGNHaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 03:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1436859036; l=503;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=8CJNjxBVytW+7TcP0r/7n8g79jGD0MOIFBPGJ9Noccc=;
	b=jJvr3QYOtzYA5EbbT/w/ed14VXLq9bv6LClLSBEE46v0v2CQtdaJkR26jVReXXDr3zt
	6BTNOLLUQZ2BxWSxqH66ytL1vbH6poN7c/X7S/dhOUOqeIZzIGUWHV4P9eexYK/IHf0qF
	vHkIk+dztfnGA/Qt8mkpYJdiqN+WTuEIPIA=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnDYUArRV3Yl4Hhhq0jXs89otQpQsG2DtGeDmANaZw=
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a62:90:9c01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.8 AUTH)
	with ESMTPSA id I01b3dr6E7UarD1
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Tue, 14 Jul 2015 09:30:36 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id A2529502DF; Tue, 14 Jul 2015 09:30:35 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2015-06-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273937>


I wonder why this command fails to show all commits that modify a given
function: 

  linux.git $ git log -p -M --stat -- drivers/hv/channel_mgmt.c

With commit 1f656ff3fdddc2f59649cc84b633b799908f1f7b init_vp_index() has
"const uuid_le *type_guid" already. And somewhere between commit
d3ba720dd58cdf6630fee4b89482c465d5ad0d0f and the one above the "const"
was added. But git log does not show this commit.

Why is that so, and whats the command to really show all and every change?

Olaf
