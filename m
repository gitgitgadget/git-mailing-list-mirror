From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/7] gitweb: Add support for per project git URLs
Date: Thu, 17 Aug 2006 11:58:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608171158330.22866@chino.corp.google.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
 <11558064894129-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 20:59:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDn5J-0005Jj-6Y
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 20:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWHQS7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWHQS7O
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 14:59:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:61659 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932574AbWHQS7N
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 14:59:13 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7HIwvEA024012;
	Thu, 17 Aug 2006 11:58:57 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=HvhAflloEQKPw6n2EcTp2YDW09kGpAOTB++enJYbI7eG/85qFyPjpEvgwRbtRQs/Z
	jr8FmWC55xOIb4taoXJ+A==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7HIwrww013369;
	Thu, 17 Aug 2006 11:58:53 -0700
Received: by localhost (Postfix, from userid 24081)
	id DF47887D71; Thu, 17 Aug 2006 11:58:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id DA86A87D70;
	Thu, 17 Aug 2006 11:58:53 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11558064894129-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25604>

On Thu, 17 Aug 2006, Jakub Narebski wrote:

> It is now possible for project to have individual clone/fetch URLs.
> They are provided in new file 'cloneurl' added below project's
> $GIT_DIR directory.
> 
> If there is no cloneurl file, concatenation of git base URLs with
> project name is used.
> 
> This is merge of Jakub Narebski and David Rientjes
>   gitweb: Show project's git URL on summary page
> with Aneesh Kumar
>   gitweb: Add support for cloneurl.
>   gitweb: Support multiple clone urls
> patches.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

Signed-off-by: David Rientjes <rientjes@google.com>
