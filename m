From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] introduce inline is_same_sha1
Date: Thu, 17 Aug 2006 22:50:50 +0200
Message-ID: <81b0412b0608171350w1095e35ch7c017e973e6510f5@mail.gmail.com>
References: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
	 <81b0412b0608170459if099fcane9d9e91a3fdac9e6@mail.gmail.com>
	 <Pine.LNX.4.63.0608171152110.22819@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 22:51:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDopd-00005Q-1a
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 22:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWHQUuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWHQUuw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 16:50:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:45786 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932066AbWHQUuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 16:50:52 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1077623nfa
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 13:50:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oGZn1BaVj71J5udFtebOTyZyWjKSGv8iEMMo+2J18Yp0b4xORq/Cs65rofAk4aURVLVCDTd0kI3gzKKl9VabOCvI5zFuGdIBZIIVFdIhK8idWCCoq5R5PwOKNofd4vEooGXq6YBwaDX81sKmtSX3kzhUn88mDn2lHqspiy0MW3Q=
Received: by 10.48.220.15 with SMTP id s15mr3046449nfg;
        Thu, 17 Aug 2006 13:50:50 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 17 Aug 2006 13:50:50 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608171152110.22819@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25612>

On 8/17/06, David Rientjes <rientjes@google.com> wrote:
> Introduces global inline:
>         hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>
> Uses memcmp for comparison and returns the result based on the length of
> the hash name (a future runtime decision).
>
> Signed-off-by: David Rientjes <rientjes@google.com>

Acked-by: Alex Riesen <raa.lkml@gmail.com>
