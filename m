From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: FUNKY tags.
Date: Wed, 17 Aug 2005 17:59:41 +1200
Message-ID: <46a038f9050816225944b03dc4@mail.gmail.com>
References: <20050816224332.GE26455@redhat.com>
	 <46a038f90508161755b43735c@mail.gmail.com>
	 <20050817024718.GA11734@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 08:00:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Gxo-0002RN-IY
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 07:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVHQF7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 01:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVHQF7p
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 01:59:45 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:11014 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750909AbVHQF7p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 01:59:45 -0400
Received: by rproxy.gmail.com with SMTP id i8so82812rne
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 22:59:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CWbeTokMVngS+mN/sQu47DtI/6G3zd61VOqPlsi2bN0IYO6H4dX9zCIWUj7izVP63SJocH90MmNgQB0h66CSr45QR3a+RBufp6cuP8Q6tZqQP/Yckur13mEWRhamowQzR4WmNfHX1HyxvHW81PuDIC8rQ5MyWtVLjIAUJ8JFrEI=
Received: by 10.38.209.24 with SMTP id h24mr41809rng;
        Tue, 16 Aug 2005 22:59:41 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 16 Aug 2005 22:59:41 -0700 (PDT)
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050817024718.GA11734@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/17/05, Dave Jones <davej@redhat.com> wrote:
> In my case, at least the most recent of those cvs tag operations
> was just a 'cvs tag x86info-1_14'. Nothing fancy.  I'm fairly sure
> there was nothing fancy about the earlier instance either.
> So sure in fact, I had to look up that -F flag in the man page to find
> out what it did.

Ok - that reduces the suspects to 
 - a tag applied to only one part of the tree
 - a tag that took longer to apply than fuzztime (large tree, slow cvs
connection?)
 
let me know, and if I find time I may look at the repo. 

martin
