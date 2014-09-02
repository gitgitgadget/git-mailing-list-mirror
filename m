From: Jose Paredes <jose.paredes.rios@gmail.com>
Subject: git submodule, multi-threading the update process for large number of
 registered submodules
Date: Tue, 2 Sep 2014 09:53:29 +0200
Message-ID: <CAK9Skq_-cidRHrbVNgJqoV3nYCxRNDO6vTifOJRUFKaWEZyzkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 09:53:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOiuJ-0006Vv-7x
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 09:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbaIBHxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 03:53:31 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51033 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaIBHxb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 03:53:31 -0400
Received: by mail-lb0-f173.google.com with SMTP id c11so7062479lbj.18
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=qu/rfGAHcZCXv0kuJBG88cRK/1Eu42vs2eFqSEzxIE8=;
        b=yxV63lJoZXDeXtkZphmNFZYIemZlvOtZf/AsoJxYGk7Sy6xcwJ+GeSU7w1QZoD7L/s
         w/n6sis8j9chHcQKUEbprk0oADwEQGSbhWxcQInwFY3WSOcgl4MurviSczPJ+G+3a91w
         ZsX0I7VOizC90lY85P4osiYxrfccSx9hs/itr7sDuXZgJY+ZF+QdUhI6Tc1dz95Oax8G
         9s39SWPO+Lzj+f+AC2ZZ15YHL5Z6PNrfYG/xwOrUZOqhCi/mpmydy9GeFw650ERe6nWf
         5ycaBg3ZXxyLB1964Ee6GmpnElrYDXZdSDlzbjt2JWQILPMHtKP8ufJyq34rugMK+8cG
         Rkqg==
X-Received: by 10.112.130.73 with SMTP id oc9mr15877426lbb.31.1409644409429;
 Tue, 02 Sep 2014 00:53:29 -0700 (PDT)
Received: by 10.114.187.46 with HTTP; Tue, 2 Sep 2014 00:53:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256317>

Dear Git community

Is there any way to run "git submodule update" in multiple threads?

The use case:
-------------------
"git submodule update" seems to be inefficient when running
sequentially on a large .gitmodules file.
Assuming a git forest with over 7K gits it takes hours to complete the
update (running on Windows+Cygwin)


If not supported, this feature could be a good candidate for "git
submodule" enhancement.
What is your opinion or advice?

Thanks and regards

Jos=C3=A9
