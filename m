From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 1 Mar 2007 09:33:43 +0100
Message-ID: <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org>
	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
	 <45E5DE8A.2080101@lu.unisi.ch>
	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	 <45E68897.8000607@lu.unisi.ch>
	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	 <45E68EDE.2090405@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 01 09:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgjX-0002kF-U9
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbXCAIdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbXCAIdq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:33:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:28733 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932911AbXCAIdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:33:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so316311uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:33:44 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rXDLrYtYy9eh61h7wrW2eVw4gx1uW3DTTINW/7RA2CTMkXu8ASfrAuyph4I15COsMUa3AOUJELyEtoDPuIWTo5B7SL0VgofU9bGTrJxvppVF9BPxedN6Y0x9J2YdZO6itHvHAFTs5P7fmFU+xSN/VHYd5PkZuCSQQFQJ/tfN4tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GFi5H9D6HrNjNyWRqYxGoovJXGiv8iZzM8ASlDXkHkb/8FozD7Kh+aDX0FiUQ86oAIq69dbow1oz1W4rhcXc6O3IFW+ev0nXbJOLcZ/lHvUQIYLuWCDSRQRpyqCBRLP/aLL2fvEXxL1WHEy4ddZsznIF4N3ugkvfFQCy3oPiL9U=
Received: by 10.78.166.7 with SMTP id o7mr132021hue.1172738023820;
        Thu, 01 Mar 2007 00:33:43 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 00:33:43 -0800 (PST)
In-Reply-To: <45E68EDE.2090405@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41052>

On 3/1/07, Paolo Bonzini <paolo.bonzini@gmail.com> wrote:
>
> >> If everyone hated the old behavior, old users should already be careful
> >> about not git-pull'ing (without options) from any branch but master.  So
> >> they won't see any difference.
> >
> > except for .git/config growing uncontrollably
>
> While I am probably going to modify the patch to satisfy Junio, have you
> noticed that "git branch -d" will delete the section, hence .git/config
> will not be growing uncontrollably?
>

Maybe you also have noticed that it will remove also the reference?
How do I remove the garbage you added for TRACKING?!
