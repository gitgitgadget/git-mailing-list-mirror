From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 11:10:23 +0100
Message-ID: <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060221215742.GA5948@steel.home> <43FB9656.8050308@vilain.net>
	 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 11:10:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCDQd-0003po-Gd
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 11:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWBWKK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 05:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWBWKK0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 05:10:26 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:18033 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751098AbWBWKKZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 05:10:25 -0500
Received: by nproxy.gmail.com with SMTP id c31so9169nfb
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 02:10:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QpM6XTdwtsEXL+892pNmW34UZr9g8BFJqfX8QFQVs3y8rVKREPFbcDcSDUsqVELQBUPL9ym7FETrmUbKkGrGtgXMtazFz0Dk5Fz/fDsKjssK/JvLgebFZDyHXq/WRc8vaF8V+wQ6O6fKmVTGCpZEzGYsGg+rQBadp5ZS8IViLw0=
Received: by 10.49.61.3 with SMTP id o3mr1935276nfk;
        Thu, 23 Feb 2006 02:10:23 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 02:10:23 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <43FD84EB.3040704@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16638>

On 2/23/06, Andreas Ericsson <ae@op5.se> wrote:
> Not to be unhelpful or anything, but activestate perl seems to be quite
> a lot of bother. Is it worth supporting it?

It's not activestate perl actually. It's only one platform it also
_has_ to support.
Is it worth supporting Windows?
