From: Aghiles <aghilesk@gmail.com>
Subject: mini-wierdness with "git am"
Date: Wed, 30 Nov 2011 18:12:55 -0500
Message-ID: <CAKCZoVb5-JfzTXK9pUoem_0oQHrSLkrxQZUOZGTX3GGgebPGwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 01 00:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVtL8-0007hU-By
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 00:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab1K3XNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 18:13:17 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47549 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab1K3XNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 18:13:16 -0500
Received: by ywa9 with SMTP id 9so1177402ywa.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=EtYdLimyUdnVKsAOclozwRTAjvxn9icLx3uqJES3LSM=;
        b=RpMH0mkuLHGn0MjA18WWgvtdbCH7wUzGQr4AE2y9v3+/VJ+1hHIRD3Oq2psZ8So3zz
         ok0i2Q/G3fOIVXr5M/P7ez6wUgMhao/mHeQmUo/OGcPIJ4ekQt48VrSqMw58m41VbGm9
         gYJdjLkylddBkacpOtXmrTUEVnGekcqmQV+EY=
Received: by 10.50.213.6 with SMTP id no6mr5376785igc.51.1322694796319; Wed,
 30 Nov 2011 15:13:16 -0800 (PST)
Received: by 10.42.76.1 with HTTP; Wed, 30 Nov 2011 15:12:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186145>

Hello,

I am using : git version 1.7.0.3, in Mac OS X.

A slightly strange behavior occurs with "git am --abort". Here
is the sequence:

> git am 000*
error: ... : patch doesn not apply
(oops, forgot to reset)
> git reset --hard HEAD~1
> git am 000*
previous rebase directory ... still exists but mbox given.
(oops, forgot to abort)
> git am --abort

At this point, my repository is back to ORIG_HEAD!
Meaning that it reverted my preivous "git reset --hard HEAD~1".

Hope this is clear.

As usual, thanks for the great product.

-- aghiles
