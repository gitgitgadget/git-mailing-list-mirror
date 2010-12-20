From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 2/3] gitweb: decorate a bit more remotes
Date: Mon, 20 Dec 2010 07:04:42 -0500
Message-ID: <1292846682.19322.4.camel@drew-northup.unet.maine.edu>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
	 <1292535801-7421-3-git-send-email-sylvain@abstraction.fr>
	 <m3tyjglxi0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 13:05:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUeUD-0006KO-CR
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 13:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab0LTME7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 07:04:59 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:57767 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab0LTME6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 07:04:58 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oBKC4jnA000511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Dec 2010 07:04:45 -0500
In-Reply-To: <m3tyjglxi0.fsf@localhost.localdomain>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oBKC4jnA000511
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1293451493.58995@awynEvLcRckaXEHi2QM+BA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163994>


On Thu, 2010-12-16 at 14:23 -0800, Jakub Narebski wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
> 
> > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> > ---
> >  gitweb/gitweb.perl |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index db18d06..9398475 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -5127,13 +5127,13 @@ sub git_remote_block {
> >  
> >  	if (defined $fetch) {
> >  		if ($fetch eq $push) {
> > -			$urls_table .= format_repo_url("URL", $fetch);
> > +			$urls_table .= format_repo_url("<strong>URL:</strong>", $fetch);
> 
> I would really prefer to use CSS for that...

Agreed; <span class="repo_url">URL:</span> is far more appropriate in my
opinion.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
