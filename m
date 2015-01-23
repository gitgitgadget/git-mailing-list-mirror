From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: correct --prepare-p4-only instructions
Date: Fri, 23 Jan 2015 13:39:20 -0800
Message-ID: <20150123213920.GA3779@padd.com>
References: <1422004512-10049-1-git-send-email-luke@diamand.org>
 <1422004512-10049-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEm38-0004UF-Fh
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 22:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbbAWVpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 16:45:50 -0500
Received: from honk.padd.com ([71.19.245.7]:39686 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbbAWVpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 16:45:49 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2015 16:45:49 EST
Received: by honk.padd.com (Postfix, from userid 7770)
	id 6DEBB70C4; Fri, 23 Jan 2015 13:39:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422004512-10049-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262964>

luke@diamand.org wrote on Fri, 23 Jan 2015 09:15 +0000:
> If you use git-p4 with the "--prepare-p4-only" option, then
> it prints the p4 command line to use. However, the command
> line was incorrect: the changelist specification must be
> supplied on standard input, not as an argument to p4.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index ff132b2..90447de 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1442,7 +1442,7 @@ class P4Submit(Command, P4UserMap):
>              print "  " + self.clientPath
>              print
>              print "To submit, use \"p4 submit\" to write a new description,"
> -            print "or \"p4 submit -i %s\" to use the one prepared by" \
> +            print "or \"p4 submit -i <%s\" to use the one prepared by" \
>                    " \"git p4\"." % fileName
>              print "You can delete the file \"%s\" when finished." % fileName
>  

Looks obviously good here.  Ack!

		-- Pete
