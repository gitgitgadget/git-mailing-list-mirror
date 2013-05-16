From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 5/6] test-lib: allow prefixing a custom string before "ok
 N" etc.
Date: Thu, 16 May 2013 18:53:15 -0400
Message-ID: <CABURp0pZQFB37oBDab1h3r8w7nj6jb+HXwPrbn=9pQhfLkTMMQ@mail.gmail.com>
References: <cover.1368736093.git.trast@inf.ethz.ch> <f440021d75345b1242e54f47697c3d2ac9593e99.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 00:53:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud73Q-0003jN-4k
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 00:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab3EPWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 18:53:37 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:42416 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3EPWxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 18:53:36 -0400
Received: by mail-vc0-f179.google.com with SMTP id hz10so652777vcb.10
        for <git@vger.kernel.org>; Thu, 16 May 2013 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wJ7I3yymnw6vZs38QTJKZQx3VfASnDMDJ+C5+UW66zs=;
        b=nO1aZ/CyCre4AliNWfrJmOL1YwrJBhncPs2kzMZJn/9mPGom8s2RUaU6ren1pt6hdM
         MXI8LHulaGG5DVNxoKuTtI+RFYD7kwPx8Sh5zS9izEe34a6crlvyGI91NRlrhEnOxN4F
         UIqQk2keLZOh1VRB8TG1jMRWvp798T4rQSx+2TTmk8AzEOi5HEQP/Tf2u/PL2zNtS2zE
         2Fh0Y18mWuc1bz8v0YCyiQg7MnuF98vyVzntVAHkuCsulukYMdVJouxHdQChtm0rHgdA
         EBr9vsLKd778vXqULGrkxqQpzISHr1hC8dKHfUy19N5Vxk/Bcntu2P9/tfTKi39H/mav
         qYPg==
X-Received: by 10.58.202.103 with SMTP id kh7mr13907562vec.19.1368744815862;
 Thu, 16 May 2013 15:53:35 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Thu, 16 May 2013 15:53:15 -0700 (PDT)
In-Reply-To: <f440021d75345b1242e54f47697c3d2ac9593e99.1368736093.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224624>

On Thu, May 16, 2013 at 4:50 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> This is not really meant for external use, but allows the next commit
> to neatly distinguish between sub-tests and the main run.

Maybe we do not care about standards for this library or for your
use-case, but placing this prefix before the "{ok,not ok}" breaks the
TAProtocol.
http://podwiki.hexten.net/TAP/TAP.html?page=TAP

Maybe you can put the prefix _after_ the "{ok, not ok}" and test number.

Phil
