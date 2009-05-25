From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] git-am foreign patch support
Date: Mon, 25 May 2009 21:24:08 +0200
Message-ID: <cb7bb73a0905251224r31e36422nbc221b860002be80@mail.gmail.com>
References: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <fabb9a1e0905251219q3fbd2d17hb08649b9113baba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 21:24:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fmT-0006Tp-RQ
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbZEYTYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZEYTYJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:24:09 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:48865 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZEYTYI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:24:08 -0400
Received: by fxm12 with SMTP id 12so1544423fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ET+Aj57xTHIOB8KX9hQH+dRSClkyczixPy9iEsvyPvc=;
        b=H3YKmE+9R2NndecD68ys2Ye44aLRdty5CJVBLs+oR6k6USVvJzK24UKsr1UOvQ759A
         iAXW87mkUB6BYxZXSXWqhIwBKdOVCKsCezjBJy6QJ04zlYvK34RiiAkZ14wGFanXQ4P8
         1JAxDJjem/E6XZZuIRjaOKRgbLsdjVElsLatM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vsLjH/b4hJdTnih7/nZ+TOxQjRGd3jCl+MPeA2Vy99Sc2O1DIlJMnOgpvzTqP4niyB
         0f9lXi/byZYPSocngePo8T8PKUpU/WYZIpjaub0rYAbKq1eJibYs/4Km/JJkh7rD57DM
         xH98BnV1YgoBW3/JtZ3plAI3L5iQ8qGEq8csM=
Received: by 10.204.31.77 with SMTP id x13mr7258655bkc.6.1243279448325; Mon, 
	25 May 2009 12:24:08 -0700 (PDT)
In-Reply-To: <fabb9a1e0905251219q3fbd2d17hb08649b9113baba8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119958>

On Mon, May 25, 2009 at 9:19 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Mon, May 25, 2009 at 21:14, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Autodetection for Mercurial [...] patches is also implemented, [...]
>
> Sweet! I now have a vested interest to see this accepted :P.

Keep in mind that presently it just detects them, it doesn't actually
import them. But their conversion to mbox format seems rather
straightforward, so it can be added easily.

-- 
Giuseppe "Oblomov" Bilotta
