From: Robert Watson <robert.oo.watson@gmail.com>
Subject: Re: uncommon shell code
Date: Fri, 23 Sep 2005 09:32:26 +0100
Message-ID: <72499e3b05092301322a145e52@mail.gmail.com>
References: <72499e3b05092207326abadd91@mail.gmail.com>
	 <7vu0gclpyo.fsf@assigned-by-dhcp.cox.net>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 10:32:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIiyu-0000Un-KB
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 10:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVIWIca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 04:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVIWIca
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 04:32:30 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:52929 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbVIWIc3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 04:32:29 -0400
Received: by qproxy.gmail.com with SMTP id v40so143317qbe
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 01:32:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jr2Lr4kULuMHpJv74zrDjwtUiED8j1deRQ+lbZBK2FRFQqaP8PKD7doWNQP2xckGKlODWnGnQnGLXRZyMSYYg1yN8QenNX5tWcwymxGo2od44y8Y0dPsRnxVwNKTwuMGfvHBZRYspVdp1m+Yh7uFgqIE0PoTbMktnVbgfSFu3j8=
Received: by 10.64.204.19 with SMTP id b19mr210587qbg;
        Fri, 23 Sep 2005 01:32:26 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Fri, 23 Sep 2005 01:32:26 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0gclpyo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9162>

On 9/22/05, Junio C Hamano <junkio@cox.net> wrote:
> Robert Watson <robert.oo.watson@gmail.com> writes:
>
> > I found the following shell code in git-tag.sh (and others):
>
> My fault; see point 2. in this article:
>
>         http://marc.theaimsgroup.com/?l=git&m=112386506308820&w=2
>
> Please either get used to it or wait until I decide to modernize
> the scripts wholesale, whichever comes first.
>

I see.  I thought I was old fashioned by sticking to test instead of
[] (that is your point 1), but obviously I am not old enough ;)

Well, it's fine now that I know what it is.  But it hurts readability,
and probably it's a good idea to simplify it.  Any reasonable shell
should built-in test(1)?

Robertoo
