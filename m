From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Document push --no-verify
Date: Thu, 23 May 2013 17:37:11 +0300
Message-ID: <20130523143711.GA24037@redhat.com>
References: <87vc6arcf4.fsf@linux-k42r.v.cablecom.net>
 <ba24ea6f9fedc05690ee93a805d4f468650a942c.1369315855.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 23 16:38:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfWei-0000cZ-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 16:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759228Ab3EWOiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 10:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11158 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758967Ab3EWOiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 10:38:07 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NEaotM023467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 23 May 2013 10:36:50 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4NEakuj019467;
	Thu, 23 May 2013 10:36:48 -0400
Content-Disposition: inline
In-Reply-To: <ba24ea6f9fedc05690ee93a805d4f468650a942c.1369315855.git.trast@inf.ethz.ch>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225250>

On Thu, May 23, 2013 at 03:34:11PM +0200, Thomas Rast wrote:
> ec55559 (push: Add support for pre-push hooks, 2013-01-13) forgot to
> add a note to git-push(1) about the new --no-verify option.
> 
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>


Thanks. FWIW

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> Junio replied privately that it should also mention the --verify
> possibility.
> 
> So why not.  But this needs to be fixed across the board eventually;
> 0f1930c (parse-options: allow positivation of options starting, with
> no-, 2012-02-25) did not update any docs, so none of the other --no-
> options mention their positive forms.
> 
> 
>  Documentation/git-push.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index d514813..df5be26 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>  	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
> -	   [<repository> [<refspec>...]]
> +	   [--no-verify] [<repository> [<refspec>...]]
>  
>  DESCRIPTION
>  -----------
> @@ -195,6 +195,11 @@ useful if you write an alias or script around 'git push'.
>  	be pushed. If on-demand was not able to push all necessary
>  	revisions it will also be aborted and exit with non-zero status.
>  
> +--[no-]verify::
> +	Toggle the pre-push hook (see linkgit:githooks[5]).  The
> +	default is \--verify, giving the hook a chance to prevent the
> +	push.  With \--no-verify, the hook is bypassed completely.
> +
>  
>  include::urls-remotes.txt[]
>  
> -- 
> 1.8.3.rc3.486.gfe16094
