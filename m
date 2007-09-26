From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] User Manual: document import-tars.perl
Date: Wed, 26 Sep 2007 14:14:51 -0400
Message-ID: <20070926181451.GA20976@fieldses.org>
References: <20070925201306.GW30845@fieldses.org> <1190759824-18896-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 20:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IabPn-00021I-R8
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 20:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbXIZSPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbXIZSPH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 14:15:07 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52691 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbXIZSPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 14:15:06 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IabPP-0006PK-L9; Wed, 26 Sep 2007 14:14:51 -0400
Content-Disposition: inline
In-Reply-To: <1190759824-18896-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59237>

On Wed, Sep 26, 2007 at 12:37:04AM +0200, Miklos Vajna wrote:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> On Tue, Sep 25, 2007 at 04:13:06PM -0400, "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > One exception--the "series of tarballs" thing--I think it's cool that
> > you can just unpack a bunch of tarballs and string them together into a
> > git history.  It gives a good sense of how git works, and I don't think
> > it's documented explicitly anywhere.  I think that might be kinda fun to
> > write up.  But I haven't tried.
> 
> something like this?

Neat-o, I'd missed (or forgotten about) import-tars.perl.

But I'd prefer to keep this first explanation of how to initialize and
commit to a new project pretty streamlined, and I don't think this is
really necessary here.  So let's save this up until we have enough
material for a separate chapter or section on interacting with other
scm's.

--b.

> 
> VMiklos
> 
>  Documentation/user-manual.txt |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index a085ca1..f722932 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -978,6 +978,19 @@ $ git add . # include everything below ./ in the first commit:
>  $ git commit
>  -------------------------------------------------
>  
> +If you already have a series of tarballs (typically previous releases without
> +using a version control system):
> +
> +-------------------------------------------------
> +$ mkdir project
> +$ cd project
> +$ git init
> +$ perl import-tars.perl /path/to/tarballs/*.tar.bz2
> +$ git checkout import-tars
> +-------------------------------------------------
> +
> +You can find `import-tars.perl` in the `contrib/fast-import/` directory.
> +
>  [[how-to-make-a-commit]]
>  How to make a commit
>  --------------------
> -- 
> 1.5.3.2.80.g077d6f-dirty
> 
