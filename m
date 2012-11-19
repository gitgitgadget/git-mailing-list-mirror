From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Auto-repo-repair
Date: Sun, 18 Nov 2012 22:30:26 -0500
Message-ID: <CAM9Z-nmu2MiE9vF9T6Aw8vFTR8mTkuR3akHgZX6+=n3uA4fmpA@mail.gmail.com>
References: <CAM9Z-nn1S9JvfcymotOvSis4CoYco0Htn4uoETZn2kCto0z9zw@mail.gmail.com>
	<66719060-db68-45b4-8453-2fd996f27657@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Mon Nov 19 04:30:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaI4I-0004BE-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 04:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690Ab2KSDa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 22:30:28 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61743 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab2KSDa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 22:30:27 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1711199bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 19:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3P6UDCkZ28qiEmlnWLGdN+r8KISqnPa1inyh3lUULgU=;
        b=J805xiOF4J/xRuw8vxnFxnC0d+x2KYrPiJLp9ThtgVtFKQkNLa8USuh7pQL6QxxsF/
         CqZ1RxsAqXVE7iKPs93JP8QZTpoFJfyyj7lDef2L72ufsazFkNXYxraGAjQ2QyVsqB7E
         mNcGydCAjwskVRQPbkMIiJpzmIVjLAqkDdy2hIMAcKYhKsVGABz0I9StDYE6VRmRYpi7
         ++9Ua9T7qvopFrxC3EzMI9DSuJUwvT9V5wa4Dexgxvki3kd0H9ZpliRGJT5wcfjsZdnR
         /rTSpcYz0kgNBslU65G40n8h9I0LRR0e7aVd2xiZoy3ucOgPeE9gPA77rFdG7N6rEWeh
         12iQ==
Received: by 10.204.4.80 with SMTP id 16mr4222555bkq.73.1353295826354; Sun, 18
 Nov 2012 19:30:26 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Sun, 18 Nov 2012 19:30:26 -0800 (PST)
In-Reply-To: <66719060-db68-45b4-8453-2fd996f27657@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210039>

On Sun, Nov 18, 2012 at 11:55 AM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
>
>> How would the broken repository be sure of what it is missing to
>> request it from the other side?
>
> fsck will find missing objects.

And what about the objects referred to by objects that are missing?
Jeff's solution doesn't suffer from this recursivity problem.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
