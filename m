From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Fix typo in filter-branch example
Date: Thu, 13 Aug 2009 18:36:19 +0200
Message-ID: <4A844103.6030508@drmicha.warpmail.net>
References: <4a843cdf.1608c00a.504c.0eed@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbdIB-0003Hq-Su
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbZHMQgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 12:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754274AbZHMQgf
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:36:35 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59667 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753677AbZHMQgf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 12:36:35 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0CF7D14174;
	Thu, 13 Aug 2009 12:36:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 13 Aug 2009 12:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=AYgF6C30u78GT9X04Wsp9gXhJJ8=; b=Vyc35zL1s3yXgw88p/SFiMYHfxqd3Z6nUGuWFf471dsqdQ2zrmdun3hCf6NZSkHZlwyOebhc4jjKfegaenZ5v97OWTLtf6ey2Wfca0ymsxTi1lVWmsh8f5eujnIQBGn7DELdBWd2hgvXv6VemkRFzDKswaIVm2sOc/04zyVAnkk=
X-Sasl-enc: 06Uu/zhMdu7+CpnQtcQ6HXF+Ea81Xxri2z7nn2ZM73CN 1250181393
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 73DF5362AB;
	Thu, 13 Aug 2009 12:36:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <4a843cdf.1608c00a.504c.0eed@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125831>

Ori Avtalion venit, vidit, dixit 13.08.2009 18:16:
> ---
>  Documentation/git-filter-branch.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index ab527b5..8cda87c 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -336,7 +336,7 @@ To move the whole tree into a subdirectory, or remove it from there:
>  
>  ---------------------------------------------------------------
>  git filter-branch --index-filter \
> -	'git ls-files -s | sed "s-\t-&newsubdir/-" |
> +	'git ls-files -s | sed "s-\t-\tnewsubdir/-" |
>  		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>  			git update-index --index-info &&
>  	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

If \t is matched then isn't & == \t?

Michael
