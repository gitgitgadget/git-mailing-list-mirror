From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: [PATCH] Remove '< >' from [<options>] since it's not necessary.
Date: Sun, 20 Sep 2009 14:52:26 -0600
Message-ID: <auto-000020523806@sci.utah.edu>
References: <1253476116-24284-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpTLv-00073t-EQ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 22:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbZITUtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 16:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbZITUtY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 16:49:24 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:51636 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750964AbZITUtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 16:49:24 -0400
Received: from dummy.name; Sun, 20 Sep 2009 14:49:27 -0600
In-Reply-To: Your message of "Sun, 20 Sep 2009 15:48:36 EDT."
             <1253476116-24284-1-git-send-email-tfransosi@gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128860>

Thiago Farina <tfransosi@gmail.com> writes:
> -	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
> +	"git log [options] [<since>..<until>] [[--] <path>...]\n"
>  	"   or: git show [options] <object>...";

To me, "<blah>" implies to me that the other meant, "something which
is sort-of `blah'-ish but is not actually the string literal, `blah'",
whereas `blah' means, "the string literal, `blah'."

-tom
