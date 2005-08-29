From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: question git & branches
Date: Mon, 29 Aug 2005 23:27:12 +1200
Message-ID: <46a038f90508290427236e261b@mail.gmail.com>
References: <4312C24E.4000803@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 13:29:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9hnV-0004eD-Ew
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 13:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVH2L1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 07:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVH2L1P
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 07:27:15 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:8835 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVH2L1P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 07:27:15 -0400
Received: by rproxy.gmail.com with SMTP id i8so948117rne
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 04:27:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XOvDtWHVHdGsh9+hPn+04FdnIxHy3x0l0wzeL9ufdwkPQuv1yT3Go61xeymhg7jB1uCEuOPJsH2ip9gndk0NT/8Td4y0aDeWWc9p8uRjlCyB7p03U/curX5UxbEcHlozoPf1MSLy2Nw94WkcXtdCDDjm6Pt43o8lYJr4AH+W2tE=
Received: by 10.39.3.53 with SMTP id f53mr274114rni;
        Mon, 29 Aug 2005 04:27:12 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 29 Aug 2005 04:27:12 -0700 (PDT)
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <4312C24E.4000803@candelatech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7900>

On 8/29/05, Ben Greear <greearb@candelatech.com> wrote:
> I created a new branch 'ben_dev_rfcnt'.
> 
> Now, I also have another patch that I wanted to pull into git.
> 
> Before merging this, I created another branch 'foo'.
> 
> I changed to this branch foo and imported my patch and resolved the
> conflicts, etc.

Are you using git-checkout to change branches? If you have cogito
installed, cg-status is a good, handy way of confirming you are where
you expect to be.

You can also do git-show-branch{,es-script}

cheers,


martin
