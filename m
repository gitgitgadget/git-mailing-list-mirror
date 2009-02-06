From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 14:03:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061403130.7377@intel-tinevez-2-302>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902061126.18418.jnareb@gmail.com> <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com> <200902061149.16210.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	=?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 14:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQOL-0007uH-Tu
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbZBFNDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbZBFNDm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:03:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:40483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751878AbZBFNDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:03:42 -0500
Received: (qmail invoked by alias); 06 Feb 2009 13:03:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp052) with SMTP; 06 Feb 2009 14:03:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wPHYyRlMwFGJUNHnHDMgZfFiztVxx6vCF2uDrpb
	0a56uxv41M7iCt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200902061149.16210.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108698>

Hi,

On Fri, 6 Feb 2009, Jakub Narebski wrote:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f27dbb6..5dcc108 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1364,7 +1364,7 @@ sub format_log_line_html {
>  	my $line = shift;
>  
>  	$line = esc_html($line, -nbsp=>1);
> -	if ($line =~ m/([0-9a-fA-F]{8,40})/) {
> +	if ($line =~ m/\b([0-9a-fA-F]{8,40})\b(!?\@)/) {

Looks good to me!

Thanks,
Dscho
