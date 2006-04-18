From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Confused about tracking git master
Date: Tue, 18 Apr 2006 12:47:18 -0700
Message-ID: <m2y7y2eke1.fsf@ziti.fhcrc.org>
References: <m2wtdmg3in.fsf@ziti.fhcrc.org>
	<20060418185937.GD13672@vsectoor.geht-ab-wie-schnitzel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 18 21:47:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVwAl-0001pK-MH
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 21:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWDRTra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWDRTr3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 15:47:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:15635 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932300AbWDRTr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 15:47:29 -0400
Received: by nz-out-0102.google.com with SMTP id o37so891721nzf
        for <git@vger.kernel.org>; Tue, 18 Apr 2006 12:47:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=I7lew5cKkdW9n9R2PBPer1TWawqiJiYrIboHcV5yusF3AdsP7jfpdtCp0hCFn0tQad5eLYTbVpECeJQKKiDBKh6cyCJm9zQkQScpLcQmjvchxAO5Flwq5Y4pzfJcbm+XQx2UAPIS2e1lr328bYHliv+2ITAHEJ2rKVxPueVq/88=
Received: by 10.37.12.48 with SMTP id p48mr2060308nzi;
        Tue, 18 Apr 2006 12:47:28 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 36sm637984nza.2006.04.18.12.47.27;
        Tue, 18 Apr 2006 12:47:28 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060418185937.GD13672@vsectoor.geht-ab-wie-schnitzel.de> (Nicolas Vilz's message of "Tue, 18 Apr 2006 20:59:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18875>

Nicolas Vilz <niv@iaglans.de> writes:
> You are trapped with the pu branch imho, like many others before *G* ... 
> simply do a 
>
> Pull: +refs/heads/pu:refs/heads/pu
>
> in your .git/remotes/origin file or remove that pu line...

Thank you!  That seems to get me going again.  But, isn't this going
to trip up other newbies?  I just tried a fresh git clone and the pu
branch comes in...

It would improve one's first impressions to not have to edit
.git/remotes/origin (although it is instructional) just to stay up to
date with git.

Cheers,

+ seth
