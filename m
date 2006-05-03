From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Problem using GIT CVS-server
Date: Thu, 4 May 2006 09:12:39 +1200
Message-ID: <46a038f90605031412s363b4a79p548c75956b00adbf@mail.gmail.com>
References: <445865A5.5030700@lumumba.uhasselt.be>
	 <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
	 <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
	 <7v1wvaevno.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	"Panagiotis Issaris" <takis@lumumba.uhasselt.be>
X-From: git-owner@vger.kernel.org Wed May 03 23:12:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbOeK-0003z2-By
	for gcvg-git@gmane.org; Wed, 03 May 2006 23:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWECVMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWECVMl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 17:12:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:57878 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751210AbWECVMk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 17:12:40 -0400
Received: by wr-out-0506.google.com with SMTP id 68so219287wri
        for <git@vger.kernel.org>; Wed, 03 May 2006 14:12:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iUwHpjuOKM+XGCU8x90v92CfRgtOo/A1tXdm7OmYD1bi/mTXxA70fVZIXRWBiGMJRTYY1NNyiCNrrOdJfsxTTHDVsGuuW4DIQMr0kWfsfgRCB7Ulmgl8dZs7b2CjNxD8DVTU4/C+7k95jNURaf4UpVavnb1yULPR4EW8BLUwxps=
Received: by 10.54.98.6 with SMTP id v6mr193429wrb;
        Wed, 03 May 2006 14:12:39 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 14:12:39 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wvaevno.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19520>

On 5/4/06, Junio C Hamano <junkio@cox.net> wrote:
> Ah, the "master" git-log is C-rewrite version and does not show
> the parents on the "commit (.*)" line itself with --parents.

Exactly.

> Could you see if the attached patch helps?

Will try it in a moment. Having thought about it, git-log is always
going to be tweaked for human consumption, so I should use something
geared for porcelains instead. git-rev-list does honour --parent, so
perhaps I should switch to using that instead?

cheers,


martin
