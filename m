From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-repack: clear out tmp packfiles from $PACKDIR instead of cwd
Date: Tue, 5 Sep 2006 00:16:07 +1200
Message-ID: <46a038f90609040516y42d0250an85eea3c66bee31b6@mail.gmail.com>
References: <11573485362686-git-send-email-martin@catalyst.net.nz>
	 <46a038f90609032248h5eda61dft4150e13e49f8e59e@mail.gmail.com>
	 <edgndv$mtv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 14:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKDNF-00015y-3e
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 14:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWIDMQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 08:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWIDMQO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 08:16:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:40468 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964818AbWIDMQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 08:16:09 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1023582nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 05:16:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RKRrSrRsBaOQGgpfzu9vPTB/7DPM/xjstfHko11JYEuQN2SibL1pwzKDTIrG6iWO7Mxn78Ih/F2bU7bUDpkSaEgxzkVQ4C2rk0Tvtvh3l6Ps1s3/lZQxDyoCHPLqde66qS42fmRuhkk56bCkifTe29C5KAaojynaCcdB3Q3aTlE=
Received: by 10.49.94.20 with SMTP id w20mr6542991nfl;
        Mon, 04 Sep 2006 05:16:08 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Mon, 4 Sep 2006 05:16:07 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <edgndv$mtv$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26417>

On 9/4/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Martin Langhoff wrote:
>
> > On 9/4/06, Martin Langhoff <martin@catalyst.net.nz> wrote:
> >> Temp packfiles should never be created in cwd anyway ;-)
> >
> > Note! Applies after "git-repack: create new packs inside $PACKDIR, not cwd"
> >
> >> VGER BF report: U 0.983488
> >
> > Hilarious!
>
> Isn't 'U' for Undecided? (and 'H' for Ham)?

Maybe -- but the score is really high. This patch was part of a series
of 2 actually. The other one had a score of 1.6 and got bounced. :-/



martin

-- 
VGER BF report: U 0.558927
