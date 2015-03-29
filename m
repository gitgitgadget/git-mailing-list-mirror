From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Change default branch name (server side) while cloning a repository
Date: Sun, 29 Mar 2015 13:03:23 +0530
Message-ID: <CAGDgvc3BWfCOMcQZunq5H0FpP05L3J7bPHpnpM4gJRSkChco2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 09:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yc7iy-0003xk-2p
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 09:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbbC2HdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 03:33:25 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37865 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbC2HdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 03:33:24 -0400
Received: by wiaa2 with SMTP id a2so84500268wia.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Xj/eMVF6etKqL1YwE0MCfii9JXp5exHSDxeH/BDhqU4=;
        b=RkUqSTx1HbFOKrR7kVNy8oWrl2KoMeqLoElLashsmagkuJpEEJhfkUDWRhXzSfkb4x
         3MmpSMKpGOA6GBK2tv4gOCnwxgiHXh1K7s1saH48s817vS4S9xYYMItKh1oF1J/3SmNT
         4ZTPv2JGepYniGTIZR640kyHwII2TBwLsx3oycGqNxSt0XxvljHLVLdKw/w0nW7FbOsI
         dtBkZ7Hd4E5sUTOpaO8wgS2qvPJ00/ajKFj4hyqWXQJSUSu9wRFvEPxCZCsW9g2qGRum
         otc6r3rZMSXN0i+UZBWFtY0a/yd6CvgVuRFsiynJvc3H2cYhaBG3moLjMP1i5vENtR2B
         VOdQ==
X-Received: by 10.194.177.195 with SMTP id cs3mr50738218wjc.141.1427614403836;
 Sun, 29 Mar 2015 00:33:23 -0700 (PDT)
Received: by 10.28.149.198 with HTTP; Sun, 29 Mar 2015 00:33:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266430>

@Stefan: Thanks for letting me know the version you tried on.

I have the following:
Gitolite version: gitolite3 v3.04-13-gcc9727c-dt on git 1.7.1
Git server version: git version 1.7.1
Git client version: git version 1.9.4.msysgit.2

My Git server version lags quite behind compared to yours. :) Clone of
any repository is not empty because i create non-empty directories
while creating any repository.

@Matthieu: You were right in saying that client can get confused if
several branches point to same commit. :)  Thank a ton! :) Going by
what Jeff mentioned confidently, my server version (1.7.1) indeed has
that flaw.

@Jeff: You've hit the nail on the head! :) Both Matthieu & you are
right. I even confirmed the same by changing the content of mainline
while initializing repository. SHAs indeed became different for both
master and mainline. Now when i clone the repository on my local
machine, it correctly points to mainline. And special thanks for
pointing to the exact Git version where the flaw was fixed. :) I
checked the release notes too. :)

https://git.kernel.org/cgit/git/git.git/tree/Documentation/RelNotes/1.8.4.3.txt

Thank you guys! You rock!!!
