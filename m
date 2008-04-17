From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Fri, 18 Apr 2008 02:42:17 +0400
Message-ID: <20080417224217.GQ3133@dpotapov.dyndns.org>
References: <20080416203923.GH3133@dpotapov.dyndns.org> <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com> <20080416223739.GJ3133@dpotapov.dyndns.org> <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com> <20080417004645.GK3133@dpotapov.dyndns.org> <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com> <20080417094342.GM3133@dpotapov.dyndns.org> <320075ff0804170309h4232463fk984f362e6cf0a259@mail.gmail.com> <20080417185357.GO3133@dpotapov.dyndns.org> <320075ff0804171503g6dc04aa5pb7c9c362e31ce942@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 00:43:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmcp7-0006fu-3F
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 00:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbYDQWmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbYDQWmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 18:42:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:34805 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYDQWmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 18:42:24 -0400
Received: by fk-out-0910.google.com with SMTP id 19so338485fkr.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=64OhYvFwtI08qyiRHqL3VCTrJ60i1InotpaMfM5ttDk=;
        b=iW33bF75IhBGFIVJMLGshuNdQwE1zaBK86OEHi5qfzsxuOz6CZtlSUf7LySgsZi8KRoh1CVaugRQl2BbAZuNkH1Uhc1uujC/ZcYpH3+pkM16f6tjPelEzU5vDQHOS6GUwnNsUcdcANJ3H5oqfkN/CFN3l+ydQ/8LG2byjYLTSoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YpIqRHHZEwL7tYfQxpeiF2bw/HuRDAZ9+DFBgL0JP4okLsNmetBJbXxAI2QQ6uaaYlYlfuLQ3hFha10zDOarVmPdqDNAGLwvH1W9ddvTK41AWZHamMSsbxuODXdjfvd5LfEXYKqlWsbSrEKfZfmIQV1R1taBhP1H386faxTUXmw=
Received: by 10.82.185.3 with SMTP id i3mr3283579buf.15.1208472142021;
        Thu, 17 Apr 2008 15:42:22 -0700 (PDT)
Received: from localhost ( [85.141.148.116])
        by mx.google.com with ESMTPS id k5sm16620047nfd.23.2008.04.17.15.42.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Apr 2008 15:42:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <320075ff0804171503g6dc04aa5pb7c9c362e31ce942@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79842>

On Thu, Apr 17, 2008 at 11:03:10PM +0100, Nigel Magnay wrote:
> 
> Well.... Newline = LF vs CRLF (vs CR for early mac.. erk) dates to
> well before C and UNIX; back into the days of baudot codes and
> teletype printers that couldn't physically newline in the time taken
> for 1 character to be processed; LF is meant to mean Line Feed and CR
> is meant to mean "Carriage Return", so CRLF is in that sense quite
> logical. But that's standards committees and backwards compatibility
> for you :-/

CRLF is logical from the point of you of teletype printers, but when
we speak about text files then it is more logical to consider them as
a list of lines. What particular symbol is used as line-separator does
not really matter, but IMHO it is stupid to have two symbols for that.
So, LF vs CR is matter of preferences, but CRLF is just stupid -;)

Dmitry
