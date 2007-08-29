From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 13:56:32 +0100
Message-ID: <200708291356.33126.andyparkins@gmail.com>
References: <1188319608.6106.63.camel@beauty> <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Josh England <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 14:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQN6D-0001Ti-2m
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 14:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbXH2M4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbXH2M4l
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 08:56:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:1108 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbXH2M4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 08:56:40 -0400
Received: by fk-out-0910.google.com with SMTP id z23so154997fkz
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 05:56:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FSn4RhI1ZsheGaKpHkUnjERtMtMeGXWI1XL0CzYDqlJa5PnS3+O/Wcv3WHgfZty/7NreucjNRyM4mhQUy1iqQ82+OoYHBju7pCA3na+cMoLERIZtdCLRahfT0PCzeuXRzeNwNJIUSRzi0PCxKBBG23kkOtnV0yIooY3zRPyS5cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xmjp3JOwgb77DKTn1nVPcILg8JKnYqQj3xr3CeMgVx6ldtUc+bQjBt0MnmnDN3QliF1HCRlxgKl4VkGjwOMNtmwe3BWKbpBqyX34ykYbf8a1NkvC/IV5EDAgq2RIM7owY7/9Z3fXU27mN8XJZBtUVLjCRogvMbhbhAp65QbWcMI=
Received: by 10.82.177.3 with SMTP id z3mr1286020bue.1188392197413;
        Wed, 29 Aug 2007 05:56:37 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id 5sm10263538nfv.2007.08.29.05.56.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2007 05:56:36 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070829095202.GE1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56942>

On Wednesday 2007 August 29, Petr Baudis wrote:

> But overally, I'm still not convinced that there is a feasible use-case
> for the cloned hooks at all. Someone has a particular example?

Hits me all the time.

1) Start a new project
2) Install a pre-commit hook that checks that every patch meets some
   arbitrary coding standard
3) Clone to laptop
4) Kick self the first time you make a commit that doesn't adhere to coding
   standards that would have been enforced by the hook script.

The problem is that my brain thinks that cloning gets me the same 
configuration as the source, but obviously it doesn't and I forget that I 
need to clone _then_ scp .git/config and .git/hooks/*.

I understand that these things are a security risk to do automatically, and I 
don't think I'd advocate that.  However, it would be useful to be able to 
grab those files as well.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
