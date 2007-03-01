From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 01 Mar 2007 09:02:31 +0100
Message-ID: <45E68897.8000607@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	 <200702281522.14965.andyparkins@gmail.com>	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>	 <45E5DE8A.2080101@lu.unisi.ch>	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:02:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgFK-00084l-AN
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbXCAICg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbXCAICg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:02:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:45276 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbXCAICf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:02:35 -0500
Received: by nf-out-0910.google.com with SMTP id o25so816860nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:02:34 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=maPvzsO1uAbRmgvZNv1XFrU6DF9Kw/2jZGho+NFgdttyJfWy34iFTsDHefMYsaXYLh9RTQ+mPOf9JxskVBz53JIg/bvad6/eoYzYYecBE5nEKXHb2Nx5yOOfAnsV3X/4Oq3f+JSn3yTgalZsByCFWWNFIBftGvAtb8ioJwqjrBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=nWswfQnWxi/QbeeVpz/uUsoRXBuNKVu7dIpRJN+zJaKNjx7XKRioYs6+yChTJEko+ufEHDymOmfTGcS3I2W2ZB1yQ/THMa6c98Plhhtpa+X0UU6XWrWlDW9PRKVeGTgztns5JUih8VzK88IgPD8x0lkSYd8RqJrnqL9AeTbFETc=
Received: by 10.48.210.16 with SMTP id i16mr5247638nfg.1172736154731;
        Thu, 01 Mar 2007 00:02:34 -0800 (PST)
Received: from ?192.168.76.141? ( [195.176.176.226])
        by mx.google.com with ESMTP id e8sm6115785muf.2007.03.01.00.02.33;
        Thu, 01 Mar 2007 00:02:33 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41045>


 > which everyone hated. With this change it will not that blindly,
 > but still unexpectedly jump to some remote branch.
 >
 >> However, with the proposed behaviour, more new users would get less
 >> "Huh?" experiences.
 >
 > yes, it will be the old users who'd get the experiences. What do they
 > do, edit out unwanted tracking from .git/config everytime a branch
 > from remote is created?

If everyone hated the old behavior, old users should already be careful 
about not git-pull'ing (without options) from any branch but master.  So 
they won't see any difference.

Coming from arch, which is not really a masterpiece of intuitiveness, 
this detail (as well as others for which I may try writing patches 
later) struck me as *extremely* unintuitive...

Paolo
