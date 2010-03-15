From: Maxim Treskin <zerthurd@gmail.com>
Subject: FEATURE REQUEST: Cherry pick in not checked out branch
Date: Mon, 15 Mar 2010 14:39:38 +0600
Message-ID: <be8f531d1003150139p7cc99700m807ab21bddf8fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:39:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5pz-0000Hj-BQ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933570Ab0COIjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 04:39:40 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:62984 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759885Ab0COIjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:39:39 -0400
Received: by ewy8 with SMTP id 8so980722ewy.28
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=0+WowMxpIe6bp2Yy2S+aOGHfEf9a9mdcihc6vZL1aFE=;
        b=fbiqvKvWBJh4RChFNcI0Q2rdH1y9r4nugyH4IlKRxoIpGsxUPLgOKMmf+CS68g5615
         U3gdECm1Hg8diCyhURWSNnHUjEvBUss3ZecQneASu8labu43TI4GU5qeflJXZzh3aVBD
         wzb2NHkYqdEzJTL/NmyCsk/FHg/jVtqIafytU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fIPU1XON6on2Xl1nm+2QX7Yg5sjqoP5oYiaiuQPNjDi7w6tksuPoA3A6ySaujfmmqc
         P9CANPcSoJn2X1ThOzbvrRQ6PdL12iDGL/Tq1Dqsz/+VKkCXAj2TnDmqBybCRTZQb6SC
         7fmCLVckTVoIIZAYSflTXDn4/HA217G2EuLEs=
Received: by 10.213.23.206 with SMTP id s14mr4406157ebb.77.1268642378040; Mon, 
	15 Mar 2010 01:39:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142194>

Hello

git cherry-pick applies the change introduced by specified commit only
to currently checked out branch. Why this requirement exists? Is it
possible to apply changes to not checked out branch, like:

$ git cherry-pick <branch> <commit>

Thank you

-- 
Maxim Treskin
