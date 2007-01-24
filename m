From: Pazu <pazu@pazu.com.br>
Subject: Re: git-rm'ing all dead files
Date: Wed, 24 Jan 2007 15:02:07 -0200
Message-ID: <9e7ab7380701240902i4168cc40x1629e76bdf75dcfb@mail.gmail.com>
References: <loom.20070124T171435-429@post.gmane.org>
	 <Pine.LNX.4.63.0701241723560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e7ab7380701240851u1249b46ch36450fcf91bf7986@mail.gmail.com>
	 <Pine.LNX.4.63.0701241756300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 18:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lVo-0000nQ-Ai
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXAXRCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXAXRCM
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:02:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:15403 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbXAXRCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:02:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so628522nfa
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 09:02:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=E6lRFeMiI4FlFqHryQi6fhn8otALOB3J01cFMGaweu7DXtX6z2odv7gIV0cOqFYnzWNvsaKwNUA36gHR3f4gKHyHfVrLeL1HN3dHaay5bIPzc1lp4yGgqoJwiFNiOX4DzsERpL9rPhIICZrNkGKpaGi0R+9r+rItFv6+L29KVyY=
Received: by 10.48.245.17 with SMTP id s17mr3153152nfh.1169658127807;
        Wed, 24 Jan 2007 09:02:07 -0800 (PST)
Received: by 10.48.216.13 with HTTP; Wed, 24 Jan 2007 09:02:07 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0701241756300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: dff2dca1fdf2185e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37657>

2007/1/24, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> You _can_ use
>
>         git ls-files -z -d | xargs -0 git rm --cached
>
> So, you did not find that option with git-rm, because it is an option to
> xargs...

I remember trying that, but git-rm was still confused about spaces in
filenames. I'll try it again the next time I'm in a situation like
that.

-- Pazu
