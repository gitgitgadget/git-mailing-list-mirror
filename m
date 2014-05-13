From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 29/29] Added a short style guide, and Emacs settings.
Date: Tue, 13 May 2014 17:00:16 -0400
Message-ID: <20140513210016.GC4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-30-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:00:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJo8-0002kj-27
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaEMVAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:00:12 -0400
Received: from josefsipek.net ([64.9.206.49]:1556 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbaEMVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:00:10 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id AB6DE55654;
	Tue, 13 May 2014 17:00:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-30-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248850>

On Tue, May 13, 2014 at 10:31:05PM +0200, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  .dir-locals.el             |  3 +++
>  Documentation/Contributing | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 .dir-locals.el
> 
> diff --git a/.dir-locals.el b/.dir-locals.el
> new file mode 100644
> index 0000000..50ef2b7
> --- /dev/null
> +++ b/.dir-locals.el
> @@ -0,0 +1,3 @@
> +((nil . ((indent-tabs-mode . t)
> +	 (tab-width . 8)))
> + (sh-mode . ((sh-basic-offset . 8))))

I'll have to trust you on this one.  All I see is a bunch of cons cells :)

> diff --git a/Documentation/Contributing b/Documentation/Contributing
> index abf3480..0da49d6 100644
> --- a/Documentation/Contributing
> +++ b/Documentation/Contributing
> @@ -4,6 +4,21 @@ Documentation/SubmittingPatches file. :)
>  
>  1) Hack on the code a bit
>  
> +Please follow this style guide:
> +
> + - Use tabs for indentation.
> +
> + - Put "then" on the same line as "if".
> +
> + - Follow the style of the existing code, except if it breaks the
> +   above guidlines.
> +
> + - If you change the code to conform to the style guide, please do so
> +   in a separate commit that does not change anything else.
> +
> +Please check that you change does not break "make test".  Please add
> +new testcases for any new functionality, and if you fix a bug.
> +

Adding this blurb here is a good idea.  Thanks!

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

>  2) Make a patch:
>  
>  Use "diff -up" or "diff -uprN" to create patches. Or simply use git to
> -- 
> 1.8.3.1
> 

-- 
Evolution, n.:
  A hypothetical process whereby infinitely improbable events occur with
  alarming frequency, order arises from chaos, and no one is given credit.
