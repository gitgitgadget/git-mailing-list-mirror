From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 00:38:35 +0300
Message-ID: <f36b08ee0606141438u7d7b59e1ra68bc23e2e926290@mail.gmail.com>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	 <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
	 <f36b08ee0606141330l28330d79hab1aec5c741188c7@mail.gmail.com>
	 <7vhd2nctjk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 23:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqd4R-0001Vx-6I
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 23:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFNVig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWFNVig
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 17:38:36 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:35172 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932328AbWFNVig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 17:38:36 -0400
Received: by py-out-1112.google.com with SMTP id i49so45572pye
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 14:38:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqdudKPosXrRTwG4xiYm0WU8iRH24biKAuCwFlDuN5Tydby2B1y5W0QlQ9fyP3wN8x0p5YsfUlXLcZbsrPeS1cGO8Gwq6F0DaKEgzgzXPsu8mzf7JlYnlyOKqVLonzw/fbye/wcbDVwP4+3baLag1T3WFGjyA0LFGolNeo0Xu1E=
Received: by 10.35.93.15 with SMTP id v15mr1759929pyl;
        Wed, 14 Jun 2006 14:38:35 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Wed, 14 Jun 2006 14:38:35 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhd2nctjk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21867>

On 6/15/06, Junio C Hamano <junkio@cox.net> wrote:
> "Yakov Lerner" <iler.ml@gmail.com> writes:
>
> > I think single GIT-BUILD-FLAGS
> > is enough, which will cover prefixes, too. Is this OK ?
>
> Yes, it was what I was getting at.  I think a single
> GIT-BUILD-FLAGS (or whatever name the list can fight over while
> I am away) is preferred.

Either GIT-CFLAGS or GIT-BUILD-FLAGS,
whichever is shorter :-)

Yakov
