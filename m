From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Fri, 26 May 2006 15:28:11 +1200
Message-ID: <46a038f90605252028h556d0b2aob43f5c3dca8a5392@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
	 <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
	 <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
	 <dcedf5e20605252024q5bf51486o7cbf6cc396b18b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 05:28:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjSzn-0008G9-8p
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWEZD2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEZD2M
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:28:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:45613 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030229AbWEZD2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:28:11 -0400
Received: by wr-out-0506.google.com with SMTP id i7so297767wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:28:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=egUGdgnz8NihQ2x3H2MLjao/v574LT8Iw6zIvn+0WK6eeuKZw0lfvtJjAtR40PlauPhyJb/hSqbAD1vBQPSCQRESpO6sPkxr5pcEwKqLfRYP8kHVP3h3gYGw2e6X18nLMn5XxOXBpS7kOUB8Fcx0oIfQ9KzhwS2L2GOPJ8une8M=
Received: by 10.54.78.9 with SMTP id a9mr1181244wrb;
        Thu, 25 May 2006 20:28:11 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 25 May 2006 20:28:11 -0700 (PDT)
To: "Cameron McBride" <cameron.mcbride@gmail.com>
In-Reply-To: <dcedf5e20605252024q5bf51486o7cbf6cc396b18b5d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20787>

On 5/26/06, Cameron McBride <cameron.mcbride@gmail.com> wrote:
> WARN  - file 'index' already exists in the git repository

This warning means that you are running git-cvsserver off a repo where
you also have a checkout. git-cvsserver really expects to be running
off a 'naked' or 'bare' repo. For read only ops I think it kind-of
works in a 'checkout' repo, but commits are a different story.

cheers,


m
