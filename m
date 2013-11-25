From: Tim Chase <git@tim.thechases.com>
Subject: Re: branch annotations?
Date: Mon, 25 Nov 2013 09:08:45 -0600
Message-ID: <20131125090845.24ed43e3@bigbox.christie.dr>
References: <20131125084644.350bd4f7@bigbox.christie.dr>
	<CALKQrgdTxYmy2ncXNB29B0-05g8CK=-jxWfDVPbUjHTPsm1yOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Johan Herland <johan@herland.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 25 16:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkxl0-00050C-6b
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 16:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab3KYPHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 10:07:22 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:56425 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753235Ab3KYPHV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 10:07:21 -0500
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:58937 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1Vkxku-0004yJ-Ce; Mon, 25 Nov 2013 09:07:20 -0600
In-Reply-To: <CALKQrgdTxYmy2ncXNB29B0-05g8CK=-jxWfDVPbUjHTPsm1yOw@mail.gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238315>

On 2013-11-25 15:55, Johan Herland wrote:
> "git branch --edit-description" allows you to write a descriptive
> string for your branch. AFAICS, however, it currently only shows up
> when using request-pull. It does not show up in any git branch
> command. IMHO that should be fixed.
> 
> As a workaround, you can use this one-liner:
> 
>   git for-each-ref --format "%(refname:short)" refs/heads/ | while
> read branch; do echo "$branch - $(git config
> branch.$branch.description)"; done

That works like a charm.  Thanks!

-tkc
