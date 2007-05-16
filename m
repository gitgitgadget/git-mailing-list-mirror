From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: newby question about merge.
Date: Wed, 16 May 2007 16:21:01 +0200
Message-ID: <46d6db660705160721u24e43f7bmb5171555158089fb@mail.gmail.com>
References: <20070515113820.2621c8d5@localhost.localdomain>
	 <f2c23k$dm0$1@sea.gmane.org>
	 <Pine.LNX.4.64.0705161241560.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 16:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoKNJ-00005G-1t
	for gcvg-git@gmane.org; Wed, 16 May 2007 16:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbXEPOVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 10:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbXEPOVF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 10:21:05 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:43229 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbXEPOVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 10:21:02 -0400
Received: by nz-out-0506.google.com with SMTP id r28so571687nza
        for <git@vger.kernel.org>; Wed, 16 May 2007 07:21:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pnot9WVE0yGXykHgOBNxsQ6hLTVVcKSM9KUvTb0mV0Ibob8CBnYFPQxY2cY06OZrTETRdjOH1ukIiJWmByr/spdFUETw07kqionuCL7UeLFsQCUH2Zwe3ZRqIjDvgYS/1Sba3H3g3QrD+qe5gztQQfhK/+yAerP/yqZ7ISL/SWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QJb2L8R7SCLpNk4KPA19hDEKXRk/oZD4Gl0oNokmgN8NWyVSLWa1ZOzX3c7TjtNzxUUq935FeqHCiV2NrUQ2Rmnqmil2Hi1no1jpySZx/WtwAeFgXaGFEEpLNJCyVzYvJgyHVpc1wBvMwWgd97oXzAtFtSydcZezmxDWHzW3uJc=
Received: by 10.114.81.1 with SMTP id e1mr2177793wab.1179325262038;
        Wed, 16 May 2007 07:21:02 -0700 (PDT)
Received: by 10.115.76.5 with HTTP; Wed, 16 May 2007 07:21:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705161241560.6410@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47439>

On 5/16/07, Johannes Schindelin wrote:
> > You can just do "git cat-file -p :2:filename > filename", then "git add
> > filename" (or "git update-index filename") to resolve conflict.
>
> Do we really want to advertise this obscure-looking plumbing? Wouldn't it
> be better to teach people to use "git show" instead?
>
> I mean, people can get intimidated by that...
>
> Ciao,
> Dscho
>

I could be wrong, but git-show works in this way only after version 1.5, right ?

As far as I can tell, using git-1.4.4.4 or ealier, you would still need
git-cat-file -p... to fix this merge conflict.

-- 
Christian
