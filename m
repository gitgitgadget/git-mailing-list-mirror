From: Gaston Fiore <gaston.fiore@gmail.com>
Subject: DSA key
Date: Mon, 21 Jun 2010 20:07:20 -0400
Message-ID: <3E984B93-F2DB-4F32-BBF9-C6DA3730C54E@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 22 02:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQr1W-0004o8-EY
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 02:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687Ab0FVAHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 20:07:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35691 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639Ab0FVAHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 20:07:23 -0400
Received: by gye5 with SMTP id 5so2602572gye.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=GnX+W+l1Me1dhFTsjxSCjesTBSJ89VB1i+BMBXZE9Sc=;
        b=QYY3byio2mX6Szqxp/TjLoL6T3HmDM22oDbhkro8QM0bT9t+m1KAC9ktWRIXk98b3f
         7Z4itKNekJoJtankfFsu30g/V0St2UutNHxHnU8LwuxU6XMy3DeeD+92IL4PXBXlPqde
         ftwktWx4TLb7HX5EFcpApqo0pw6gX5N1h6/e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=rBOpWLgBrcWCvyPsIewgAic0mJ63QjXA3aA048R0mj50SxeRJlwnlvMa5PvvaZf0lF
         xoZeyofosFkmH7IectIqcWloL5bfeSWYo7NufB2ijfHonmQuTyPm5huSLt5sUzPOGdFz
         T/OpA1TNXT+5MNGayVvMn7HqsaNygc0Q703jo=
Received: by 10.229.185.195 with SMTP id cp3mr2953676qcb.217.1277165242233;
        Mon, 21 Jun 2010 17:07:22 -0700 (PDT)
Received: from [10.0.1.5] (dhcp-233-72.harvard.edu [128.103.233.72])
        by mx.google.com with ESMTPS id m29sm52373673qck.40.2010.06.21.17.07.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 17:07:21 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149459>

Hello,

I'm trying to verify the download of Git and I get the following:

gbrain:Downloads gafiore$ gpg --verify git-1.7.1.tar.bz2.sign 
gpg: Signature made Fri Apr 23 22:49:17 2010 EDT using DSA key ID 517D0F0E
gpg: Can't check signature: public key not found

How do I know whether I should trust the downloaded file?

Thanks,

-Gaston
