From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 1 Mar 2007 09:10:25 +0100
Message-ID: <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org>
	 <200702281522.14965.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
	 <45E5DE8A.2080101@lu.unisi.ch>
	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	 <45E68897.8000607@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 01 09:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgMu-00031n-Hv
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbXCAIK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbXCAIK1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:10:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13452 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbXCAIK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:10:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so313986uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:10:25 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=toIzsC8I00e017yWTIQS6bq4D/8+qa8BXyzprd0HuuPdRy4ox3Esr2Vln6V3e+cyUzOk9y5GKzzqajPGov2Bv4KtVkifoViV7Aik/cFNyJcVilBw9gl6EaQByy1knsdycAC/8RsKbOSVW5n6VocP2uXiGXt2ofBvRqF5dUTh/4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hx4b1LRdUu8SG23vREmR8fiM/0KxxwEOiZ84ZOqfnoqgfjzsZqkI4LrOg56BgU5BnDeWjhYOVQcpm3yBKLuA1GjKzXVFo24oEEVJxMNPT8DBKYueqMGcPdEYrenS2QDQ5oieOXm3U4JFtRcAMNZOWFmpzxuzTIA/LI7qB+NiCvI=
Received: by 10.78.201.2 with SMTP id y2mr137628huf.1172736625270;
        Thu, 01 Mar 2007 00:10:25 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 00:10:25 -0800 (PST)
In-Reply-To: <45E68897.8000607@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41047>

On 3/1/07, Paolo Bonzini <paolo.bonzini@gmail.com> wrote:
>
>  > which everyone hated. With this change it will not that blindly,
>  > but still unexpectedly jump to some remote branch.
>  >
>  >> However, with the proposed behaviour, more new users would get less
>  >> "Huh?" experiences.
>  >
>  > yes, it will be the old users who'd get the experiences. What do they
>  > do, edit out unwanted tracking from .git/config everytime a branch
>  > from remote is created?
>
> If everyone hated the old behavior, old users should already be careful
> about not git-pull'ing (without options) from any branch but master.  So
> they won't see any difference.

except for .git/config growing uncontrollably
