From: Eloy Espinaco <eloyesp@gmail.com>
Subject: Verbose as default for commit (optional)
Date: Fri, 24 Apr 2015 16:18:09 -0300
Message-ID: <20150424191809.GA18897@alvaca.santafe.altoros.com.ar>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 21:18:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylj7G-00056b-E9
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 21:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbbDXTSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 15:18:18 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35546 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965437AbbDXTSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 15:18:17 -0400
Received: by qkhg7 with SMTP id g7so36147548qkh.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=PxmfPhmYWK7vAnJtKzGpt00dIbrOkke/zmhBKaMsduQ=;
        b=qkPxT0EUWe8NKDvGfM+aVycXFQ5rezkm7sxY5qtlc5m07Nvfv/1vi6C0BK2jb7mkps
         y76OGsliS1C+++S0i9r69qLwcwXrvpD6ms3wU2ZkLDBv+Assfwp1cTqO2glc999xm6Nc
         xgj2UkQ0+P0jakGfsbhIbJ3LTenMZw2Yp0W/AZsIr0AbTnLnt7ASJAQMsyCyte0kLoX2
         ifk4+ZacTqTGCWLiGpNkn406+6A47TAcKDoxNOSDddiSmw+A6/S0tL0zwlgV6oJycCNS
         6XNtm5tokFDoR5NmOF6fn5QYw1KobQGifg7ZI2fIqCxnyLbcboS99jgNgR2qeDbx/xMm
         Uy3A==
X-Received: by 10.140.91.246 with SMTP id z109mr6745972qgd.39.1429903096781;
        Fri, 24 Apr 2015 12:18:16 -0700 (PDT)
Received: from alvaca.santafe.altoros.com.ar ([190.183.238.58])
        by mx.google.com with ESMTPSA id k71sm8839246qhc.42.2015.04.24.12.18.15
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 12:18:15 -0700 (PDT)
X-Google-Original-From: Eloy Espinaco <eloyesp@alvaca.santafe.altoros.com.ar>
Received: from eloyesp by alvaca.santafe.altoros.com.ar with local (Exim 4.84)
	(envelope-from <eloyesp@alvaca.santafe.altoros.com.ar>)
	id 1Ylj77-0004yi-33
	for git@vger.kernel.org; Fri, 24 Apr 2015 16:18:13 -0300
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267750>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

It is my first mail to the list, so "hello world".

I wanted to make a feature-request about a config setting to make the
commit always verbose. I'm not the only one asking for that, there is an
old question in [Stack Overflow][1].

So I was thinking if it was possible to make a pull request for that, so
I attach the patch. (I'm proud of it :) ).

I wasn't able to make the test for it, but I wanted to ask (before I
try) if it makes sense to add this feature (or if it is considered
feature bloat).

Thanks.

--- Eloy Espinaco

 [1]: http://stackoverflow.com/questions/5875275/git-commit-v-by-default

--a8Wt8u1KmwUX3Y2C
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="commit_verbose_config.patch"


--a8Wt8u1KmwUX3Y2C--
