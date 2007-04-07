From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Document --left-right option to rev-list.
Date: Sat, 7 Apr 2007 12:54:31 +0200
Message-ID: <81b0412b0704070354n56d9901agfc4b351736f1d574@mail.gmail.com>
References: <7vwt0rqftv.fsf@assigned-by-dhcp.cox.net>
	 <20070405145307.GA18458@174.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org, davidk@lysator.liu.se
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 12:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha8Z1-0005fb-JI
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 12:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965780AbXDGKyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 06:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965764AbXDGKyc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 06:54:32 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:26576 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965780AbXDGKyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 06:54:31 -0400
Received: by an-out-0708.google.com with SMTP id b33so1218489ana
        for <git@vger.kernel.org>; Sat, 07 Apr 2007 03:54:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fLsj4cCz9oBG1vmqrj45GM3T4Nch5bjtx7t01p/dST9h0iBZIm+S/Mh96ydrJBYXsXmrwePHd3J4uwoDwNZI4gHXbp6r2CxtmeVAO2JucRexVkMv1KsEi1OBgTtQGkXUnAwpaW2Gk/yL3Sa8Xtf7XiEJO9X8U3+++jjC16FSZIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L+kiEYHLI3QYa37kjBFRe0YMBKeGwGpdLndeUqpKM8Iv0ZS6QiZsK7szDbG0RL4iAIyoFMDAKATnd2CYjLCTs2FYvJzRHD/MvISDWcLWLcWUbEahVHfm9EeUbk02gZxDjOVTQSabaG2jtZkqzq9y6GU1jJilJEN2y6PBduqmUq8=
Received: by 10.100.5.17 with SMTP id 17mr2668603ane.1175943271168;
        Sat, 07 Apr 2007 03:54:31 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Sat, 7 Apr 2007 03:54:31 -0700 (PDT)
In-Reply-To: <20070405145307.GA18458@174.242.249.10.in-addr.arpa>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43963>

On 4/5/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
> +--left-right::
> +
> +       Mark which side of a symmetric diff a commit is reachable from.
> +       Commits from the left side are prefixed with `<` and those from
> +       the right with `>`.  If combined with `--boundary`, those
> +       commits are prefixed with `-`.  For example:

"If combined with '--boundary', the boundary commits will be also printed
and prefixed with '-'."

Otherwise it is a bit unclear what commits are prefixed with '-': the left,
the right, or the boundary.
