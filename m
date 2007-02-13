From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add note about needing to do 'git checkout -f master'.
Date: Tue, 13 Feb 2007 18:58:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131857460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1171302581735-git-send-email->
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:58:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1uq-0004y8-7c
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbXBMR6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbXBMR6E
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:58:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:39628 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbXBMR6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:58:03 -0500
Received: (qmail invoked by alias); 13 Feb 2007 17:58:02 -0000
X-Provags-ID: V01U2FsdGVkX18sBp17kUksWgppX/Gwq1S6iZcaJBcCmfu1VSLRs9
	trNw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1171302581735-git-send-email->
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39557>

Hi,

On Mon, 12 Feb 2007, Richard W.M. Jones wrote:

> From: Richard Jones <rjones@redhat.com>
> 
> ---
>  Documentation/git-cvsimport.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index f5450de..7b43ed4 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -138,6 +138,12 @@ If '-v' is specified, the script reports what it is doing.
>  Otherwise, success is indicated the Unix way, i.e. by simply exiting with
>  a zero exit status.
>  
> +NOTES
> +-----
> +If importing for the first time into a directory (-C option),
> +after the import do 'git checkout -f master' in the new
> +directory.
> +
>  
>  Author
>  ------
> -- 
> 1.4.4.2

AFAICT this is no longer necessary in 1.5.0.

Ciao,
Dscho
