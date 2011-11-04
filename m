From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: qgrit: graphical git rebase -i helper
Date: Fri, 04 Nov 2011 20:38:39 +0100
Message-ID: <1878937.uu0F3Q8E7A@soybean>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Phil Hord <phil.hord@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 20:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMPbN-0006uY-QL
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 20:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1KDTiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 15:38:52 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:58104 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475Ab1KDTiw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 15:38:52 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mx.arcor.de (Postfix) with ESMTP id 7B84B2120A7;
	Fri,  4 Nov 2011 20:38:50 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 76CAFE1975;
	Fri,  4 Nov 2011 20:38:50 +0100 (CET)
Received: from soybean.localnet (188-22-237-127.adsl.highway.telekom.at [188.22.237.127])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-02.arcor-online.net (Postfix) with ESMTPSA id 600BC30296;
	Fri,  4 Nov 2011 20:38:50 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 600BC30296
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1320435530; bh=HCqyuQKgsksbiuPdRnv1f1m0Qx0daMbF7UBQOykW0uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZmUBxNkOsJ53kmsb1QsLj6Ad+/FhnbHpyRb68N9/2nFiCRScuPBPljYBN7ZGXAX86
	 YmZ9zJE6P7trtt+nKGXr0XJJ4mVBpxtx+ByaB+VRWYo9vQMXRqUt2mhIgwVzvi4dW+
	 /deaeucoZgv5Pm4Nh66Vlohor0qfmHDeXY9RjgUk=
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-generic-pae; KDE/4.7.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184800>

Hi,

i wrote a small tool to support users during git rebase -i.
by presenting commits in a graphical interface.
(usable with git 1.7.8.rc0 and up)

Lacking a better idea i named it "qgrit" :-)
(Qt git rebase --interactive tool)

Notable features:
* Reorder commits by drag drop and up/down buttons
* Select actions from a combo box
* Undo reordering function
* Shows full commit message, not only title line
* Works on mingw (auto detects git path)
* Easy setup as rebase -i editor: run qgrit, click "Install qgrit" button
 (this also detects too old git versions)

For more information, screenshots and source code see:
https://github.com/qgrit/qgrit/wiki

Ideas for improvements, bugreports welcome!

Have fun,
Greetings Peter
