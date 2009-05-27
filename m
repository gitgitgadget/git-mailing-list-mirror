From: John Tapsell <johnflux@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 14:32:40 +0100
Message-ID: <43d8ce650905270632t2a2914b4j340a5cfd756023a4@mail.gmail.com>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
	 <4A1D2614.5060303@op5.se>
	 <43d8ce650905270628o2eb4ed3cqf6b78e00933198af@mail.gmail.com>
	 <submission.1M9JCt-00047m-4a@mail.cs.st-andrews.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 27 15:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JFP-0002qT-JU
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 15:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762142AbZE0Ncl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762139AbZE0Nck
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 09:32:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:51362 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759153AbZE0Ncj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 09:32:39 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2615367ywb.1
        for <git@vger.kernel.org>; Wed, 27 May 2009 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fNRkKZiiEKUP59WQV6Z3W6eNWKl8P00GAri3X9v7bbA=;
        b=Th8AhgTtu6gBmx88pL3EE3DLd4UTO0IEVweQo0DKSipi5G3NdB79F7RVnt5/jpDD1l
         jnN88MiAhqDr5TMg6B0VTtWhBkPpIy0hzh9UZ3K6C3RlRnQIoopDg5jH4oKQDcz3XlrC
         lVkAAR722OoGVqCONHGMhqCE4yOGSXBO6uZmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gdnbiS32rFewe/e43z7b5UIB4Sr49svE3lBeMATofFKU8x8CHPNcwbI8jh9cuSlSit
         0jSOuQe7DxOMTUDVmMXdhHJ3jW3saZRcGpxk3DO0N9dpOZT2atfQ9s3GKE4HVLZcicUw
         4qT7mPqXsHB0zF9SjB27wytCiTVxdf5zuJRio=
Received: by 10.151.138.13 with SMTP id q13mr230898ybn.157.1243431160974; Wed, 
	27 May 2009 06:32:40 -0700 (PDT)
In-Reply-To: <submission.1M9JCt-00047m-4a@mail.cs.st-andrews.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120063>

2009/5/27 Christopher Jefferson <caj@cs.st-andrews.ac.uk>:
> Something like that, except that limit seems to be only 1.3GB on Mac OS X

Does linux have a similar limitation, lower than the limit imposed by
the filesystem?
Could this be solved by having a fallback solution for mmap?
(switching to opening the file normally)  Or would this fallback be
too intrusive/large of a change?

John
