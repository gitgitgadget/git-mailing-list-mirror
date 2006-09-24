From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Sun, 24 Sep 2006 18:22:35 +0100
Message-ID: <46a038f90609241022i6ac11da1o1a1cba199595d036@mail.gmail.com>
References: <11546624471356-git-send-email-martin@catalyst.net.nz>
	 <20060924165037.GS20017@pasky.or.cz>
	 <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com>
	 <20060924171246.GY13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:23:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXh1-0004kU-9o
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWIXRWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIXRWi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:22:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:45621 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751221AbWIXRWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 13:22:37 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1350836nfa
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 10:22:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qc1d1tseei4xxUe5yYVuF/mwXhwjRq6cMrvr7HW1qx4JvWyin3KsZDomn18IutVzVwEKS7+czgqdzs2O16CfrDr6f+Ca4fm7iFJxv4L2qe+GO+42bDTI7+NyuEWF37UYAIKPVqrCnKCiK6V0ncdClAhU3wTK/G+/KMFsR8NovLc=
Received: by 10.49.80.12 with SMTP id h12mr503217nfl;
        Sun, 24 Sep 2006 10:22:36 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Sun, 24 Sep 2006 10:22:35 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060924171246.GY13132@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27679>

On 9/24/06, Petr Baudis <pasky@suse.cz> wrote:
> In that case I think the most natural way for this tool to interface
> would be in part of some kind of cg-resolve swiss-army knife for
> resolving conflicts:
>
>        cg-resolve --mine       for taking just the version from _my_
>                                side of the merge
>        cg-resolve --other      dtto for the other side of the merge
>        cg-resolve -g           graphically resolve
>                                (vimdiff/xxdiff/meld/...)
>        surely more would be invented over time

Sounds reasonable. But I think we have to keep in mind that you only
know if the conflict is nasty after you have a go at fixing it. And I
sometimes find that I try with cg-xxdiff... and I go back to the plain
old conflict. That is why it doesn't clobber the file -- to protect a
manual merge in process.

> Well, all the Cogito scripts should have some consistent form. :-)

heh - consistency? overrated! ;-)

> But I can adjust such details when applying your patch.

Great! -- I'm travelling and at an airport "free access" computer. It
should be illegal to run airports without free wifi in this day and
age.

cheers,


martin
