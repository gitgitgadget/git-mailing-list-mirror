From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Thu, 28 Jul 2005 13:09:37 -0400
Message-ID: <42E91151.7060004@gmail.com>
References: <20050727083910.GG19290@mythryan2.michonline.com>	<7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>	<7v64uvh0mo.fsf@assigned-by-dhcp.cox.net>	<pan.2005.07.28.07.45.31.245357@smurf.noris.de> <7vk6jac2cv.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 19:13:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyBwJ-0008LR-JL
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 19:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVG1RMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 13:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVG1RJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 13:09:57 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:19250 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261777AbVG1RJn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 13:09:43 -0400
Received: by wproxy.gmail.com with SMTP id i3so461404wra
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 10:09:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=V1DyPNn8ctr4XIqmASKsCVWcJYlv7SiVaP6q5dm/T49yiDgZzxAxWwOTLyElMYseUg8j7F0QGJC7NvbAeBhcsGcmis4owdtoThfY8zA4blXk7lMwQH1sOmtYRJy/24LGhc4iv5hYAmzBAoL0F5Ofa+KFbAy3itYOLcIjXjfy/SM=
Received: by 10.54.54.39 with SMTP id c39mr689456wra;
        Thu, 28 Jul 2005 10:09:39 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 13sm864393wrl.2005.07.28.10.09.38;
        Thu, 28 Jul 2005 10:09:39 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6jac2cv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
...
> While I agree gitk should not come as part of git package, this
> brings up a different issue.
> 
> Ideally, I'd want to see gitk packaged from its repository
> kernel.org:/pub/scm/gitk/git.git/ Paul Mackerras maintains, not
> from GIT one which _will_ lag behind.
> 
...
> 
> While I _do_ rely on gitk in my git work, and I _do_ like its
> simplicity (just a single file right now), my longer term
> preference is to drop the copy we have in git tree and treat it
> just like the other repository browser, qgit.  Our documentation
> should point people at it as part of the Porcelain suite.

Then this should happen sooner rather than later.
