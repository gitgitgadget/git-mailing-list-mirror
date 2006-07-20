From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: initializing remote clone but files already there
Date: Thu, 20 Jul 2006 22:41:48 +0300
Message-ID: <f36b08ee0607201241t6160b1eqb4f0b255b02499a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 20 21:42:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3ePA-0003Do-OG
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 21:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWGTTlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWGTTlt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 15:41:49 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:34859 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030365AbWGTTlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 15:41:49 -0400
Received: by py-out-1112.google.com with SMTP id c39so845544pyd
        for <git@vger.kernel.org>; Thu, 20 Jul 2006 12:41:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QuNLw9pOjEQrQfITDX7mOrcWRJYHoDYpkcsi9O9mRXRn4AYVMZFCuAoUaXoTCDuFDMUiRCv0arGylby/KKgsh4SGw3v2uqdI9/pxzcOrb27Ua3X46kdmHo4vM9CkaAc/qiwefzLRklM2eiwaGPLogKRPnj3ulAN9oszi7dtAWDs=
Received: by 10.35.93.1 with SMTP id v1mr1618769pyl;
        Thu, 20 Jul 2006 12:41:48 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Thu, 20 Jul 2006 12:41:48 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24037>

There are two machines with slow ssh access. The
both have copy of same filetree that was synchronized
previously vi rsync. How do I put both trees under git control
as if they were clone on one other *but* (1) without creating
branches and (2) without copying files over (files are already
there) ?

Thanks
Yakov
