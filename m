From: "David Ho" <davidkwho@gmail.com>
Subject: Re: Pulling tags from git.git
Date: Mon, 6 Mar 2006 13:54:25 -0500
Message-ID: <4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Mar 07 00:00:09 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1FGLAE-0004Iq-01
	for <gcvg-git@gmane.org>; Mon, 06 Mar 2006 20:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWCFSy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 13:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWCFSy0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 13:54:26 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:15156 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751566AbWCFSyZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 13:54:25 -0500
Received: by zproxy.gmail.com with SMTP id i11so1315257nzi
        for <git@vger.kernel.org>; Mon, 06 Mar 2006 10:54:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vpfpxubh/SyrH0VYj/mB1UNdQB5DXNBshnHZeYETUWNxV4CkGHAEk3dAoW3uSxnr8CCM6rjT9f8etBQISlXVp9qGW5aHk3CRQ+rmGJ0JRum3KWHDHV+bvLjYX4S03zyRwQSy8LLY/QJpyoKCHOb5h11In0ASpgnjg++caz4AYco=
Received: by 10.65.220.2 with SMTP id x2mr2721885qbq;
        Mon, 06 Mar 2006 10:54:25 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Mon, 6 Mar 2006 10:54:24 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17310>

Okay sorry, git fetch --tags did the trick.

Just out of curiosity, should git pull --tags behave similarly since
the difference is git pull does a merge after a fetch?

David

On 3/6/06, David Ho <davidkwho@gmail.com> wrote:
> Hi,
>
> I have been trying to pull from the git repo via rsync.
> (rsync://rsync.kernel.org/pub/scm/git/git.git)  I got all the commits
> up to today but the tags since my initial cloning are missing.
>
> I tried git pull --tags, I still only have old tags.
> I switched to using the git protocol but that failed too.
>
> git ls-remotes --tags showed, as expected, all the tags up to 1.2.4.
>
> Is there a switch I missed?
>
> Regards,
> David
>
