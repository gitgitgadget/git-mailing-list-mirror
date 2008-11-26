From: =?UTF-8?Q?Nikola_Kne=C5=BEevi=C4=87?= <laladelausanne@gmail.com>
Subject: format-patch problem when using relative
Date: Wed, 26 Nov 2008 17:12:02 +0100
Message-ID: <17081052-4480-4971-9F38-BD5C48087379@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 17:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5N1B-00073s-GO
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 17:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYKZQMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbYKZQMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 11:12:09 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:2583 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYKZQMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 11:12:07 -0500
Received: by gv-out-0910.google.com with SMTP id e6so186729gvc.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 08:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=VDjU+7kiNXiVRPjPioV0Kxl1sFMaglU862Auh6DU2Zw=;
        b=WVV6TV55nmRLi3Xm2Z1tJrwP826FtWX7rWiScOjiwrOWiCkxcHG0ebEgBKFfsH3OcT
         4p7/ZFq4peYJ/NnVfAyNNaLZQQ2vfCCcyELsHWXL2cdA17Ie4j/Un4npoFha8Fj1LPel
         gazJkIskerySNBVwtppQR9aqMD0mFWn4FHmmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=PWnIPdfkZhBkfct1OU/RmbMGbyYIPA+ptjZIgk5gyYn/7h5DSty5m8OrKvm1fPtRkL
         Q1JW2/Wk874PNJzSDW5f8IIL4OlP0FM2syee1Kd/zW3oFtfKLjr8OFk+DKb0Bo8+Bro3
         SFrzy/efVAtpxDILdFnk9lYJxsYiBGsZ9mU5Q=
Received: by 10.86.80.17 with SMTP id d17mr3889952fgb.14.1227715924226;
        Wed, 26 Nov 2008 08:12:04 -0800 (PST)
Received: from nslpc5.epfl.ch (nslpc5.epfl.ch [128.178.149.20])
        by mx.google.com with ESMTPS id d6sm1176824fga.2.2008.11.26.08.12.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 08:12:03 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101742>

Hi,

I have a subdirectory in my top-level directory, which I merged using  
subtree strategy. I want to send my patches upstream, so I did  
something like:
git format-patch -o patches -n --relative=click click/master myclick

This produced a bunch of files in patches directory, most of which are  
empty. When I tried this --stdout, I had something like this:
[PATCH 8725/8846]
[PATCH 8726/8846]
[PATCH 8750/8846]
..
[PATCH 8845/8846]

So, it seems that format-patch was counting all patches, but only  
printing the interesting ones.

I'm running git 1.6.0.1 on FreeBSD7/amd64.

PS. Please CC me, since I'm not on the list.

Cheers,
Nikola
