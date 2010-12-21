From: Alexey Zakhlestin <indeyets@gmail.com>
Subject: "git pull" doesn't respect --work-tree parameter
Date: Tue, 21 Dec 2010 19:04:31 +0300
Message-ID: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 17:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV4hZ-0000VK-Sk
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 17:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab0LUQEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 11:04:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61572 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0LUQEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 11:04:32 -0500
Received: by iwn9 with SMTP id 9so4330827iwn.19
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=H9jTT06HP+ZWXZnrI2q7+ntzBRahim/yA7eGrGA/GEg=;
        b=uNDK0qOe/2/ToNMW7iBsUI/RnSsPzCA3vOw2qKTTee/i6Av29LmFZgcJC3BojRP64H
         i9ejkHxLidte4Ur+EFyYf1btbayA3cxbE32M8qzanK0wrymRre0K4t1n6dLSLlAWNAJA
         o7pjOHoAkWAFDG7U0vhDVVzcU/IxrnKWFk30Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=G9tjnu07BT3Oyo7XYz9HJmQtU9r62Fv9zM1eJa/KVy5d2bzaRfNm9g84d1kcAe+kVx
         4yO4Orkmr8K/bZv9EsFQUUM+CcLOCo0xk4eRG/Y+U3p5SaIL/HWuFfgi3zkYBecXH9pQ
         zbguSO3GLtR1Ia+EEK1BDECK4s42nnOZJ/57s=
Received: by 10.231.199.136 with SMTP id es8mr5611575ibb.121.1292947471905;
 Tue, 21 Dec 2010 08:04:31 -0800 (PST)
Received: by 10.231.11.133 with HTTP; Tue, 21 Dec 2010 08:04:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164039>

I am trying to use the following command:

git '--git-dir=/path/to/repository/.git' '--work-tree=/path/to/repository' pull

and get this error:
"git-pull cannot be used without a working tree"

I get the same error, if I try to use corresponding environment variables


looks like a bug, because I can, successfully, use "git status" with
the same --git-dir and --work-tree parameters

-- 
Alexey Zakhlestin, http://twitter.com/jimi_dini
http://www.milkfarmsoft.com/
