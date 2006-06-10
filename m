From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.4.0
Date: Sun, 11 Jun 2006 00:47:30 +0200
Message-ID: <4d8e3fd30606101547x46b94058u3bb48ba8d25dc48d@mail.gmail.com>
References: <7vmzckhfsx.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30606101537n2d099ee4g5e86956bdfc5cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 00:47:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpCEx-0004SB-P5
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 00:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWFJWrc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWFJWrc
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 18:47:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:53312 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161044AbWFJWrb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 18:47:31 -0400
Received: by wr-out-0506.google.com with SMTP id i11so1205618wra
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 15:47:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4pDFR6UB290Ene2UwV68qhyI5r0teXSDUE39Lkop3Fmv4rEDY0n2SyfouZuc+UnC62ccoxuQnYWEFDjsy4EG5BgKz/azvvrkdDeoFCYr+ylRK4U6pRMvzxt2L/iFhwk7l8JSmnGVnRoXSq9OH1rNNRsr4Ek4RnJQcdD4yTN+og=
Received: by 10.65.155.18 with SMTP id h18mr3847478qbo;
        Sat, 10 Jun 2006 15:47:31 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Sat, 10 Jun 2006 15:47:30 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <4d8e3fd30606101537n2d099ee4g5e86956bdfc5cb5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21626>

On 6/11/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 6/10/06, Junio C Hamano <junkio@cox.net> wrote:
> > The latest feature release GIT 1.4.0 is available at the
> > usual places:
> >
> >         http://www.kernel.org/pub/software/scm/git/
>
> Cannot pull:
>
> paolo@Italia:~/git$ git pull
> error: no such remote ref refs/heads/jc/bind
> Fetch failure: git://www.kernel.org/pub/scm/git/git.git

Ok, solved doing (as suggested on #git)
/.git/remotes$ vi origin
and removed:
Pull: jc/bind:jc/bind

What happened to that branch?

Thanks.

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
