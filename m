From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: git problem: pack has bad object at offset 77100841: inflate returned -3
Date: Wed, 6 Aug 2008 12:45:16 +0530
Message-ID: <ace3f33d0808060015t25d9c21epc31e48e3c1d041b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 09:16:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQdFw-00008H-Gv
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 09:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbYHFHPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 03:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbYHFHPT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 03:15:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:45550 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbYHFHPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 03:15:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1672636ywe.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=noSMJwX2QtlA914xLShKsl1gaoDk9krkrW9aJbJCgxY=;
        b=gbmQOJSDoSfhiGXDNH0g9eUA51/Zor2RZJFRa7BX9JDSwqk5bUmkdg2ZSjF+T9T+sP
         muURXra4YRsp0kEUtYoW8JuBI+IFwctEDTrKCuw93u+lW2kVmuh2w7kq/rKFChA0LFd6
         xRHm0g5Gb7cL6chqPHImWyzQ4KW0MEFE6Tqdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=vY9YjPoWiJnHB7veZC12F0Xvbp2tkeizSR+ri8nRpLbwk2cTKdQRbMnt49RiZBaYCy
         +B2mHfyaTwkpkEWmJ8K0tScRy35XdUxxT4D7nxL6zRVu9ATaWaQ0j9+XqbiyvJ16FGHw
         TWqtj78RFGaeY9NdTaKKnFZUOrRipO0wf9Qow=
Received: by 10.151.112.14 with SMTP id p14mr2800454ybm.227.1218006916662;
        Wed, 06 Aug 2008 00:15:16 -0700 (PDT)
Received: by 10.150.145.18 with HTTP; Wed, 6 Aug 2008 00:15:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91488>

I am facing the error

remote: Counting objects: 879862, done.
remote: Compressing objects: 100% (156686/156686), done.
fatal: pack has bad object at offset 77100841: inflate returned -3
fatal: index-pack failed

while doing "git clone" of linux kernel of latest 2.6.27-rc2.
But am able to do the latest stable successfully.

Could you help me out in get rid off the problem. And am new to git usage,
so correct me if am doing any wrong.

I am using cygwin, git 1.5.6.4


best regards,
srinivas.
