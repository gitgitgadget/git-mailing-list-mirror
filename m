From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Wed, 28 Apr 2010 14:50:01 -0500
Message-ID: <20100428195001.GA2242@progeny.tock>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 21:50:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7DH7-0008Sz-0v
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 21:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab0D1TuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 15:50:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37093 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab0D1TuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 15:50:08 -0400
Received: by pvg2 with SMTP id 2so469137pvg.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DGf6s1s3q/03XbVZkwfwJiDFUtu259EStQhJeCoPoac=;
        b=Lr32KPsiszCm3oTSDmlWvU86qn0HUspW5t2hHhFstz4CDlEm1PeW0sFPeeWWe7vAqb
         27jD61/hqYrpe+AgEcEa/o04uWN7V63gOUhHnyDuJCHuW1/X0XZLLLc3FqHKnwJyWaqL
         mXRvNNRy2WK5Wr/WWea4/lQLoTf17AP0pS0dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fOgcNWmwLXPQqYv0w3/NeBfWZ5PB1ywzDgFeSHK5NCTXm0Xh9Pslz8seEJALKp11kl
         E9zvSH4+MbZkUAeaVmZ5/Ih2EjemAqYF7Q5HnHgezbz+yJST3zQ5SaXHVL6ONYqI+xYs
         dcoQvE7mD/vmoZWuIk8tI8NSURz7Jzt8IuIvM=
Received: by 10.142.248.1 with SMTP id v1mr4542180wfh.107.1272484207996;
        Wed, 28 Apr 2010 12:50:07 -0700 (PDT)
Received: from progeny.tock (252-64-212-66.spl.org [66.212.64.252])
        by mx.google.com with ESMTPS id y27sm53440wfi.5.2010.04.28.12.50.05
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 12:50:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146007>

Eugene Sajine wrote:

> the automatic cherry-pick failed and caused conflicts, so in
> order to to cancel the whole operation i had to do the following:
> 
> 1. mark the conflicting files as resolved (without even resolving
> them) by doing git add.
> 2. unstage all files staged for commit as a result of incomplete cherry picking
> 3. manually checkout touched files to their correct state (git checkout file)
> 
> and then i was able to repeat cherry-picking with correct commits.
> 
> Is there a better way?

git reset --merge

Ideas for where this should be put in the git-cherry-pick.txt manual?

Thanks,
Jonathan
