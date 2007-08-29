From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 10:05:07 +0100
Message-ID: <200708291005.08795.andyparkins@gmail.com>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Josh England <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 11:05:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJUI-0002Mq-JX
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbXH2JFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbXH2JFR
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:05:17 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:6888 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbXH2JFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:05:14 -0400
Received: by mu-out-0910.google.com with SMTP id i10so175244mue
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 02:05:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z5+KTjbez4fUMhXQHwUvInzz/h+f5nLFMmIPb2kWypmFVp2Eq4mp5jBo7F2DDbYrD4M6bsfrUzmCZxSxnK3OJYeepkhKy5DZbLo8y2HZqXnR0wmgjj2c0iH5tGB+INZ8yxapCxnu5L/zj8BCdi0ZriuWrh92uuA//K2YosyoJc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eyb2Jk30/5EMGQrIjjaJB59hhV8DL//uTnbP+2Pgzwlp0l/xn8ck0hZrzSdnLE6CbTTMhIMcXV3x0C13sM1e1tN15hSUY4EQYp3+C/f8FKCOXtdBYfXCGZqOvWAjnDr1g8Pt6X2U3+wCJXKog2g5AOkrEdjCHy7YobFGuqxRc84=
Received: by 10.86.58.3 with SMTP id g3mr396183fga.1188378312943;
        Wed, 29 Aug 2007 02:05:12 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id 6sm4797814nfv.2007.08.29.02.05.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2007 02:05:11 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070828172709.GB1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56914>

On Tuesday 2007 August 28, Petr Baudis wrote:

> On Tue, Aug 28, 2007 at 06:46:48PM CEST, Josh England wrote:
> > When cloning an existing repository, is there any way to grab
> > the .git/hooks files as part of the clone (or pull)?
>
>   No. You can add the appropriate instructions to instructions how to
> clone the repository, users have to install the hooks manually.
>
>   Now I went on with a large writeup on considerations for implementing
> such a feature (including security), but then I scrapped it. What would
> you like to use these hooks for? Really, perhaps it's best to instead do
> any "post-commit" etc. checks at the push time instead of the commit
> time, so that developers can still freely commit locally, e.g. I
> sometimes do temporary commits on side branches of various work in
> progress changes, then randomly merge them together etc. before I come
> up with the final sequence of commits that I push out.

I've not done it for myself yet, but I had an idea about making an independent 
branch in the repository itself containing the hook scripts for that project.  
That way, the cloners get the scripts but still have to knowingly install 
them themselves.

If you were feeling particularly brave, you could check that branch out 
in .git/hooks.


Andy


-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
