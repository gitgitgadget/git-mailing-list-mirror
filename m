From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git
 am documentation
Date: Wed, 03 Jun 2015 07:50:36 +0200
Message-ID: <556E95AC.7040305@web.de>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 07:51:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z01Zp-0001qn-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 07:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbFCFux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 01:50:53 -0400
Received: from mout.web.de ([212.227.17.11]:63390 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbbFCFuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 01:50:51 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Ljaiq-1ZWtQ70Aky-00bYnb; Wed, 03 Jun 2015 07:50:47
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
X-Provags-ID: V03:K0:5AZN4c6sEuYe44P1OUPnSd8TuZ2AP14HmNmPq1/GOu35MUH2Fmx
 b95xdXwcK4aQLkQOtHml/GZsU4HD0v60CcgBh4g77dG6i0iXO850JFclNhBxau0p/MzDssa
 pAIsQmPBb8jw3PlyehV0VfoIAYTyzNqjGk+uilRQ5lNMD6dCgC3vNsbLqj62oxCdVxCuKEZ
 JDS7S5HCkxvbRy2QrHwHg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270628>

On 06/02/2015 07:34 PM, Remi Lespinet wrote:
> []
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>   Documentation/git-am.txt | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0d8ba48..d412f6b 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -24,6 +24,16 @@ Splits mail messages in a mailbox into commit log message,
>   authorship information and patches, and applies them to the
>   current branch.
>   
> +CONFIGURATION
> +-------------
> +
> +am.keepcr::
> +	If true, git-am will call git-mailsplit for patches in mbox format
> +	with parameter '--keep-cr'. In this case git-mailsplit will
> +	not remove `\r` from lines ending with `\r\n`. Can be overridden
> +	by giving '--no-keep-cr' from the command line.
(This documentation assumes that am.keepcr is true)
Would it be clearer to put the "overridden" into one line and write like 
this:

Can be overridden by giving '--no-keep-cr' or '--keep-cr' from the command line.
