From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict resolution - take 2
Date: Sat, 5 Aug 2006 15:26:34 +1200
Message-ID: <46a038f90608042026l732cef04u46df9b3429cd04d4@mail.gmail.com>
References: <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
	 <11546518271379-git-send-email-martin@catalyst.net.nz>
	 <81b0412b0608040109q683bd628rd9238662e0fdfb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 05:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9CoE-0007Qg-DM
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 05:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWHED0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 23:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbWHED0h
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 23:26:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:24550 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422751AbWHED0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 23:26:36 -0400
Received: by nf-out-0910.google.com with SMTP id k26so97108nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 20:26:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BlsAMWYzP+Mnyk7eRdri3PfRIwt4ojbTGHuxgpOqEHGSWiMRvGK8YcKvi3ujpna8+RxEytxCTi/EWeJbSd0/9sOU0zkTJ1+9MHJ1Ur8fjkUO6guqtvxm+7WLM/NIJDV1sKqCSHxDxS6/16Eq/mWgrt2TXSOboHObRI/+JmKt0v8=
Received: by 10.78.180.18 with SMTP id c18mr1804241huf;
        Fri, 04 Aug 2006 20:26:34 -0700 (PDT)
Received: by 10.78.97.17 with HTTP; Fri, 4 Aug 2006 20:26:34 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608040109q683bd628rd9238662e0fdfb0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24879>

On 8/4/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 8/4/06, Martin Langhoff <martin@catalyst.net.nz> wrote:
> > This is a bit of a crude but really useful shortcut for conflict resolution.
> > The name is bad, but git-merge-* is a different 'namespace', and git-resolve is
> > also taken.
>
> git-xxmerge?

Well, the xx part is taken because it uses xxdiff, so I thought
perhaps we can have trivial git wrappers for many popular mergers. Ie:
git-wiggle, git-sdiff.

We could have a single command with a 'strategy' parameter, say

     git-mergehelper -s [xxdiff|sdiff|wiggle] path/to/file

but separate commands are easier for prototyping IMVHO.

cheers,


martin
