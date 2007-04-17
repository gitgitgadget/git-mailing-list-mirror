From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: push-hook (on the receiving side)
Date: Tue, 17 Apr 2007 04:05:13 +0300
Message-ID: <f36b08ee0704161805yd9cbd22ue8af69682979daba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 03:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdc8Y-0001te-A6
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 03:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031047AbXDQBFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 21:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031048AbXDQBFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 21:05:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:59292 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031047AbXDQBFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 21:05:14 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1846153wxd
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 18:05:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t4XQ2K16CaHUK5Mhl5PXrkL1z2OyXd/rSq9yOinwqtXq23Jgp9BxtmIbf05kxOLItsuVD0SEzu3bbAgtbYmlcPg52OLqNiXzYMLJGZSRh0fQ8vRW/SJmLSlM0YOSoEYh6jpioffNFerD2l9tBBbCyzLxVVFwK7+MiCFAdgLRFRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B8fwLY4CyxEi+eN2QNxvk9Zgr2R4ROxLgk3xOt55qrB/uxdSXN711tMcBU1sk6ScZ4Pe3rZ/ZV+sOpwvG3ldYcHwWGp5sAzywKCfpGSUJvfCDQpNrWraBpYi77k8RCAKhw4Drr2fgjZuNCqFkvGjySRpT9h+sA1sPMyEReCd5f4=
Received: by 10.90.105.20 with SMTP id d20mr5772086agc.1176771913738;
        Mon, 16 Apr 2007 18:05:13 -0700 (PDT)
Received: by 10.90.83.13 with HTTP; Mon, 16 Apr 2007 18:05:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44703>

How can I define the push-hook on the receiving side of the
push, so that some script or command is executed on the
repo on the receiving side of the push ?

Thanks
Yakov
