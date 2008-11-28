From: "Sudipta GHOSH" <sudipta.in@gmail.com>
Subject: remote branch checkout issue, why its *(no branch)
Date: Sat, 29 Nov 2008 00:15:14 +0200
Message-ID: <9e6474ae0811281415n7b4596afq7b3ce25816d9a639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 23:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Bda-00017R-Ko
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 23:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYK1WPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 17:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbYK1WPR
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 17:15:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:23342 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbYK1WPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 17:15:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1105088fgg.17
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 14:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=K3pXbPsrNpeLw1oTWzZOvspF5GENnK3E3kdx4Nug4Ng=;
        b=tZOYAYFGLIxzJtHliY1Pg3C8lyldLcZE9ri7BFwA+sbQdxT2q8RCs/Ml+7JjAcF1R1
         hlWrzEcvAWhP8FChoffWSNWwLAl/XFv4LnFD/RCofKoMxlXV+mKmC2bI7gctFe3/1teY
         SPJJAjT6bsPPZI8vyOAjWrKZMQN4OKuJH3s2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=DVc1BlkpcraQFwQeI5F8UhFYIM9pyOZSV5iDgRIoZ8aBIv4akWiibSxxP/3ztuxTv/
         OSZ5ZDZgCO21GXY2kIZBmZf1xbNxMscKlUKbLbk7DS8fMSQzp1C7ouDO/AyGBe+QQ6WV
         aGtmH1xHlOuAM/N5Kmu39Pqgo0qgXhPw1Ds88=
Received: by 10.86.59.18 with SMTP id h18mr5473370fga.77.1227910514248;
        Fri, 28 Nov 2008 14:15:14 -0800 (PST)
Received: by 10.86.97.5 with HTTP; Fri, 28 Nov 2008 14:15:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101887>

Hi,

In Our git repository there are few branches like

master
orgin/B1
origin/B2

After doing  #git checkout orgin/B1 I found that my current branch is
*(no branch)

#git branch
*(no branch)
master

Why its showing *(no branch) why not origin/B1

How I can checkout orgin/B1 and after that my current branch will be
orgin/B1 not the *(no branch)

Regards,
-SG
