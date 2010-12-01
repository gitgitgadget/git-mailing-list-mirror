From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-commit.txt: (synopsis): move -i and -o before "--"
Date: Wed, 1 Dec 2010 10:39:30 -0600
Message-ID: <20101201163930.GE26120@burratino>
References: <7vlj4b280b.fsf@alter.siamese.dyndns.org>
 <74d884bbd76bf090472b123f8053f095cda523f9.1291215072.git.jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Wed Dec 01 17:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpia-0006rn-AZ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab0LAQji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:39:38 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48324 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab0LAQji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:39:38 -0500
Received: by vws16 with SMTP id 16so420573vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HZkqtmvMoUgEpHHYp0wvT6PUYPy7nrZiometPTZqxAQ=;
        b=YWaQyjO1EHaR5C554SXde7syoQT4OWanKXCewBm5EIagPzWcJmV9eD4nuK21VhzYY1
         6cG5Q5fUQcUMWnFHGIWCIM138GyBfBagCogEFiuadNquPPy03J2XD7+LjXBm2VH1Qd+y
         EfVtYurkandEc2+pPtIT8Xy3Ts8FygA49Ckfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nWG6HxZKlPwmhL9V3lSgJPRN5SFhFwAuWsHdlWmae2pABkyZpccji7LyXDiQ4gIBLi
         GFg7pV8OFtLxUXVHEDCxHY2/bXf0Sp0In4NVCmTRxdmHN70SeU+s4LiMYvAX94LSIuer
         Ac6urF5SDTrmKDrG8RdkmlejagbkdjDJhnww8=
Received: by 10.220.179.196 with SMTP id br4mr2218126vcb.192.1291221577620;
        Wed, 01 Dec 2010 08:39:37 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id r11sm73223vbx.1.2010.12.01.08.39.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:39:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <74d884bbd76bf090472b123f8053f095cda523f9.1291215072.git.jari.aalto@cante.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162547>

jari.aalto@cante.net wrote:

> From: Jari Aalto <jari.aalto@cante.net>

"The -i and -o options cannot be used after --, so do not get the reader's
hopes up by suggesting they can.

Reported-by: Joey Hess <joey@kitenet.net>"

> Signed-off-by: Jari Aalto <jari.aalto@cante.net>

Thanks.

[...]
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -11,8 +11,8 @@ SYNOPSIS
>  'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
>  	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
>  	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status] [--]
> -	   [[-i | -o ]<file>...]
> +	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
> +	   [-i | -o ] [--] [<file>...]

While at it, shouldn't we get rid of the extra space after "-o"?
