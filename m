From: David Shen <davidshen84@googlemail.com>
Subject: how to track a file which index has been removed?
Date: Thu, 5 Mar 2009 16:37:53 +0800
Message-ID: <53e35fd50903050037r5a96f9bfo5db49549f7b082c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 09:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf976-0002mV-OS
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZCEIh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 03:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZCEIhz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:37:55 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:6556 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZCEIhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 03:37:55 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4425175wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=X5Qt+blBt2RdVVt331krME+Gxna7z3koqcMzz9X9ZIM=;
        b=jC6raOZLYXRgPVnoLZo10KJrNE5dTTn93SkmmiYCpjeuLOiMVFfjeR87FMTi3HGJwt
         E9fOple6rA084xlPM160PTcGrKloWLTLjYWxackxF/JXMNDjcXhBMoa5wCid+B2LaFBn
         N2pHbA12isc+QWvi7yYz8RR9WW5O2kikwbmAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=V8AUJ+lpiAI1jJDflrypKhwhy+/ohsTgov4fOUIYesib9Wylx6haoDlwvn5Egy+lrz
         84Emvsq3Myd1G/WrF1wu8qy2b2HkwsGa4ekfTrAsHj3spCvF1vqlYfnZDzA5MJtoHKfZ
         55HMaaukl0I1uyLwkXdTknIxfSAgCk8c90y1M=
Received: by 10.142.135.16 with SMTP id i16mr413682wfd.250.1236242273338; Thu, 
	05 Mar 2009 00:37:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112266>

Hi,

I removed the index of a file using git update-index --remove by
mistake. I tried to use git update-index --add to add it back. But the
change to the file still not tracked. how to fix this?

-- 
Best Regards,
David Shen
