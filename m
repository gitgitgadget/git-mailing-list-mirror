From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] docs: explain behaviour of remote add without tag
 option
Date: Wed, 04 Mar 2015 16:46:47 +0100
Message-ID: <54F728E7.5080600@drmicha.warpmail.net>
References: <1425424320-4091-1-git-send-email-me@ikke.info> <1425424320-4091-2-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 04 16:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTBVe-0002dv-RZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 16:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbbCDPqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 10:46:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32980 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759129AbbCDPqt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 10:46:49 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 63B9B206C8
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 10:46:47 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 04 Mar 2015 10:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qg0nrCC0bfxYMVRVXltK1H
	zoZtU=; b=tqZM0Z7VTNUx67zZ+lJT+XbVzYbLdowKo6FJFe6iqpCwuYBmR6e9Ue
	M+UmbVcTMEiM5B6YUkC3gHzt4OcLSKJVgZkgmIGrggTlVEdLgly+0I+iDKl70woa
	8Dpt8QV0EWDP+kHacVQW7k88JP/oLCwrMEmbT0Ktp6O2ZNfxLJKDY=
X-Sasl-enc: iLHapYMaGd7MaT2M/dZmpMhNxExZs22iaxFC47UzJdIJ 1425484008
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EBE926800E9;
	Wed,  4 Mar 2015 10:46:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425424320-4091-2-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264764>

Kevin Daudt venit, vidit, dixit 04.03.2015 00:12:
> Only behaviour with these options are currently explained. Add
> explanation what the default behaviour is.
> 
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
>  Documentation/git-remote.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index a77607b..5bde0e1 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -58,6 +58,9 @@ remote repository.
>  With `--no-tags` option, `git fetch <name>` does not import tags from
>  the remote repository.
>  +
> +With neither `--tags` or `--no-tags` set, imports only tags that are
> +reachable from downloaded history.
> ++
>  With `-t <branch>` option, instead of the default glob
>  refspec for the remote to track all branches under
>  the `refs/remotes/<name>/` namespace, a refspec to track only `<branch>`
> 

So, how does this relate to:

http://permalink.gmane.org/gmane.comp.version-control.git/264592

I don't mind you taking this over at all, it's just that we should keep
things together where the discussion begun.

Michael
