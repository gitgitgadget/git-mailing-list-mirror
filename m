From: "Doug Reiland" <dreiland@gmail.com>
Subject: Re: can you push from a bare repository??
Date: Fri, 27 Jun 2008 14:41:05 -0400
Message-ID: <6844644e0806271141q6b90901al2e9f40509f1c3539@mail.gmail.com>
References: <6844644e0806271058r738e300fxf10f50b4ad29a93c@mail.gmail.com>
	 <48652F01.4080309@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCItp-0006g9-QE
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYF0SlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYF0SlH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:41:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:5182 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbYF0SlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:41:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so686995rvb.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JvEewIjwT2YWJlH3KCI3SUaXz37KthL1UWZNHlOHtf4=;
        b=DNppQmYWm9cgnXhxWgRwdQNmke0UTVR4gnw+QjWcQktp2EQq1u+GRI8mkB7JJaPv8a
         UOE2LxNr7Cgt5hMUBWewlj52SS99+yU+Nl2jEbb349BKL1bqhe38ed0dX/U43nLw5GcW
         uIO7jMmh18dUifkqxUC2fI9fQU2vVeI05hx98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ThKL+m1GWyRVh8z5gSAPTvPSQKh4ZHSUdoLONX8iFiZgWBrqFuRc2SVl7DkG/om+a8
         Dopq+a8HERXMFfZ6eEx951RLHfoCAkwhfmwUHO+IUogm6CFxjduI1f6eeuKvw04P3uxQ
         0tCBBC1oGu/s0tQAZd4NLxp6vHYjuPlTLs8kU=
Received: by 10.140.164.1 with SMTP id m1mr1009704rve.69.1214592065289;
        Fri, 27 Jun 2008 11:41:05 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Fri, 27 Jun 2008 11:41:05 -0700 (PDT)
In-Reply-To: <48652F01.4080309@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86622>

Is that the only way? It wouldn't work for what I want to do.
I will have many users creating these environments and I wouldn't want
them all creating those remote branches on the main server.



On Fri, Jun 27, 2008 at 2:18 PM, Jon Loeliger <jdl@freescale.com> wrote:
> Doug Reiland wrote:
>>
>> I have a main repository called main
>> I create a bare clone from main call bare_clone
>> I create clone from bare_clone called work_repository_1
>>
>> I do my work in work_repository_1, commit, and push changes to bare_clone
>>
>> How to a push the changes in bare_clone into main??
>>
>
> Go to your main repo and configure up a new remote
> using "git remote add' pointing to the bare repo.
> Then fetch from that remote!
>
> jdl
>
