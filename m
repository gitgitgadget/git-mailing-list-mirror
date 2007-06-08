From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 8 Jun 2007 18:04:22 -0400
Message-ID: <1621f9fa0706081504l6106c639oe57c9fd74ebd097a@mail.gmail.com>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>
	 <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
	 <4669CAB4.5080507@slamb.org> <4669CB75.7060009@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Scott Lamb" <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:04:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwmZU-0000UI-5C
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032224AbXFHWE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032215AbXFHWEZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:04:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:59685 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032178AbXFHWEX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:04:23 -0400
Received: by wr-out-0506.google.com with SMTP id i21so831986wra
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 15:04:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZCHo/mBgnNOzPE0J5IJnwYjkDSogrkDnBi0IILI3lR2pC1DhvYz6bc+1UbBrHQ/kw1rsUn9rkF//2s5iTOtJOnJcQpQhSHA7fPwqNBzGcW1HvE6l1IS3dNIUcHv5UYX3zzae/YaZ9MLsTmTEStLipJtnHESttEHDbI8HkOh74g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TEEpAQPZXpXZ11zlbmeMsmBK54vv3HKm/hp53zaiHEZnYxt6+lVaTr2XhjWs9v2IpvUOMwaVcwWFNVdEOubcyPo7IeYYsDD5UYGQaIshC2mvYibQGA85JEYCt7T6DV/sLRBmOGfxY1kYcMLyuY2t4rDgDdh4GCCirDi+q6+kjy4=
Received: by 10.142.83.4 with SMTP id g4mr170357wfb.1181340262353;
        Fri, 08 Jun 2007 15:04:22 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Fri, 8 Jun 2007 15:04:22 -0700 (PDT)
In-Reply-To: <4669CB75.7060009@slamb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49509>

On 6/8/07, Scott Lamb <slamb@slamb.org> wrote:
> Scott Lamb wrote:
> > No need to hardcode - from Python this is
> > os.sysconf(os.sysconf_names['SC_ARG_MAX'])
>
> In fact, just os.sysconf('SC_ARG_MAX') will do.
>

magic number are lot of fun, why would you want to use the clean method :)

So are you saying that in the old days, git-p4 was importing the p4
depo in small slices to not overkill the process memory (in case the
depo is big) ?

BTW, there is the whole universe in my depot, so using -//Work/Users
in my client specification I usually manage to have less megs of code
on my disk after a sync.
This way the git-p4 clone would not use too much memory. But we would
have to change the way git-p4 works, it should be able to read a full
client view instead of just a single perforce path.

Would you give me the git command to fetch the up
git clone <git-url> --date <the good date> ?

Thanks,
Benjamin.
