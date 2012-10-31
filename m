From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] git-push: update remote tags only with force
Date: Wed, 31 Oct 2012 08:26:58 -0400
Message-ID: <CAM9Z-nk6YRtNXNHbp-ReXB78V0O01qng+zmWfzm7Yxz51x22Yw@mail.gmail.com>
References: <1351661875-4307-1-git-send-email-chris@rorvick.com>
	<CAMP44s2T9Rmfjd8r+2+eYh8JBPXEofm3cHuEkkY+R3cW6R6HxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:27:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTXO7-0004WO-Pm
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 13:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab2JaM1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 08:27:00 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40684 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab2JaM07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 08:26:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so620048bkc.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xckpXa4t+OFZSN9JycF1HopZI7sSqOIRsMhkcnykV6Q=;
        b=Ddhbl2ujAc2uQ6OKkBwmyyIq+rCwA8Tb3xFG1mBme04ikLpnUF6aMOZx0R9Wjs5de/
         i6lYpaZO68Lm4OU5Z5IslO9W9OPbVAMULhOEVeYFQaN3S2xaeITwXnXdl+NKobrLsTHT
         7w5Mg7UnDvKl8JiWtBPDvxEyI2fLza5z2Dr92omYHANvcHVRw553DyahKY4Rct4TRvfu
         7euqK8te+Brz+2MrKFqEDkY5oOxzqijCxZ9VQbQxr7XW+wMFKLPtysrv4Ngth4KmbQvm
         voCSjPnJ/2bDY8zNrkzU2FuVU7UQhEjcLji0qaW/BiG7MDSuQrQA8klSiuF7Yzz/kruI
         JhiA==
Received: by 10.204.11.210 with SMTP id u18mr11385468bku.123.1351686418666;
 Wed, 31 Oct 2012 05:26:58 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Wed, 31 Oct 2012 05:26:58 -0700 (PDT)
In-Reply-To: <CAMP44s2T9Rmfjd8r+2+eYh8JBPXEofm3cHuEkkY+R3cW6R6HxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208812>

On Wed, Oct 31, 2012 at 1:55 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> but I wonder if it might be
> possible to split it to ease the review.

Agreed. Also, do please CC ALL interested parties from the pre-patch
discussion thread as well as those who previously maintained that
chunk of code.

[Attempted to reconstruct CC list of discussion]

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
