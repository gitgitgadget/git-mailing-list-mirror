From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: svnimport problems (abysmal performance and crash) on Cygwin
Date: Wed, 14 Mar 2007 08:50:49 +1300
Message-ID: <46a038f90703131250h1be0507v2feada21ea161362@mail.gmail.com>
References: <45F4F58D.2010701@dawes.za.net> <45F50023.9030403@dawes.za.net>
	 <46a038f90703120339j674e15cqe0e0fa587736f9bc@mail.gmail.com>
	 <45F59193.1070608@dawes.za.net> <45F6F724.4080704@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, normalperson@yhbt.net
To: "Rogan Dawes" <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRD1M-00046M-6Q
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbXCMTuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 15:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbXCMTuw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 15:50:52 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:44984 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933045AbXCMTuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 15:50:51 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2701648muf
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 12:50:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gWPNj4tO9xDFbGs5mm/EYSoqlqG08ekD9O+s2fm2C418sklYUG1JvrZwYvBJcY19ujnOC4DjYBfIwoVCMAliCuBOfBiQU/zp3qsG2KNko73w9glvdhcTXpG1RiEDCnqMdwijMfMQnRyGgMuByTMJCFTtQeywZfOLA5KYMdumcJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nZp05CflRasMS8Hbateu5RxMUDM7DvZH/nfKDWx7yQYhvt6OgdfNW5R5gv3K9D/K82eAUECtEWOGqDknckvxmVS0Y77CSoTVjsFH2cnH3iFjwTrerUxbmNaq78H+EuTUbUg9wxishApI4qEMVSFxYnhjG3LR47mVZXAWHg3G61U=
Received: by 10.82.175.2 with SMTP id x2mr2414894bue.1173815449569;
        Tue, 13 Mar 2007 12:50:49 -0700 (PDT)
Received: by 10.82.183.14 with HTTP; Tue, 13 Mar 2007 12:50:49 -0700 (PDT)
In-Reply-To: <45F6F724.4080704@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42148>

On 3/14/07, Rogan Dawes <lists@dawes.za.net> wrote:
> Any suggestions?

I don't think I have ever been able to use svnimport without naming
the trunk, tags and branches parameters explicitly -- SVN repos are so
varied in their layout that the importer has no hope of figuring it
out.

cheers,


m
