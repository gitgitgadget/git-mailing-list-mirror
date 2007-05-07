From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] connect: display connection progress
Date: Mon, 7 May 2007 09:51:45 +0200
Message-ID: <81b0412b0705070051j4ff9b2c9wf3471143cfb0bea0@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <20070506222123.GB2439@steel.home>
	 <20070507045451.GE30339@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon May 07 09:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hky0c-000663-A8
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXEGHvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 03:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbXEGHvr
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:51:47 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:45502 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXEGHvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 03:51:46 -0400
Received: by an-out-0708.google.com with SMTP id d18so119938and
        for <git@vger.kernel.org>; Mon, 07 May 2007 00:51:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1+YtdJ8kqON4j/zcSWfm/IgLXNDHBgJTSyiEPqY99RKYP6zIP4gDLW+8YedVZt2bduzANAvKSzvh63cp3G3SLZGdHk2TQaybm1vXKYsFgTMRywp2Mnrck7NJKgXCW56xjCub+TMEFr/4/Bk7IfeOzEx+Haj+aaggRUc25b2RbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SLtO6jnGPPSwzmUwkhkp7vtC/HpnMzptAj7wslj45zJTwPHToSzM7rDd3JVI1DEKR+fSSNSjToi0sFsIBEK7CPFu+KPIDNrczZUd7kQTL8MD4AGhMqA7XE4hEyoDhhImoys9+XLuFnBnTMEz0zjPWzOPjX7fhNrBennSswAwrE0=
Received: by 10.100.177.16 with SMTP id z16mr4559932ane.1178524305740;
        Mon, 07 May 2007 00:51:45 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Mon, 7 May 2007 00:51:45 -0700 (PDT)
In-Reply-To: <20070507045451.GE30339@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46425>

On 5/7/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> My manual says:
>         The inet_ntoa() function shall convert the Internet host address
>         specified by in to a string in the Internet standard dot notation.
>
> does it work for IPv6?

does it have to if NO_IPV6 is set?
