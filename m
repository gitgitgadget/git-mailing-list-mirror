From: Marcelo de Moraes Serpa <celoserpa@gmail.com>
Subject: Pulled files with "new file" status
Date: Mon, 20 Jul 2009 00:45:27 -0500
Message-ID: <1e5bcefd0907192245j19aac1aar804a0e3bd637b46b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSlgv-0003nk-I3
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 07:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbZGTFp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 01:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbZGTFp2
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 01:45:28 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:61657 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZGTFp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 01:45:27 -0400
Received: by yxe14 with SMTP id 14so3329643yxe.33
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 22:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=TYWsBSkvUBIfWXmo0W+nYog9Fiz7yxJYVAGfygPq5lc=;
        b=bhefMY4E6xvvh1m3kh22yEKwANLklqq7MVM14zkjxy1pm0A43KuR6uLYtHc9RP2+1I
         ZYtrfI+dcH+edgdF4+xsHMHWrChS47GcWo1jVc0pqm4Mgjz+zmKWMOANsxPf+xj6rGKQ
         7CJJoBLwHby3TWavWMo+0p+5PvzYlX38WW3G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=TCO6pkeDRttXyXI7Rv0Ud6G34dNrb4CthcDQudkaXTsmfizWhckiMOzN7E0iEBV8eD
         8whyQtDpxs+sNRxC4wC+IHNreYag9OCaRJwFy6LBAKRrfUmFL8z5cpNR7pz3nP5+QcjJ
         0/2g5XOdNjhQ/4yCYS00bDmiJEIT3l15M8inE=
Received: by 10.100.242.11 with SMTP id p11mr5702467anh.113.1248068727443; 
	Sun, 19 Jul 2009 22:45:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123568>

Hello,

I just went through an interesting situation and maybe someone could
enlighten-me. I pulled and got a conflict. I solved the conflict, git
added the file, and committed. I git pulled again and get the updates
from a friend, but the intriguing thing is that, the files that he
added appeared as "new file" for me too. Why's that? I haven't been
the one who added the file, he added it, why git would pull objects
and tell me they are new ?

Thanks in advance!

Marcelo.
