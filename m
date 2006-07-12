From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb.css: Courer fonts for commits and tree-diff
Date: Wed, 12 Jul 2006 10:46:10 -0700 (PDT)
Message-ID: <20060712174610.71046.qmail@web31810.mail.mud.yahoo.com>
References: <7vac7f1htw.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 19:49:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0in3-0005J4-Jp
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 19:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGLRqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWGLRqM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 13:46:12 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:7549 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932213AbWGLRqL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 13:46:11 -0400
Received: (qmail 71048 invoked by uid 60001); 12 Jul 2006 17:46:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zdB3kEah7hH/uolzTuarZuvkFfFh0p+V7+nXL2ol2cX/TkI+olvZb/OQOOt7yuDr4v8nj2MLmQZ8aIk7hriHPHoC3rhCAizxKWqHO4X+Sw9P6ssd3zQhlR8KoEXeN2BzsSNjGgTdM98hk7xnXk++NZarpnxISZ5OGtHwUYjKLxs=  ;
Received: from [68.186.50.195] by web31810.mail.mud.yahoo.com via HTTP; Wed, 12 Jul 2006 10:46:10 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac7f1htw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23792>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Courer fonts for the commit header, commit message,
> > and tree-diff.
> >
> > Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> 
> I really do not want to be in the position to judge a patch like
> this, whose evaluation is solely based on "prettiness" factor.
> 
> But if I really have to, I would say this makes things uglier
> and less readable.  Maybe asking for monospace is less yucky but
> naming Courier explicitly?

Sometimes people would put ASCII art in their commit messages,
things like a simple table, compiler output, log output, etc,
and I wanted to _preserve_ the intent of such output.  This is why
I changed it to Courier. (sorry for the misspelling of Courier)

> BTW what tool do you use to generate and send your patches?  I
> remember another patch from you recently did not apply and it
> turned out the problem was that the last hunk had line numbers
> wrong.  This patch has exactly the same problem and I am
> wondering why.

I use git.  Those patches are against a one-off branch, which I created
for the purpose of sending you the patches.

The original patches are against my "git-lt" branch, which has
the File::MMagic changes in it -- it is my working branch.
So I generated a patch off of "git-lt", applied it to "one-off-gitweb",
which is identical to the git "master" branch, and sent the patches.

      Luben


> 
> I count 10 lines of original and 15 lines of new material in
> this hunk but the hunk header claims to have 11 lines of
> original text.
> 
> ---
>  gitweb/gitweb.css |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 98410f5..b51282b 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
>  ... 
> @@ -142,11 +144,15 @@ table {
>  	padding: 8px 4px;
>  }
>  
> -table.project_list, table.diff_tree {
> +table.project_list {
>  	border-spacing: 0;
>  }
>  
> +table.diff_tree {
> +	border-spacing: 0;
> +	font-family: courier;
> +}
> +
>  table.blame {
>  	border-collapse: collapse;
>  }
> -- 
> 1.4.1.g9ca3
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
