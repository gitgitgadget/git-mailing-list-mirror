From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: git-gui doesn't display over ssh, gitk is ok
Date: Fri, 21 Mar 2008 22:28:40 +0100
Message-ID: <ae63f8b50803211428i60ba8656t8c35f24932593fba@mail.gmail.com>
References: <138905EB75AB0D44B6A0ECD251A92EA79C2BFD@sdra00198.intranet.dra-inc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Timothy Schaeffer" <tschaeffer@dramail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jconl-0006vx-7W
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 22:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095AbYCUV2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757661AbYCUV2o
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 17:28:44 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:54853 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbYCUV2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 17:28:43 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2104165fkr.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Wf1eHo4iLC8P7+HCjlPJ4UOvUUDn12x0m2SZa/hRoAE=;
        b=CFIoVKUTkwEmuAEW9vB844bkqp679ggw3edg4MDkv/zopT8BopslKDUnaKqCACUHTjK6Eoe0Htglm1PfjzWeDUSf08sxZbyXJcVDHMnd0hp6j7lkn7TTs9KjrFNo9nHUqk4WZ3j69Rl74EnM8yA20gjfkmwE/3FcNtCSdQ6NtQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=unfEePP7GXDad6ecDPsvifwJHpPI0kcwuNsXPzag2zkZAFR9Tbc3Z1HaxyxT9BhR1ZyXmr0sFCWr4gFBeLb8DFDNx/1raE7GRPZsj7BjXfgWF+eNq1iVn6RxzEwAdBiA7bzosBVFcysBE71o1DhU964aSmXaY5IfrG1A2PpqebM=
Received: by 10.78.172.5 with SMTP id u5mr10569575hue.10.1206134920996;
        Fri, 21 Mar 2008 14:28:40 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Fri, 21 Mar 2008 14:28:40 -0700 (PDT)
In-Reply-To: <138905EB75AB0D44B6A0ECD251A92EA79C2BFD@sdra00198.intranet.dra-inc.net>
Content-Disposition: inline
X-Google-Sender-Auth: d5266b352f11a7dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77772>

FWIW I'm using git-gui 1.5.4.1 without any hickup over SSH -X -Y.  On
the contrary gitk is causing problems because it loads the whole
commit history in the window, and that takes a lot of time over the
network.
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
