From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] push: deny policy to prevent pushes to unwanted
 remotes.
Date: Mon, 6 Jun 2016 16:00:56 +0200 (CEST)
Message-ID: <1589200049.381440.1465221656049.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530104501.4402-1-antoine.queru@ensimag.grenoble-inp.fr> <C7CBA69F-64BC-4710-8FF7-5CDC2A59E1E5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	rsbecker@nexbridge.com, aaron@schrab.com, gitster@pobox.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9uyA-0006OJ-NO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbcFFNxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 09:53:24 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40193 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751326AbcFFNxY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 09:53:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C9AEE2593;
	Mon,  6 Jun 2016 15:53:21 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzg_BDhCYOR0; Mon,  6 Jun 2016 15:53:21 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B8A0C2590;
	Mon,  6 Jun 2016 15:53:21 +0200 (CEST)
In-Reply-To: <C7CBA69F-64BC-4710-8FF7-5CDC2A59E1E5@gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: push: deny policy to prevent pushes to unwanted remotes.
Thread-Index: Dv38Qwbz2WK9Aqv+mFsZXxc3WylN4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296510>

Hello Lars, thanks for your reply. 
> 
> 
> > On 30 May 2016, at 06:45, Antoine Queru
> > <antoine.queru@ensimag.grenoble-inp.fr> wrote:
> > 
> > Currently, a user wanting to prevent accidental pushes to the wrong remote
> > has to create a pre-push hook.
> > The feature offers a configuration to allow users to prevent accidental
> > pushes
> > to the wrong remote. The user may define a list of whitelisted remotes, a
> > list
> > of blacklisted remotes and a default policy ("allow" or "deny"). A push
> > is denied if the remote is explicitely blacklisted or if it isn't
> > whitelisted and the default policy is "deny".
> > 
> > This feature is intended as a safety net more than a real security, the
> > user
> > will always be able to modify the config if he wants to. It is here for him
> > to
> > consciously restrict his push possibilities. For example, it may be useful
> > for an unexperimented user fearing to push to the wrong remote, or for
> > companies wanting to avoid unintentionnal leaking of private code on public
> > repositories.
> 
> Thanks for working on this feature. Unfortunately I won't be able to test and
> review it before June 14. I am traveling without laptop and only very
> sporadic internet access :)
> 
> One thing that I noticed already: I think a custom warning/error message for
> rejected pushes would be important because, as you wrote above, this feature
> does not provide real security. That means if a push is rejected for someone
> in an organization then the user needs to understand what is going on. E.g.
> in my organization I would point the user to the open source contribution
> guidelines etc.
> 
> Thanks,
> Lars

I might not understand what you've said, but I think this feature is already 
implemented in our version, with remote.pushDenyMessage. Is this what you're
talking about ?
