From: Zhan Jianyu <nasa4836@gmail.com>
Subject: Does Git now have any C struct version history tracking mechanism?
Date: Sun, 18 Aug 2013 18:33:12 +0800
Message-ID: <CAHz2CGW_xR4Q193h2itCELdXEpoAxetj324ATstALHM03cSvFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 12:34:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB0J9-0004G6-0s
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 12:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab3HRKdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 06:33:54 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:60330 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3HRKdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 06:33:53 -0400
Received: by mail-wi0-f173.google.com with SMTP id en1so2157599wid.12
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=UZdR2Tyo1Kas9CN9cjDn8LBI1Ixsxfe/2yKZAIBjSUU=;
        b=JordTNK4XAdgNvdogXg67WUCFXXK2yBgzF7r6TaJC8VPKetlY7/3HfpnReDr9yjx1u
         2JcEwMIrhr2mNkvt7dgv/FRC89DiAyfU5Vc5ybQ9vKUfpCBE4Q8GTGn9gMFLNYGMWOJQ
         SLASQMQ3tjeqfTEgferSPbyljuTx94OjAUvF/eGwGwt7ck5vqYpFQ3kSiyMvTaU6QLgr
         0Ffgyv1ICsU40pDt6cEkIQ+97BiPJT23g0uFrAyPcqQueb3Tj4V8LHopPxhbQ3FmCiEP
         +DzYHnJsM3Yla15p6EMJYhHuLPu6ap/0W8OOezYLBWy9jxjf5hOFv7D+s+Bkx1S8o1lx
         pExw==
X-Received: by 10.180.85.72 with SMTP id f8mr4244174wiz.0.1376822032593; Sun,
 18 Aug 2013 03:33:52 -0700 (PDT)
Received: by 10.194.80.42 with HTTP; Sun, 18 Aug 2013 03:33:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232473>

Hi, all.

* Background

  Such a requirement came into my mind when I am tracking a gloomy C
struct , with lengthy list of elements which are either elaborated or
opaque. So I use git blame to track it down and found that its
original version is quite simple and intuitive. So I think I could
just slice out every snapshot of this struct, reading every changelog
, to get a better knowledge of what it is and why it should be like
this.

It seems quite helpful but the process is quite cumbersome. So I
wonder if there is already some mechanism fulfilling my requirement in
Git.  If it doesn't,  would it be worthy adding one ?

Thanks




--

Regards,
Zhan Jianyu
