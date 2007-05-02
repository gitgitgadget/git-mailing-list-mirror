From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 09:55:02 +0100
Message-ID: <200705020955.04582.andyparkins@gmail.com>
References: <200705012346.14997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, releases@openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 10:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjAcZ-0004jl-Eu
	for gcvg-git@gmane.org; Wed, 02 May 2007 10:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992932AbXEBIzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992942AbXEBIzc
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 04:55:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:22095 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992932AbXEBIzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 04:55:31 -0400
Received: by ug-out-1314.google.com with SMTP id 44so208491uga
        for <git@vger.kernel.org>; Wed, 02 May 2007 01:55:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nldkkN0diNFtNdY21h8ICvE4Algk+81WdAZ3tJImtfqb9TyU5vckLp0e3k/lczHPY94s8C0dC60MzmMiJ9sdbl19+HzX03L9qwiZHfAvkvIgxN23uxxWR6tIy73F+cuO3TN5zUAZvpQDxdsro2+GxmNVhXeQwg+E3x7/iJXQ/tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OMm0nhjGwJyJVlxiJymPGP1odIjz3lW4Uh1ygj0DIZ5MA0yYNmFFWE7cTVB2/02PYW1eUxxYfxz19hyEufVQfXXRPnognIZApM1TfiJNZKjw1s1yU58RQNDxBwfju3sVnBphNOFFuiCfsKwT458UW0PvujYHzpTCBEOZP3bokxE=
Received: by 10.82.146.14 with SMTP id t14mr941448bud.1178096129505;
        Wed, 02 May 2007 01:55:29 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b33sm1914200ika.2007.05.02.01.55.18;
        Wed, 02 May 2007 01:55:25 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705012346.14997.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46006>

On Tuesday 2007 May 01, Jakub Narebski wrote:

> In 'Size of data on the server' git has CVS beat hands down: 1.3G vs
> 8.5G for sources, 591M vs 1.1G for third party. I think it is similar
> for Subversion. I hope that repository is fully packed: IIRC the Mozilla
> CVS repository import was about 0.6GB pack file, not 1.3GB.

I'm fairly sure it's not.  If so that would also affect the speed of 
operations wouldn't it?

I also doubt the subversion checkout size - subversion keeps a pristine copy 
of the HEAD file - so a subversion checkout is usually over twice the size of 
the source tree.

> takes 3min (!) according to the benchmark. 13-25sec for commit is also
> bit long

I wonder if they are measuring the time for the generation of the commit 
message or something?  Or perhaps by using "git-commit -a" is causing a check 
of the whole tree for changed files?

> Comparison / benchmark lacks some crucial info, like what computer was
> used (CPU, RAM, HDD), what filesystem was used, git version etc. It
> does have commands used for tests (benchmarks).

I'd also like to see some of the numbers for the other systems, I tried to use 
subversion with the linux kernel once and got fed up waiting for it to do 
anything.  I suspect the reason numbers aren't shown for the others is that 
they haven't finished yet :-)

> Could you confirm (or deny) those results? go-oo.org uses git 1.4.3.4;
> was there some improvement or bugfix related to the speed of checkout?

Wasn't there a recent change that made repacking after a clone unnecessary?  
That would certainly reduce the checkout size.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
