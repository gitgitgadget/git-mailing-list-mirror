From: zal12 sar <goshtasp.zal@gmail.com>
Subject: git clone hangs
Date: Tue, 15 Jun 2010 15:52:59 -0700
Message-ID: <AANLkTik3dJvx5TfVl9Ym4QoYDqIGM-LEovbVBW1vCzaN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:53:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOf0P-0005KX-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab0FOWxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 18:53:04 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33778 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0FOWxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:53:01 -0400
Received: by wwb18 with SMTP id 18so5224896wwb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=BdPQCV4tFcZstIocjm6TuTD336uk9xEsH2KGzYhf/Qs=;
        b=jxmXvK9+FX84St1CQDzJmnZwdwqfFa962fykf4Soa4tU0S4zCV4tf23VnG2ah/MYll
         OSjO4BUnKQo/WY4Jtzp7VeUFu60bH15zzF+dqRqIuj6l9UqK+7/yk4ISg4HXpsqiikuQ
         kG2kbLG+Xx4JQtpzce5kfpt07WlX/6E29oe+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xanYFG+r17v2wPSaW7APCqGGeFdI6bWp0b81rlE3bUrkQZ/WiRk8+1oMIOLWhVz1Mw
         DRK8z2dpRQCxmuc2hacj/gu/vPHRcEDz6OcLlt2vSkzx3/chP/6AZyYlgrJ+ggtwFFHK
         cIrE0vrvNnAK4KLDa2DEjLDtE3KckFRoiYNms=
Received: by 10.216.169.14 with SMTP id m14mr3937267wel.52.1276642379909; Tue, 
	15 Jun 2010 15:52:59 -0700 (PDT)
Received: by 10.216.168.81 with HTTP; Tue, 15 Jun 2010 15:52:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149240>

Hi All,

I am trying to clone from kernel.org, but git hangs. These are the commands:

Hangs: git clone
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git
Hangs: git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Does not hang: git clone
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.34.y.git


...

Any help or pointers?

thanks, zal
