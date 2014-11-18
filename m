From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ag, **, and the GPL
Date: Tue, 18 Nov 2014 11:09:18 -0800
Message-ID: <20141118190918.GH6527@google.com>
References: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Matthew Kaniaris <mkaniaris@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 20:09:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqo9S-0002CR-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbaKRTJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:09:18 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38880 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbaKRTJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:09:17 -0500
Received: by mail-ie0-f177.google.com with SMTP id tr6so5700740ieb.22
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 11:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/j9+e9js+x9YgdxFDENtQtX/qiHRcZN7qjz4q9XdlBM=;
        b=kfDgnPUEf+tqxBxoaFhmvLr/r5/fCPUxO7lGOQ//qPE6HgHLdmrDUauFhAUFG6kzpd
         +wHNjDZMrZDElIUkUr+zDuGKvOt6xJ7XoJXXJRTydTwEOJaxXeIPcL54oYq7t396I4mP
         kg37jnSuGZGg59Y2AtcQp2jhST05Li0z9PI/pVRreoEEJ9FPsHAvMFj/87rhT3Riltn7
         TwQxEip+GR9PeuQRmElMGH0mvQW4h9d/I/GU/NIUxhBZgNwgU9n8H07tL0gC7NX/ndiM
         OjwGhY7pppi9l6sZ/zN6l2aTJCC8S+lUI+7FIms15bad3W0ssNh9k/2FrBP7rNr7UhJx
         7BaQ==
X-Received: by 10.50.79.232 with SMTP id m8mr5618885igx.11.1416337756824;
        Tue, 18 Nov 2014 11:09:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id kw5sm14260igb.20.2014.11.18.11.09.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 11:09:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matthew Kaniaris wrote:

>                                                                   Ag
> is licensed under the Apache License Version 2.0 which to the best of
> my understanding is incompatible with the GPLv2.  Would you grant me
> permission to reuse wildmatch.c (and necessary includes) for use in
> Ag?

wildmatch.c comes from rsync.

Conveniently, newer versions of rsync are under the GPLv3, which
according to [1] is compatible with the Apache license.  The code is
at lib/wildmatch.c from git://git.samba.org/rsync.git.  It hasn't
changed since the rsync license change.

Duy, what would you think of making git's wildmatch.c "GPL v2 or v3,
at your option"?

Thanks,
Jonathan

[1] http://www.gnu.org/licenses/quick-guide-gplv3.html
