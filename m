From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-annotate dies when a patch is missing trailing newline
Date: Thu, 2 Mar 2006 17:10:11 +1300
Message-ID: <46a038f90603012010u2efaee26lef6cd95412fb47cb@mail.gmail.com>
References: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
	 <7vslq1d1pr.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90603011907h6d0d4450w426afb9ada33ddb0@mail.gmail.com>
	 <7voe0pcy9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 05:10:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEf8s-0003FH-7j
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 05:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWCBEKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 23:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWCBEKO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 23:10:14 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:11836 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751006AbWCBEKM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 23:10:12 -0500
Received: by wproxy.gmail.com with SMTP id i20so314242wra
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 20:10:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eAenOt13aa16+s01fCl8L4nOBZsuREBhTgACnyV5IoSFz+uIhv05SxxwpHue9ulPgrp3VDsF+Kemzc2tXLgF8b44QsdcTgr1SyS447FUxaLqclc4emjhz6WRpRE5nk9OH6K3t4GaZ0Sl5IBpdexAD9IHTL91bFHh7YUZGAxdkpU=
Received: by 10.54.152.5 with SMTP id z5mr566995wrd;
        Wed, 01 Mar 2006 20:10:11 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 20:10:11 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7voe0pcy9c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17045>

On 3/2/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > Yes, excellent! BTW, I just realized that git-cvsserver is in master,
> > but the "git-annotate -S" patch isn't there, so cvs annotate dies. Is
> > anything holding the patch back in next?
>
> Is -S in next?

Yes, but broken since it switched to Getopt::Long (grumble...). Patch
should be hitting the list now, you can also pull it from my repo.

cheers,


martin
