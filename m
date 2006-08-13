From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git-publish
Date: Mon, 14 Aug 2006 11:53:07 +1200
Message-ID: <46a038f90608131653k1a2d0480x411be91bdc3f60ca@mail.gmail.com>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 01:53:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCPlZ-00023f-GD
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 01:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWHMXxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWHMXxK
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 19:53:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:20929 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751738AbWHMXxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 19:53:08 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1542877nfc
        for <git@vger.kernel.org>; Sun, 13 Aug 2006 16:53:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MyiPUnqbm+79xKy97qr8s4bC37jMGq6sx83UmSJKXsH6GylhRcvoSSdDHeRxcq6p7k/EYMpTNSgI6UnA0p5bvgPphaGMgpwtV5j3pzngLd9mHXIw2X3D5ICO2EkUGWCZuFRMwiw+hfxKNVpvv2Jp8idrN+So3aoCSvIJySIc180=
Received: by 10.78.150.7 with SMTP id x7mr3029446hud;
        Sun, 13 Aug 2006 16:53:07 -0700 (PDT)
Received: by 10.78.97.17 with HTTP; Sun, 13 Aug 2006 16:53:07 -0700 (PDT)
To: "Daniel Barkalow" <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25299>

On 8/14/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Like how "pull" is "fetch" + "merge",

Slightly OT... I thought git-publish host:/path/to/repo.git would be
something to automate the initial "publishing" actions, which for me
are:

 ssh host 'mkdir path/to/repo.git'
 ssh host 'GIT_DIR=path/to/repo.git git init-db'
 ssh host 'GIT_DIR=path/to/repo.git git repo-config someopts'
 git-push git+ssh://host:/path/to/repo.git

Hmmmm. Would this be git publish-repo maybe?

cheers,



martin
