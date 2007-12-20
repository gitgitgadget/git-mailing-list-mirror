From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 10:46:15 +0000
Message-ID: <57518fd10712200246qdc1062btb5c20de946468995@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <476962D5.3050409@lsrfire.ath.cx>
	 <57518fd10712200243o26641b3bjf9be3898a2f0c7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 20 11:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5IvL-0006gE-Cy
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 11:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbXLTKqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 05:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756040AbXLTKqU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 05:46:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:44196 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbXLTKqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 05:46:20 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2999781rvb.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 02:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=1cVSd4h9K25DFppfVd4JFQDLfS1nfsqkvn5ILmDnqxk=;
        b=LN8Pn9TnhhoZ/Ey5MkIbshJaGTL8bV+4nn2sK57dlkiHtDjwLo+EOWV5aBmuuwILnHqBRlAXf/muHHiPqlOeOmLDKxesN9Hh6s/JciwlIS1vNDuVTBojJ9hrqVHJG2mHyrc3Jx9Apj7N2XRjHBwpXI/8wky2u26MdUqUzRyuaf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=vXHNvML4L98jZCu45FX6E15fL2Wzg2mKEzQjiTnQdfxeZr+SqfiLwYF9NsuQTLxfZctdcvT1Y2pgDUBCrM6yptTq2t0E/oZiOIg0zTsuq9AFCNwREZ9coPl78dyzJ6jstUEcRAi2fC7kgmHadfpyRcM05CwxfO8J0vWCkBXe5Ig=
Received: by 10.141.195.18 with SMTP id x18mr2043412rvp.171.1198147575325;
        Thu, 20 Dec 2007 02:46:15 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Thu, 20 Dec 2007 02:46:15 -0800 (PST)
In-Reply-To: <57518fd10712200243o26641b3bjf9be3898a2f0c7e1@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 5cd37380fb429b99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68990>

> Hmmm.   I wonder if it's coincidence that I can only seem to spot this
> problem in my repos that have been set up via submodule init...

Ignore that last bit, red herring.
