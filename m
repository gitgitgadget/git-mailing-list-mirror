From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Change git gui language (+ some other suggestions)
Date: Fri, 17 Apr 2009 16:47:57 +0200
Message-ID: <237967ef0904170747l61adf4feq1a5df5f1b26debe2@mail.gmail.com>
References: <49E89304.9060303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kai Schlamp <schlamp@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 16:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LupNm-0004Uy-AC
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 16:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249AbZDQOsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 10:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbZDQOr7
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 10:47:59 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:51628 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbZDQOr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 10:47:58 -0400
Received: by ewy24 with SMTP id 24so257090ewy.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j5E8wtiKXrWG4wTO0aG1GcYKkktZjBDyGddA0G2Zux4=;
        b=ZDp7jauaBnv3m8TvgO9JRAn59rGs7z8YEZKR2Wc7MrIvvkBOqy3ZusaCyFhXnMt9ys
         sUlWXcPj/hn+FdlXsyuYTTcGsBUnm6Q8GDN+PIbrgTnnn5E4sBSh3kDu+7GpMR1JRuju
         AsKRz+MhHmja8MqFLvGnkXKWK0AjNRyBldink=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M0T2OV92wT/QHXqn1Ca6tpA15bsLvRQAXtwM1SS6pDgimVA5VJgXw6K2vAJZeldWy0
         D+ioToM1qbCyrynHKFlyUvuhBgbTuB61YsafszPhOPg9EkMatnuRP4Xr9pQdhtxTHuYw
         zt2vYcR7Xndl4ryeUh/Ml/bF9NhVYeQUajp48=
Received: by 10.210.37.16 with SMTP id k16mr2815522ebk.54.1239979677146; Fri, 
	17 Apr 2009 07:47:57 -0700 (PDT)
In-Reply-To: <49E89304.9060303@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116741>

2009/4/17 Kai Schlamp <schlamp@gmx.de>:
> Hello.
>
> I know this had been discussed before
> (http://article.gmane.org/gmane.comp.version-control.git/61884/match=git+gui+language),
>
> but in my opinion there is no acceptable solution yet.
> When I set LANG=en it also changes my keyboard layout and thats quite
> confusing.

I don't know much about language selection on windows (which you
didn't say you're using, but I'm inferring it from the referenced
thread), but you could try setting LC_MESSAGES=en and LANG=de_DE or
whatever germany is, that should at least work in linux :). Maybe tk
is nice enough to follow the same rules?

-- 
Mikael Magnusson
