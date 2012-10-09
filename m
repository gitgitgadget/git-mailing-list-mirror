From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Discussion around a --bindtodev option for git-daemon
Date: Tue, 9 Oct 2012 16:48:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1210091646430.7433@nerf07.vanv.qr>
References: <50632F15.1030908@scourge.biz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ronan Bignaux <r.bignaux@scourge.biz>
X-From: git-owner@vger.kernel.org Tue Oct 09 16:48:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLb6a-0004tq-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 16:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab2JIOsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 10:48:07 -0400
Received: from ares07.inai.de ([5.9.24.206]:55138 "EHLO ares07.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab2JIOsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 10:48:04 -0400
Received: by ares07.inai.de (Postfix, from userid 25121)
	id B908996A0FAD; Tue,  9 Oct 2012 16:48:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ares07.inai.de (Postfix) with ESMTP id 9981F96A0BF1;
	Tue,  9 Oct 2012 16:48:03 +0200 (CEST)
In-Reply-To: <50632F15.1030908@scourge.biz>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207322>

On Wednesday 2012-09-26 18:36, Ronan Bignaux wrote:

>I wrote this little patch to add a restrict option to bind only to a
>specific network interface.
>
>I'd not deal with --inetd since there are some bugs in xinetd with ipv6
>( and no more maintener ) , systemd/upstart are also Linux centric and
>subject to controversy...
>
>"listen" option was not more useful in my case because it need ip as
>parameter (you need fix ip or custom script for example).

There is a reason --listen wants an address: because bind(2) binds to 
addresses, and in principle, that is really what is wanted, since you 
want to continue being able to connect to your service from-to 
localhost.
