From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: [PATCH 14/19] Document pull-all and push-all
Date: Tue, 12 Mar 2013 16:12:30 +0100
Message-ID: <513F45DE.6010304@ira.uka.de>
References: <CALeLG_kdXMb8wAyAL7T9jXk3sT85uJeiNh+v3jz9tKcf25VA9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, David Michael Barr <b@rr-dav.id.au>,
	Kindjal <kindjal@gmail.com>, bibendi <bibendi@bk.ru>,
	Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 16:31:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRAu-0006tu-EP
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 16:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab3CLPbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 11:31:09 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42980 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755211Ab3CLPbI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Mar 2013 11:31:08 -0400
X-Greylist: delayed 1157 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2013 11:31:07 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UFQrd-0004x0-UT; Tue, 12 Mar 2013 16:11:46 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UFQrd-0001pB-Kh; Tue, 12 Mar 2013 16:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <CALeLG_kdXMb8wAyAL7T9jXk3sT85uJeiNh+v3jz9tKcf25VA9A@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1363101107.052086000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1363102266.836206000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217966>

Am 09.03.2013 20:28, schrieb Paul Campbell:
>  From 7dcd40ab8687a588b7b0c6ff914a7cfb601b6774 Mon Sep 17 00:00:00 2001
> From: Herman van Rink <rink@initfour.nl>
> Date: Tue, 27 Mar 2012 13:59:16 +0200
> Subject: [PATCH 14/19] Document pull-all and push-all
>
> ---
>   contrib/subtree/git-subtree.txt | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index e0957ee..c8fc103 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -92,13 +92,19 @@ pull::
>   	Exactly like 'merge', but parallels 'git pull' in that
>   	it fetches the given commit from the specified remote
>   	repository.
> -	
> +
> +pull-all::
> +	Perform a pull operation on all in .gittrees registered subtrees.
> +
>   push::
>   	Does a 'split' (see below) using the <prefix> supplied
>   	and then does a 'git push' to push the result to the
>   	repository and refspec. This can be used to push your
>   	subtree to different branches of the remote repository.
>
> +push-all::
> +	Perform a pull operation on all in .gittrees registered subtrees.
                  -----
pull->push


> +
>   split::
>   	Extract a new, synthetic project history from the
>   	history of the <prefix> subtree.  The new history
>
