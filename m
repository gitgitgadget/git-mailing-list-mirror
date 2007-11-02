From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git-instaweb to be run from bare repositories
Date: Fri, 02 Nov 2007 12:11:27 -0700
Message-ID: <7vodec31k0.fsf@gitster.siamese.dyndns.org>
References: <20071102090922.GA10141@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 02 20:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1vn-0006fZ-04
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 20:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXKBTLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 15:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756599AbXKBTLc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 15:11:32 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:48003 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383AbXKBTLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 15:11:31 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5EE4C2FB;
	Fri,  2 Nov 2007 15:11:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B54AA9093F;
	Fri,  2 Nov 2007 15:11:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63156>

Jonas Fonseca <fonseca@diku.dk> writes:

> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  git-instaweb.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
>  On IRC yesterday, two were asking for this and it seems simply enough.
>  Apparently, git-instaweb is a great way to see if you've set up a
>  remote repository correctly.
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 95c3e5a..14917ac 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -6,6 +6,7 @@ USAGE='[--start] [--stop] [--restart]
>    [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
>    [--module-path=<path> (for Apache2 only)]'
>  
> +SUBDIRECTORY_OK=Yes
>  . git-sh-setup
>  
>  fqgitdir="$GIT_DIR"

I'd agree with the goal of the patch, and I would not doubt the
patch worked for you, but it somewhat feels wrong that you can
say "It is Ok to run this script from a subdirectory" and that
is the magic to allow something to work in a bare repository.

Care to share your insights on what is going on?
