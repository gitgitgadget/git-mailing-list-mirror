From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Re: gitview 0.3
Date: Thu, 2 Feb 2006 12:45:39 +0530
Message-ID: <cc723f590602012315p2ba6e3f5rcf34df4bdefa5cb7@mail.gmail.com>
References: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
	 <7vzmlauw35.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 08:15:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Ygy-0000gA-2R
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 08:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWBBHPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 02:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBBHPl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 02:15:41 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:49575 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbWBBHPk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 02:15:40 -0500
Received: by uproxy.gmail.com with SMTP id s2so93658uge
        for <git@vger.kernel.org>; Wed, 01 Feb 2006 23:15:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SVG7xqRy+MKxCNXoFBVlzj/aIYdCIN55CJ8TuTGtbjv0NJpkYAh+I1PlCbsjc6JOHe/jK7Cl9Fl6syyzr0TnjelpiFjFjdn7BdUanC7ayLQphBnt7tOLl0ooZiadTzajn0nAHbz2HJKZlLAUzLkcvIjMhkbrmR81yrhB5fYgC6U=
Received: by 10.66.244.10 with SMTP id r10mr147537ugh;
        Wed, 01 Feb 2006 23:15:39 -0800 (PST)
Received: by 10.66.254.16 with HTTP; Wed, 1 Feb 2006 23:15:39 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmlauw35.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15488>

On 2/2/06, Junio C Hamano <junkio@cox.net> wrote:
> Nhe choice of colors is intuitive).
>
> It might match more people's expectation if --with-diff were the
> default.
>

Done. I made it to take option --without-diff for guys like me


> This patch might make merges easier to read.
>
> -- >8 --
> [PATCH] Use "diff-tree -c" to display merges a bit more readably.
>
> --- a/gitview   2006-02-01 21:16:43.000000000 -0800
> +++ b/gitview   2006-02-01 21:46:24.000000000 -0800
> @@ -305,7 +305,7 @@
>                 return message
>
>         def diff_tree(self):
> -               fp = os.popen("git diff-tree --pretty -m -v -p " + " " + self.commit_sha1)
> +               fp = os.popen("git diff-tree --pretty -c -v -p " + " " + self.commit_sha1)
>                 diff = fp.read()
>                 fp.close()
>
>
>
>


I applied this patch . But the problem now is merge commits doesn't
show the commit messages. Adding -m also didn't help. Any suggestion

-aneesh
