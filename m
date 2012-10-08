From: Thiago Farina <tfransosi@gmail.com>
Subject: build deps
Date: Sun, 7 Oct 2012 21:39:37 -0300
Message-ID: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Chacon <schacon@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 02:39:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL1Nu-0002wh-2b
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 02:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab2JHAjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 20:39:40 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:36546 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2JHAjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 20:39:39 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1906950lag.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 17:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=S/tfmN4t0yzgWat3ioI0ovWR7Ct2FW8YLgxxsaYN9V4=;
        b=RIQ64nAC4VEqwV+tpy5MtN6aYCAYN3/gDrpyTqRC2QLlFcQsYIrOXOu3qwoxtw/c4J
         u0quTaz/JPA2TZyu/mbxO9GHZO+S+XgqtFXhw7Rsc3eQyzBMXhq//168x04350YMRHGy
         jycknTy+kYZX48cPiXkeSm3Yl//uEWjHy4zjL+iD/FI56GMQb7AJEjJ22gKrLD/X5yDm
         uh+QnXmWN5XdpATpAds0aXFNWSzbaXQ/oIWhvKCY74J+bAMiKnHYZcrAo4EWfSOtUTA+
         eK4Tti60jBoeXtXBKfp/m3Yj9sifQYTlu2f9IoF3gSpsCq6A+Rx+1x09CsFMp3nPq9Ta
         Thag==
Received: by 10.152.148.195 with SMTP id tu3mr11999739lab.16.1349656777889;
 Sun, 07 Oct 2012 17:39:37 -0700 (PDT)
Received: by 10.112.24.10 with HTTP; Sun, 7 Oct 2012 17:39:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207220>

Hi,

When trying to build from source but it's failing:

$ sudo make prefix=/usr/local all
    LINK git-credential-store
gcc: @CHARSET_LIB@: No such file or directory
make: *** [git-credential-store] Error 1

I'm know I'm missing some dep and googling for it.

But wouldn't be better if we have something like [1]?

[1] http://git.chromium.org/gitweb/?p=chromium.git;a=blob;f=build/install-build-deps.sh;h=705d4c210455f36916be607d7fd0f32f0b472c70;hb=HEAD

And yes, I'm following these instructions [2].

[2] http://git-scm.com/book/en/Getting-Started-Installing-Git
