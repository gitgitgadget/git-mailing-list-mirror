From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] run-command: drop silent_exec_failure arg from wait_or_whine
Date: Sun, 11 Nov 2012 19:13:00 +0100
Message-ID: <CAMP44s3_CDHhcEe_ponW__=TdG_c1DQyLU1VG4UCzOC=MxW9mQ@mail.gmail.com>
References: <20121111163100.GB13188@sigill.intra.peff.net>
	<20121111165544.GC19850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kalle Olavi Niemitalo <kon@iki.fi>,
	Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:13:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXc20-0002NA-4x
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab2KKSNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:13:01 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52702 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab2KKSNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:13:01 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5581541oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 10:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MD7M8pEDxdNmgm07qisAEyefXe7mJbI2qJNAVAlrXLY=;
        b=pI2JBXHXSZoaB/1fx0HgES0auSqfI3E39ZjxyBTIWmfv0Eu2nW0n4lKNCT0C95ukpv
         SL8MddJ2iwNmBdqoUIxOlVpwiz3VzwVhtmk+YuzImzkqOfyz8WFdm6JgLQJok6V93Gt0
         ivJ84MYpMwDoUH7EI79qIeSVjjTGDK5Ua0I1dLVby9uh2Ox1q1z++eaTDz6+7p9P9Fso
         YDinORE+WDX0iXT8/NZHuhHaXES0s7bOv17a9mHtg9rX34rRWslbkSnGIUs1v5uKmf8/
         QMa/s6ZgVDOeLBaAMrwR+YB4s8ukHlCofZWKfx1BCGiPScdDcxZOHC3Ozle7HRuZiDRB
         hp6g==
Received: by 10.60.32.19 with SMTP id e19mr13080023oei.9.1352657580430; Sun,
 11 Nov 2012 10:13:00 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 10:13:00 -0800 (PST)
In-Reply-To: <20121111165544.GC19850@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209433>

On Sun, Nov 11, 2012 at 5:55 PM, Jeff King <peff@peff.net> wrote:
> We do not actually use this parameter; instead we complain
> from the child itself (for fork/exec) or from start_command
> (if we are using spawn on Windows).

FWIW I noticed the same while looking at that code. Looks good to me.

-- 
Felipe Contreras
