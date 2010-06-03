From: Lin Mac <mkl0301@gmail.com>
Subject: Re: How do I ignore the changes made by CVS keyword substitution 
	efficiently?
Date: Fri, 4 Jun 2010 03:50:36 +0800
Message-ID: <AANLkTikqNZB9sicxfCfYY7Koxj2CUPpESxYe5ikPYiMd@mail.gmail.com>
References: <AANLkTilhvjn1ypRoKs2CxJdA1zDkaT5i64vh0ZtfjwMk@mail.gmail.com>
	<20100603193527.GK28492@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
X-From: git-owner@vger.kernel.org Thu Jun 03 21:50:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKGRI-0002kU-47
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 21:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab0FCTuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 15:50:40 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:50675 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0FCTuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 15:50:37 -0400
Received: by pzk15 with SMTP id 15so362622pzk.15
        for <multiple recipients>; Thu, 03 Jun 2010 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SjJtEv/aHfwwXOPq4JyRs5hCP1z450bZBdF2UacxO4s=;
        b=MCAZWDcUMDATE52iLnlHP5VomrgU9KJKEC90RpViPoSH0QGoaLAK1oN4mLyZoYwPzI
         ZpmlhNJ9CKwgeSNBY8C0CrkAo+dQZ/ko1QsLsB24Ct3igDUDj3bVCeKTp6JHwc4f/3CZ
         OhbrLl+tRDSUIcbik28DHOty79BBa5AoeFYd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=m8aLWLd9SaNJSseWUTq7SuvdGVT/I0rMSzqp7fxBXADH0thPWVUzi7hoSdzYJB9kKW
         i81nrUkKRpbLO03KSqf1yBvmGjiWXdwEfz3mjGFeYbwrenkEN/+vZwtEGU2LQC8v66aE
         1T2RAMX8yiqNq+EcxnE3aykV9UUNeDL45eFKc=
Received: by 10.142.66.23 with SMTP id o23mr7225708wfa.321.1275594636586; Thu, 
	03 Jun 2010 12:50:36 -0700 (PDT)
Received: by 10.140.134.6 with HTTP; Thu, 3 Jun 2010 12:50:36 -0700 (PDT)
In-Reply-To: <20100603193527.GK28492@bombadil.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148356>

2010/6/4 Kyle McMartin <kyle@mcmartin.ca>:
> You want the -ko option to cvs checkout/update which will use the
> original keywords from the import.
Yes, that could be done. But usually it would be faster if I could
solve it myself than asking them to release again.

Best Regards,
Mac Lin.
