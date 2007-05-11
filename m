From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.2-rc3
Date: Fri, 11 May 2007 10:23:37 +0700
Organization: AcademSoft Ltd.
Message-ID: <200705111023.37676.litvinov2004@gmail.com>
References: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 05:23:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmLjE-0000ZS-K3
	for gcvg-git@gmane.org; Fri, 11 May 2007 05:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbXEKDXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 23:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759767AbXEKDXL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 23:23:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17694 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759706AbXEKDXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 23:23:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so736710uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 20:23:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=rchEoJ39GKSxflor/zoMx8Xb5oEonsyb2GwzS975RaQijqDKZL01AhwPyDKcJRXUnsV/ZUPoYQ4cXnT5SnyBjvEHfM9cmO+yJX2X5RtC1CYvAHZJguLjpVtowEcJfOJ1PxCD7IFeH8D6MgpEf5gCOOremjHjzPGloaqo8DbP/2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=MGzfwLzxxqRov6TNGpyGv1LX1qzIdQYAvLdINzvAGQO1KSZ8N+MFi6ONz59RQ3IT6dvQgv7Vvqc4CS4JC+AaU8tDNgzYVI2E4wY0+BBL/6q1iGUicx9h/yuHqC9aF21wMjeUImlPOE7uOTvoiMJEXf+FF3O6hxTjlW3qmHbUmOU=
Received: by 10.67.19.13 with SMTP id w13mr2548715ugi.1178853788313;
        Thu, 10 May 2007 20:23:08 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id m1sm5233401ugc.2007.05.10.20.23.06;
        Thu, 10 May 2007 20:23:06 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46931>

Hello.

> * Plumbing level subproject support.
>
>   You can include a subdirectory that has an independent git
>   repository in your index and tree objects as a
>   "subproject".  This plumbing (i.e. "core") level subproject
>   support explicitly excludes recursive behaviour.
>
>   The "subproject" entries in the index and trees are
>   incompatible with older versions of git.  Experimenting with
>   the plumbing level support is encouraged, but be warned that
>   unless everybody in your project updates to this release or
>   later, using this feature would make your project
>   inaccessible by people with older versions of git.

Is there any help onhow to use subprojects ? I did not found anything at 
Documentation/ directiory.

Thanks for help,
Alexander Litvinov.
