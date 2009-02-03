From: Brent Goodrick <bgoodr@gmail.com>
Subject: Git vc-git.el versus Emacs vc-git.el versus Gits git.el
Date: Mon, 2 Feb 2009 19:31:59 -0800
Message-ID: <18823.47791.359047.560149@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 04:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUC2X-0002Cg-Tn
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 04:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZBCDcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 22:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZBCDcF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 22:32:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:42330 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZBCDcC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 22:32:02 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1804170rvb.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 19:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:subject
         :x-mailer;
        bh=52HIQ8nIJHgdN27REo/7fijzYxqqb4i8iEZx73ZnPCM=;
        b=buONzA1j4U4jiqbfu128mWItBN9ssv+iYGHN3EToOq/4m13W7hSjLy6MK3GHKIX5dy
         AeKi+I0J1Mk9cAoVdhbKt6SUkkP3IgnUOWdwvSMbHS+eDexjW9gmw8XDFAfwhsyEWhhL
         nlveXHbuV+HGcxHMyB3mhXWeS0rFj3oOQeFl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:subject:x-mailer;
        b=IlsRK9Fn2mtvhvkfPIJiUu+7MzRV2y/Un1Ab3sOBfu6X0g8hcKbze7CnaDKmiFMDYg
         wPf0ZqdEfCSJYQPEBm7vqF+0yDtk6eB/WDwBpitf3z6LqpUsIIMc5DI+JrwLbREHgD7Z
         XwSt+6hSwPuyHEGXUn9pXww/NiG+8Wopbtrvo=
Received: by 10.141.171.3 with SMTP id y3mr1134821rvo.263.1233631921998;
        Mon, 02 Feb 2009 19:32:01 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id k41sm4883450rvb.3.2009.02.02.19.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 19:32:01 -0800 (PST)
X-Mailer: VM viewmail-609 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108137>


Hi,

I have some questions concerning the Emacs Git integration:

 1. What is the difference between git.el and vc-git.el in the
    git/contrib/emacs directory?

 2. There is a vc-git.el in the Emacs top-of-trunk sources, and
    another one in the git/contrib/emacs directory in the Git
    sources. Which one should I use?  If I should use the one in
    Emacs, then why is there one in the Git source tree?

Thanks,
Brent
