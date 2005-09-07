From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Wed, 7 Sep 2005 14:44:40 +1200
Message-ID: <46a038f905090619444f94292e@mail.gmail.com>
References: <431DD381.4050709@zytor.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 04:45:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECpve-0001Xn-Sg
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 04:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVIGCoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 22:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVIGCoq
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 22:44:46 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:37054 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750792AbVIGCop convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 22:44:45 -0400
Received: by rproxy.gmail.com with SMTP id i8so939802rne
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 19:44:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sg1DzgH2+VyYLkdMgLxaGzZrRRzLncxQbjohu5D5obJl1RFRikYZmtpaztI2uGOJEZdySxyQlPGbLnMlagADSczJawJxCJDz7Y+oijezGzWFJuRCbzjBtmth+T+ylyq3x8BO1KXFJ4mJql+x4aniyOcnWFJIhJNP9p3lDBq0Vxk=
Received: by 10.38.181.31 with SMTP id d31mr836716rnf;
        Tue, 06 Sep 2005 19:44:40 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Tue, 6 Sep 2005 19:44:40 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431DD381.4050709@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8162>

On 9/7/05, H. Peter Anvin <hpa@zytor.com> wrote:
> This patch changes git-cvsimport-script so that it creates tag objects
> instead of refs to commits, and adds an option, -u, to convert
> underscores in branch and tag names to dots (since CVS doesn't allow
> dots in branches and tags.)

looks good. Will it add proper tag objects for tags already imported
and for tags added to the project post-initial-git-import?

cheers,


martin
