From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [TIG PATCH] Add missing = for comparison in obsolete actions check.
Date: Tue, 9 Oct 2007 02:53:36 +0200
Message-ID: <20071009005336.GA30818@diku.dk>
References: <20071008173034.GA27292@crux.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 02:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If3OY-0002Wk-PS
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 02:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbXJIA4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXJIA4N
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 20:56:13 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:46770 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbXJIA4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 20:56:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 6F4E352C37A;
	Tue,  9 Oct 2007 02:56:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLUyjBJc5rZf; Tue,  9 Oct 2007 02:56:09 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7CE8852C37B;
	Tue,  9 Oct 2007 02:53:36 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F3B826DFC31; Tue,  9 Oct 2007 02:48:13 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5293A6336E; Tue,  9 Oct 2007 02:53:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071008173034.GA27292@crux.toronto.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60347>

James Bowes <jbowes@dangerouslyinc.com> wrote Mon, Oct 08, 2007:
> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
> ---
>  tig.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tig.c b/tig.c
> index 933d083..30c505b 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -1184,7 +1184,7 @@ option_bind_command(int argc, char *argv[])
>  	}
>  
>  	request = get_request(argv[2]);
> -	if (request = REQ_NONE) {
> +	if (request == REQ_NONE) {
>  		const char *obsolete[] = { "cherry-pick" };
>  		size_t namelen = strlen(argv[2]);
>  		int i;

Oops, thanks. I should readd -Wall to CFLAGS in my config.make file.

-- 
Jonas Fonseca
