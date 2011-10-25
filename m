From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] gitweb/Makefile: Remove static/gitweb.js in the clean
	target
Date: Tue, 25 Oct 2011 18:58:04 -0400
Message-ID: <1319583484.10399.41.camel@drew-northup.unet.maine.edu>
References: <4EA6EEA8.3000204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Oct 26 00:59:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIpxV-0008S3-NA
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 00:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab1JYW6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 18:58:20 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:39097 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab1JYW6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 18:58:20 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p9PMwC1T019401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Oct 2011 18:58:12 -0400
In-Reply-To: <4EA6EEA8.3000204@ramsay1.demon.co.uk>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p9PMwC1T019401
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1320188294.78792@86WpJ4wE1Y+ahTFqJxObKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184241>


On Tue, 2011-10-25 at 18:15 +0100, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  gitweb/Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 1c85b5f..4191c6b 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -185,7 +185,9 @@ install: all
>  ### Cleaning rules
>  
>  clean:
> -	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
> +	$(RM) gitweb.cgi static/gitweb.js \
> +		static/gitweb.min.js static/gitweb.min.css \
> +		GITWEB-BUILD-OPTIONS
>  
>  .PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
>  

Forgive me for sounding a bit numb, but what does this fix? I don't see
it in the commit message.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
