From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/8] user-manual: remove some git-foo usage
Date: Mon, 23 Mar 2009 02:31:41 -0400
Message-ID: <20090323063141.GA1119@coredump.intra.peff.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 07:33:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LldjQ-0003x2-2g
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 07:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZCWGbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbZCWGbr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 02:31:47 -0400
Received: from peff.net ([208.65.91.99]:39975 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbZCWGbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 02:31:46 -0400
Received: (qmail 19043 invoked by uid 107); 23 Mar 2009 06:31:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 02:31:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 02:31:41 -0400
Content-Disposition: inline
In-Reply-To: <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114245>

On Sun, Mar 22, 2009 at 08:05:14PM +0200, Felipe Contreras wrote:

>  Every commit has a 40-hexdigit id, sometimes called the "object name" or the
> -"SHA1 id", shown on the first line of the "git-show" output.  You can usually
> +"SHA1 id", shown on the first line of the "git show" output.  You can usually

I think some of these were intentionally left in the original mass
dashes to spaces conversion. The intent was that one could use the
git-show form in talking about the command in text.

However, I think I actually prefer the version given by your patch. I
just wanted to point out that this is a decision to change how we
mention these in the documentation and not simply a fix for things that
got missed in the conversion. Others may disagree on how it looks.

It seems like you added monospace backticks in most locations. Is there
a reason not to standardize on that and use `git show` here?

>  [[Updating-a-repository-With-git-fetch]]
> -Updating a repository with git-fetch
> +Updating a repository with git fetch
>  ------------------------------------

I think this one should probably be `git fetch`.

-Peff
