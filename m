From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: Re: [PATCH] cvsimport: add support for new style remote layout
Date: Wed, 30 May 2007 09:24:46 -0400
Message-ID: <3f80363f0705300624w48394ed7gf7679e32670eeaa3@mail.gmail.com>
References: <3a477a76f6c5396feee452678fb8110c@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Whitcroft" <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Wed May 30 15:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtOAo-0008Gk-Tm
	for gcvg-git@gmane.org; Wed, 30 May 2007 15:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbXE3NZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 09:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbXE3NZF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 09:25:05 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:28595 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbXE3NZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 09:25:01 -0400
Received: by an-out-0708.google.com with SMTP id d31so682640and
        for <git@vger.kernel.org>; Wed, 30 May 2007 06:24:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lmM3rL/h3szRSleC0WBofLtp3TbVKWeuA5+qB4/8j0gjLpoAG3X+nBT75zDgUUlgnIrVAR1NpmppvDnYmx3LQ3/JUeDexFk3yH4y1YffVD9CwwykhypzAfxGR1pCfgwP6PaoS8uwvpDivhniwehT1kUN9BKTiOHVfNrPpeM5xEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cnestTCuyWuuW9WiKXOSmqVrmNPas2tpuK8gbF2wDRI3eZv2HEqXiLuydKuuoE2dsJFjbWHFReuO/Df6y/MxBhz2mBye7HxyEmlrPSIHL/hzciubCi4xaDZj8ia4K+8Usg6Kx/5Lf5ln9MRh3WQz3vLh0Xo79qWBsIVaR8He4To=
Received: by 10.115.23.12 with SMTP id a12mr3923704waj.1180531486079;
        Wed, 30 May 2007 06:24:46 -0700 (PDT)
Received: by 10.114.194.4 with HTTP; Wed, 30 May 2007 06:24:46 -0700 (PDT)
In-Reply-To: <3a477a76f6c5396feee452678fb8110c@pinky>
Content-Disposition: inline
X-Google-Sender-Auth: 36678b5b1f4d7521
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48761>

On 5/29/07, Andy Whitcroft <apw@shadowen.org> wrote:
> Add a new option '-r <remote>' to set the remote name for
> this import.  When this option is specified branches are named
> refs/remotes/<remote>/branch, with HEAD named as master matching
> git-clone separate remotes layout.  Without branches are placed
> ion refs/heads, with HEAD named origin as before.

I love this. It's really nice to have 'git branch' not cluttered with
remote branches.

-James
