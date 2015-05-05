From: Eduardo Espejo <eduardo.espejo@gmail.com>
Subject: [BUG] deamon.c does not compile when NO_IPV6 is used
Date: Tue, 5 May 2015 09:20:15 -0500
Message-ID: <CAK4aQQJ9yT8+Q9jPQ78cauhyPj3j5WmpgrQJ5=cA-ECjaWn8BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 19:40:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypgpt-0006ko-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993151AbbEEQGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 12:06:33 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35010 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993155AbbEEOUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 10:20:16 -0400
Received: by oign205 with SMTP id n205so148472663oig.2
        for <git@vger.kernel.org>; Tue, 05 May 2015 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=54afVzMimXy84pGEaOwQ8kujilrUEpqEMyLWyRVCcQw=;
        b=wed/VPVVJLCe/QjNf2A621P/5eErbl3rf9EBHPqw6dVaQYrJ/GDQf83vEaQqObWiDd
         FrCtI31V1FOP/70EM/ejSVeruDBOgZCZ79huw23sUmEuuqVtyhGOI6SA5WhcqwjxH/C4
         IdzClF3Ynn6rjGaj2pvypYdSboxQzGXrnNdhxknSTYBAfGILYYoxLAKNMarem7sE5GzL
         To8ArR2UZzLHWVhQyMTvpM6f7lgQlXPhUtdGb1PMiqVtU0sglFSSO41oo2Nr8M21lGnA
         wDjgSsGpuOLsyc0W9TB6YIOBW0VAa3LNAeCADVD6nliW33jAlapWm0wLE6t/X7lhMwic
         RwKA==
X-Received: by 10.202.207.18 with SMTP id f18mr21991449oig.28.1430835616032;
 Tue, 05 May 2015 07:20:16 -0700 (PDT)
Received: by 10.76.157.195 with HTTP; Tue, 5 May 2015 07:20:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268406>

Tested in 2.4 commit 3d4a3ffe64:

daemon.c:636:24: error: use of undeclared identifier 'hostname'
                hent = gethostbyname(hostname.buf);

--
Eduardo Espejo
