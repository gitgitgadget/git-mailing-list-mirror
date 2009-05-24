From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/18] Some cleanup in get_refs_via_curl()
Date: Sun, 24 May 2009 13:43:42 -0700
Message-ID: <7vskiuteo1.fsf@alter.siamese.dyndns.org>
References: <20090524221949.4e61f987.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 23:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8L1o-0004lT-RH
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 23:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZEXVOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZEXVOV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 17:14:21 -0400
Received: from fed1rmmtai106.cox.net ([68.230.241.54]:56454 "EHLO
	fed1rmmtai106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZEXVOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 17:14:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204343.JTYD2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 May 2009 16:43:43 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id vYji1b00S4aMwMQ04YjjGt; Sun, 24 May 2009 16:43:43 -0400
X-Authority-Analysis: v=1.0 c=1 a=UhQCT-TaioIA:10 a=QKVcbD4QkdYA:10
 a=pGLkceISAAAA:8 a=z23upLkTAAAA:8 a=MEy3YVKYmNJB97FtYwcA:9
 a=F0KRPP9Tfhjo8ffesC4sggUp39UA:4 a=MSl-tDqOz04A:10 a=Ak6yjH5nytEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119861>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

The same comment as 06/18 on attribution apllies.

Be specific when you can without going to too verbose.  In this case,
instead of wasting two meaningless words "Some cleanup", you can say:

	Subject: transport.c::get_refs_via_curl(): do not leak refs_url

>  transport.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 89d846e..b7c1c39 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -519,6 +519,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
>  		free(ref);
>  	}
>
> +	free(refs_url);
>  	return refs;
>  }
>
> --
> 1.6.3.1
