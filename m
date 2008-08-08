From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Can't get git clone over https with proxy and invalid
	certificate...
Date: Fri, 8 Aug 2008 07:28:19 -0700
Message-ID: <20080808142819.GJ28749@spearce.org>
References: <c475e2e60808080448x40683db1wadcd834e94d7d263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Giovanni Funchal <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRSy4-0000Aw-5R
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYHHO2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbYHHO2V
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:28:21 -0400
Received: from george.spearce.org ([209.20.77.23]:33632 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYHHO2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:28:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DB5A638420; Fri,  8 Aug 2008 14:28:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c475e2e60808080448x40683db1wadcd834e94d7d263@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91669>

Giovanni Funchal <gafunchal@gmail.com> wrote:
> Ok, so I have created the following ~/.curlrc:
>    netrc
>    proxytunnel
>    insecure
>    proxy = http://proxyserver.com:8080
>    proxy-user = proxyuser:proxypassword
...
> $ git clone https://remoteuser@remoteserver.com/.git/
> Initialized empty Git repository in /home/user/.git/
> error: Proxy requires authorization!
> warning: remote HEAD refers to nonexistent ref, unable to checkout.

Last time I used Git with an HTTP proxy that required authentication
I was doing it with an environment variable:

  http_proxy=http://me:pass@proxyserver.com:8080 git clone ...

Fortunately this was on a Windows desktop where I was the only
user who was logged into the system, so leaking my password into my
environment for a short duration was about the same risk as putting
into a ~/. file.

-- 
Shawn.
