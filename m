From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Heads up on work in progress - was: [PATCH 2/2] Add support ... [rev 11]
Date: Sat, 11 Jun 2005 15:31:41 +1000
Message-ID: <2cfc4032050610223112803863@mail.gmail.com>
References: <20050610092343.3935.qmail@blackcubes.dyndns.org>
	 <2cfc4032050610222853a882b7@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jun 11 07:27:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgyWd-0001HW-Sw
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 07:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVFKFbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 01:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVFKFbn
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 01:31:43 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:6644 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261287AbVFKFbl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 01:31:41 -0400
Received: by rproxy.gmail.com with SMTP id i8so374812rne
        for <git@vger.kernel.org>; Fri, 10 Jun 2005 22:31:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hb31huaCgPE+3qFeVeuqx3rx3YeBFC8+x9oTwxUkzq95MES04MTs5mo2rFvUuCcD0BGdFwwtB1V9N6FgEbBIUsrHnByZeo9JGPSBl9cUae8CgRXXDVWzRE5TbWryGEyLX4KcipIcG2RKRomtJ8C1GhRF3RT2YaF44xUng6w5XMk=
Received: by 10.38.150.2 with SMTP id x2mr17327rnd;
        Fri, 10 Jun 2005 22:31:41 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 10 Jun 2005 22:31:41 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <2cfc4032050610222853a882b7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 2. improve separation of concerns between rev-list.c and commit-graph.c
>    * commit-graph.c will understand everything about incremental graph
> traversals, including merge order search and "localized" perspectives
>    * rev-list.c will be responsible for output limiting [ that is:
> stopping the traversal according to user-defined (e.g. parameterised
> criteria) ]

That'd be - merge order _sort_.

jon.
