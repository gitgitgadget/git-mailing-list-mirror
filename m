From: "Songmao Tian" <kingkongmao@gmail.com>
Subject: Re: Hello all, I am using git-svn and have some question
Date: Sun, 7 Jan 2007 16:12:13 +0800
Message-ID: <7d73e7d80701070012y5f15cde4gf2d9a36fab1815ae@mail.gmail.com>
References: <7d73e7d80701060124t16850e8ob8fbd202d230dd90@mail.gmail.com>
	 <20070107002317.GC10933@localdomain>
	 <7d73e7d80701062206y34db9d06k3c871c7e83a8aa4@mail.gmail.com>
	 <20070107063101.GA23429@mayonaise.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 09:12:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3T8h-0001Bi-Hx
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 09:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbXAGIMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 03:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbXAGIMP
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 03:12:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:48022 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbXAGIMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 03:12:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so9054254nfa
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 00:12:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jH8T5MvRwlam1RNKY9UbqPVhJhByPgQroDOWcQcNsBUucqEaJfycimglAcV9MYaEDLK3saHGMKkq4/1fVlWxulf9G/7wiAxywCuj3A6JkpGHuyeki9W6Chre+Cwfmm5agSMhZ+pMNGbKp+5gqKF8yQD6GTpWV0M7oxrwGKjyt+U=
Received: by 10.49.15.16 with SMTP id s16mr4965854nfi.1168157533724;
        Sun, 07 Jan 2007 00:12:13 -0800 (PST)
Received: by 10.48.212.10 with HTTP; Sun, 7 Jan 2007 00:12:13 -0800 (PST)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20070107063101.GA23429@mayonaise.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36135>

exactly~, thx again

On 1/7/07, Eric Wong <normalperson@yhbt.net> wrote:
> Songmao Tian <kingkongmao@gmail.com> wrote:
> > I have made a mistake, while use 1.4.4.1, exec git-svn multi-fetch
> > will find possible parent for each branch, but 1.4.4.3 will not.
> >
> > with parent found, git-rebase between branches will result in less
> > conflict. I wonder if I have made another mistake while using
> > 1.4.4.3:), for i like the way 1.4.4.1's multi-fetch did
>
> I don't see anything regarding multi-fetch changed between
> v1.4.4.1..v1.4.4.3.  Did you forget the --follow-parent flag?
> No worries though, you can use 'git-svn graft-branches' to
> connect a branch to its parent; and if that doesn't work automatically;
> you can edit the .git/info/grafts file with parent info (it's
> documented in Documentation/repository-layout.txt.
>
> --
> Eric Wong
>
