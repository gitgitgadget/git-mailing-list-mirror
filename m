From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] [RFC] Introduce Git.pm
Date: Thu, 22 Jun 2006 09:18:12 +0200
Message-ID: <81b0412b0606220018h5a67b45dk1aa320e24fc172bc@mail.gmail.com>
References: <20060622003546.17760.23089.stgit@machine.or.cz>
	 <7v64iuxard.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 09:18:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJSC-0006Nz-Rd
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWFVHSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWFVHSO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:18:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:19271 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751764AbWFVHSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 03:18:13 -0400
Received: by ug-out-1314.google.com with SMTP id a2so325133ugf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 00:18:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VeWk5NNJo3VRqV0cDb4aEOnHvxFRtmxm6f1FrM+pfx+kvnqsDOndu7vOGyYfOeihaSLAHtKwfsJs/5XNfpVF4A/wf1g3OKKGN6sLbQN7+SKUNA3vsaCYIFJfDRBrzPobUS9GUvKYWDyM/LAwE+r0BHccnjKdv92AaZaBUkSufsM=
Received: by 10.78.160.2 with SMTP id i2mr242088hue;
        Thu, 22 Jun 2006 00:18:12 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 22 Jun 2006 00:18:12 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64iuxard.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22304>

On 6/22/06, Junio C Hamano <junkio@cox.net> wrote:
> Offtopic; do people mind if we drop $GIT_VERSION from
> TRACK_CFLAGS?  Every time I switch branches or make a new commit
> it ends up rebuilding everything needlessly.

Me too. That's one of the you're too lazy to report, because you
think: "it is not yet annoying enough".
