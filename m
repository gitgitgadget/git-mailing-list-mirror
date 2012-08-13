From: Stephen Boyd <bebarino@gmail.com>
Subject: send-email and in-reply-to = n
Date: Mon, 13 Aug 2012 16:50:33 -0700
Message-ID: <CALaEz9WQJBQ+OtDOhjH7Gz5Uw9Hu+82fOikf20WuTZy4RJsBPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 01:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T14PP-0005Gj-N3
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 01:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab2HMXuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 19:50:50 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54115 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab2HMXut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 19:50:49 -0400
Received: by ggdk6 with SMTP id k6so3895093ggd.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=RpL5/Ut0wCzolIEtOVRfvn+xv/09cKsAtTKXLRCabM8=;
        b=N7JKP/FF8JNMqQRB1eWvEWWfG9z4qudG9mhTuRnuzVx1UXixjVJe7lvLFUSqaZLM8Q
         GyOBSMPPHi3hv2AAuhdKvzGmORrxPyjA0bTiSoTVsy7h8P7VLaMrDiw+AEaCOwvr7Aee
         ui8rkrKeYhWa5GEacBhyeQfcUPJIHmwhq4MK9vg048ZthrJ8ayaV83/tzuXNnXvmWQY2
         norEiB8Z8XcSpBY1hPll0H4zZUxhmDz36kMZcjw+HKy3uWHwDoQtgjbNJ5CVNypoPJjN
         NZJZoUgoj2o8SZzI88epLNdUr2gyyYydjyhxhoyZuaFc7ldQx27A0KudWgY/N1VyS6tN
         ltWA==
Received: by 10.42.76.147 with SMTP id e19mr7164648ick.17.1344901848699; Mon,
 13 Aug 2012 16:50:48 -0700 (PDT)
Received: by 10.64.110.162 with HTTP; Mon, 13 Aug 2012 16:50:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203375>

Can we throw up a big warning or just outright fail if someone types
'n' or 'y' and hits enter for the in-reply-to question in
git-send-email? I saw a git-send-email sent patch with an In-Reply-To
header containing n on lkml today and it makes threading in my mail
client get confused.

https://lkml.org/lkml/headers/2012/8/13/503
