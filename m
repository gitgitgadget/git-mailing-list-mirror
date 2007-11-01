From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Remove CGI::Carp::set_programname() call from t9500 gitweb test
Date: Thu, 01 Nov 2007 15:18:15 -0700
Message-ID: <7vve8l8va0.fsf@gitster.siamese.dyndns.org>
References: <1193923396-17341-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IniNC-0006Xo-W1
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbXKAWSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbXKAWSV
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:18:21 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59012 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXKAWSU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:18:20 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 40AF82F0;
	Thu,  1 Nov 2007 18:18:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C4C3C912C7;
	Thu,  1 Nov 2007 18:18:38 -0400 (EDT)
In-Reply-To: <1193923396-17341-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 1 Nov 2007 14:23:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63022>

Jakub Narebski <jnareb@gmail.com> writes:

> It does appear to do nothing; gitweb is run as standalone program
> and not as CGI script in this test.  This call caused problems later.

Care to describe "later problems" a bit more?

>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  t/t9500-gitweb-standalone-no-errors.sh |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index f7bad5b..1bf0988 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -31,7 +31,6 @@ our \$projects_list = "";
>  our \$export_ok = "";
>  our \$strict_export = "";
>  
> -CGI::Carp::set_programname("gitweb/gitweb.cgi");
>  EOF
>  
>  	cat >.git/description <<EOF
> -- 
> 1.5.3.5
