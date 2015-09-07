From: Olaf Hering <olaf@aepfle.de>
Subject: bash completion lacks options
Date: Mon, 7 Sep 2015 17:07:58 +0200
Message-ID: <20150907150757.GA6720@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 17:08:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYy1e-0005nq-6H
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 17:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbbIGPID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 11:08:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:28654 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbIGPIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 11:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1441638478; l=448;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=HvGqPWt2/GHdCmyKFf2ccJiBgA9QNsJx0AspcnH4lPE=;
	b=jhxTQL3GTZpdW7NYuVBAVZkytY3HO7oLVDh2K9eVJhEu9nsD4FXwGiOMtLHh09JtLYD
	hE9eEfrswabCLu7RX5QD6iuElY6/5ZgaLv1quYYJ08tdUFmjb+n66zQPvGaXIR1FX9HoZ
	S6sFDM/lic25ePqJKanGqC5pUmmcbJjsJPA=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWtqWFmrC5F/k8792bHikQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box (aftr-185-17-204-139.dynamic.mnet-online.de [185.17.204.139])
	by smtp.strato.de (RZmta 37.12 DYNA|AUTH)
	with ESMTPSA id 307164r87F7wHYN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Mon, 7 Sep 2015 17:07:58 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 251A15084E; Mon,  7 Sep 2015 17:07:58 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (6503)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277465>

"git send-email --f<tab>" lacks --find-renames and others. Is the list
of possible options maintained manually? Perhaps this should be
automated by placing the long strings in an ELF section, then filling
variables like $__git_format_patch_options from such ELF section.
An example how this was done in libguestfs is here (see daemon/daemon.h):
https://github.com/libguestfs/libguestfs/commit/0306c98d319d189281af3c15101c8d343e400f13

Olaf
