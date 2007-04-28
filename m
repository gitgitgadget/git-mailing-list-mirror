From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git pull origin fails
Date: Sat, 28 Apr 2007 23:07:53 +0530
Message-ID: <cc723f590704281037v5d2142d7u2edf7e503cb3ce19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 19:38:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhqs4-0003Ay-3Z
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031767AbXD1RiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031785AbXD1RiA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:38:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:36963 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031767AbXD1Rh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:37:59 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1510223nzf
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 10:37:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EbHNYfjLgML0+SK4+y8rUZWWUV7/7RnjoRr1EI+Kmqho2ajQldppmqJ2ftl8y84bKHQeefhFcPzwMWKy/6wG4o2x88RPS/WkBer4mU+aa3TCwZudiZzsGDgKCqlSn/pxS1y9qfkbTedFe52PqZHCXpOMseelOQVV3XKed2+RgVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fiB1TrBR9ggBUWUoGDx0VXi28q4CNer/3h2odKTDmUG8Pyz21KR2D1sp9JeCX6oOMTCaShV9QChEc29jwGGCzievXZOs45P7KH+hmV+ErzX3MPjCSwwsgwPTg8PsTSa08d6kpnDD9dhrQO/Dk34A0UtHDgnTkBIziqh6qBz4aGI=
Received: by 10.114.148.1 with SMTP id v1mr1447231wad.1177781873460;
        Sat, 28 Apr 2007 10:37:53 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Sat, 28 Apr 2007 10:37:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45789>

git version 1.5.2.rc0.1.g2cc31-dirty gives me the below error when
doing a git pull origin


Warning: No merge candidate found because value of config option
         "branch.master.merge" does not match any remote branch fetched.


I was able to do
git fetch origin
git merge origin/master


-aneesh
