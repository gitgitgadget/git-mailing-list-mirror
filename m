From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Thu, 4 Oct 2007 22:25:12 +0100
Message-ID: <200710042225.13670.andyparkins@gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdYCL-0006ts-Ur
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796AbXJDVZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757708AbXJDVZY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:25:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12086 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129AbXJDVZX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:25:23 -0400
Received: by ug-out-1314.google.com with SMTP id z38so417339ugc
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=sG9yaYaJP53qjK/VjiOThHClt7tpQlrDOwXR80VnLKM=;
        b=SKjY4j6NE8G9vKbCe9Wz5C39mP4cYlWY3j/mNtclki4rjLi7kKJXnyu0IoyxyPXupPkE0lE4luBBSqSHdXowygEWNE0sfcYw91rlV0Dijp3TlA887Vcu1DV3SNw3IoxSrjBBduvfIWN/tup29GPSgHwA4k7FIogNAhZ/IVR5brg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cD/wMjrdI12mW8l7XcOrG9X4/MUr6DjDspPkb6zSf4tfH4jcWTI6dlEzebv7Uw93HDQkxxUt36cBUbZsqj5BOvUIfHqc/UmhVxesqGOnN790JtMFJ6gUY99a/7wetXLmK6YolMzahKJ6HcqJeSkYshHIGZVujPmUrYkpz5VYaRo=
Received: by 10.67.31.5 with SMTP id i5mr2494571ugj.1191533121970;
        Thu, 04 Oct 2007 14:25:21 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id k28sm7450369ugd.2007.10.04.14.25.20
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2007 14:25:21 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60010>

On Thursday 2007, October 04, Paolo Ciarrocchi wrote:
> Hi all,
> I was just wondering why git commit doesn't default to "-a" (yes, it's
> another question that came up during a chat with a mercurial user) and
> I didn't find an answer to that.
>
> It's not a big deal but I strongly suspect that the large majority of
> the git users never user git commit without the option "-a".
>
> Am I wrong?

Yes, I think you are.  I suspect that most users start out using git 
commit -a, because that's the workflow they were used to with their 
previous SCM.  What happened to me was I started with

 git commit -a

Then I started adding files one at a time

 git add <file>

Now I cherry pick hunks together in coherent groups 

 git add -i

Once you figure out that git lets you turn your development history from a 
simple snapshotter to telling the story of the project's development, 
you'll find you want finer and finer control over what you're committing.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
