From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git log --parents'
Date: Sun, 8 Jul 2007 00:17:57 +0200
Message-ID: <e5bfff550707071517o776db380v9f3a68c3e46d9d3c@mail.gmail.com>
References: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
	 <7vps348qzi.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707070314q3b78ac65p9a8ff3130a7bfaef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 00:18:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7IbW-0005iy-Hn
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 00:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXGGWR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXGGWR6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 18:17:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:57764 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbXGGWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 18:17:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so805010wah
        for <git@vger.kernel.org>; Sat, 07 Jul 2007 15:17:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1673A7vaOE6j7qB7oBumcqb3FGilmzbOjTdy62zNZROiVnW0G3O0qK5/bFiSwzkSPJIWooJQOjS5mQwgv6st1ej2B62Tjkb1eBPy0i1ime6oHreBcggqFfPGOHq7Dl+0lX9UCfgJWOgkAXKTyTavR7CVlDRpnhC1jnodhWwdIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IaPfNnQOB7QCl76CYkihUvCXFqiRTF+q1yPThHtk7DqWF9A9sqClzdJXoFUfFis1NNsOOKpzdFieH/s+385d2JcrwLTNO4+NMtZdprWH8MkaHW4X8Q/XNAlAc1fClol59pJSEU28RbBaJgpXd1zG6qphjHvyLAPutnzA5EoID5o=
Received: by 10.114.193.1 with SMTP id q1mr1829204waf.1183846677608;
        Sat, 07 Jul 2007 15:17:57 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 7 Jul 2007 15:17:57 -0700 (PDT)
In-Reply-To: <e5bfff550707070314q3b78ac65p9a8ff3130a7bfaef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51847>

On 7/7/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/7/07, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> > git-log.  However, I have a slight suspicion that we earlier
> > decided not to do so on purpose with git-log and for a good
> > reason.  I do not have much energy left tonight to dig into this
> > right now, but mailing list log and commit log messages for
> > rev-list.c, builtin-log.c and builtin-rev-list.c might tell you
> > more.
> >
>
> I will take a look ...
>

The commit with the patch for git-rev-list is 884944239f2

I have found also the following commits, more or less related:
884944239f2          3381c790        2a0925be3

But I haven't found messages with downsides of using the same approach
also for git log.

So could you please apply the patch also for git-log if possible.

Thanks
Marco
