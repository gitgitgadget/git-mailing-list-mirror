From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:33:11 +0100
Message-ID: <200705021633.14428.andyparkins@gmail.com>
References: <200705012346.14997.jnareb@gmail.com> <200705021158.04481.andyparkins@gmail.com> <200705021637.02057.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jan Holesovsky <kendy@suse.cz>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 17:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjGpw-0001AG-Gp
	for gcvg-git@gmane.org; Wed, 02 May 2007 17:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993376AbXEBPd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993375AbXEBPd3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 11:33:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:58378 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993373AbXEBPd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 11:33:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so271012uga
        for <git@vger.kernel.org>; Wed, 02 May 2007 08:33:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SIc8s/Aok+78XDdfRsz/8xWFphYInlYcZF2Hh79w6ZiPReYlAN957fmrd9XACNbxE+em+59WQqF8CHxmDCJxWWAr6R0MFHgPPmKhqON3BEWvsOgbKycN+fgGzNYBxGkIu3kXVoTk4UP7izFucNGAaH+7cjdw3cdoio9MoWQqXDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Sq/JEBWl6URfjc/5Z3qyvkTOeQcQTQ3I0V1BFclbc9H2MQWA5EhHMO9/ZvOXw/PFVjJfqtMrF5v/qFZVEZz89y5oC1SEFQW3i0Weje+ZwGz98rlHoDTGfh8gY/s64qy87OI65yMjdZ4PFOyCxHQQ4WNRHWI7hlJnfUmwoqNf2P4=
Received: by 10.82.100.1 with SMTP id x1mr1632490bub.1178120005881;
        Wed, 02 May 2007 08:33:25 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c25sm8836ika.2007.05.02.08.33.18;
        Wed, 02 May 2007 08:33:21 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705021637.02057.kendy@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46029>

On Wednesday 2007 May 02, Jan Holesovsky wrote:

> Unfortunately I don't have the _exact_ numbers here any more so I cannot
> prove it ;-) - but this is a rounding problem [CVS checkout is slightly
> more than 1.4G].  Similarly, overhead of of CVS directories is 0 when we
> count in gigabytes.

0.1G would have been an awfully big rounding error.  Regardless, Julian has 
put me right on that - the git checked out size was actually 2.7GB - this 
then lines up with the CVS figures.

> > - SVN checkout overhead is always _at least_ the size of the source tree
> > because it keeps a pristine copy of HEAD.  If the source tree is 1.5G,
> > then this figure should be at least 3G.
>
> Yes, this surprises me as well.  I've heard about some improvements in the
> recent SVN, but 0.1M sounds very small.

Very much so - I've tried with a 1.4.2 and my own small repository and the 
pristine copies are stored uncompressed as always.  0.1G now sounds plain 
wrong.  Maybe there are some switches I should be using to svn checkout.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
