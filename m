From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: binary safe?
Date: Fri, 4 Nov 2005 12:00:54 +1300
Message-ID: <46a038f90511031500p3d6ed433s6efe3f5a5e60bcf8@mail.gmail.com>
References: <86br115r0z.fsf@blue.stonehenge.com>
	 <7v7jbpbb3l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 00:01:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXo4p-0001xv-0N
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 00:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVKCXAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 18:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVKCXAz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 18:00:55 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:28314 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030214AbVKCXAz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 18:00:55 -0500
Received: by zproxy.gmail.com with SMTP id 13so143949nzn
        for <git@vger.kernel.org>; Thu, 03 Nov 2005 15:00:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bf7j/hfo8HUsV7rjlogmSFsmnK1iAORBzHMSEzKKSOmBawTK3U8EoIX+2j151h9QZyeEoRMaii9TNfaedSCeWUS/nqhMnhfgnHejPjtmYVWaExihvei+frPf+TUN8viSxQ4zHJujb6GNT/VAA4YEdFJk3UJKgaXgjpI4Xujk9EY=
Received: by 10.65.215.5 with SMTP id s5mr1344052qbq;
        Thu, 03 Nov 2005 15:00:54 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Thu, 3 Nov 2005 15:00:54 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jbpbb3l.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11108>

On 11/4/05, Junio C Hamano <junkio@cox.net> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
> > I presume emailing diff-patches is out of the question, but if all I'm
> > doing is git-push and git-pull (using the shared central repository
> > model), and if I'm stupid enough to have a merge error it's OK to just
> > blow up on a binary file, will everything else work fine?
>
> It should.  I trust git well enough to track some png files in
> my day-job project.

Yes it works, and cvsimport -k will do the right thing for you.

We are tracking projects with several binary files. The only issue as
you note is that trading patches with git-format-patch and git-am
doesn't quite deal with it. But you can still do it across different
git heads with git-read-tree -m as long as your binary file merges are
truly trivial.

cheers,


martin
