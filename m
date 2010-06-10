From: Scott Chacon <schacon@gmail.com>
Subject: Re: Git sideband hook output
Date: Thu, 10 Jun 2010 20:49:19 +0200
Message-ID: <AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
	<20100608214632.GN14847@spearce.org>
	<A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
	<alpine.LFD.2.00.1006090934320.30664@xanadu.home>
	<A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
	<20100610183019.GR14847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:49:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmoh-0000pT-0y
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759331Ab0FJStW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 14:49:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50145 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab0FJStV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 14:49:21 -0400
Received: by wyb40 with SMTP id 40so180423wyb.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0HfT5Y6l0GogHe0wuemYRFme2hH1gI3FsIy8lK9tTnU=;
        b=wOO5d7FgrN03eLE8b7ESvsH0vyWP76trVwzeT0gOV/sgPOES2Q5rDa4u99wl93IjRi
         0IFQ+AuQcESi5d8+ZMa0u/YRp9LeI6hqS14eSfwaywNZp6BCE98hR6qWmLJf/WajdGYX
         vZOzWjR4AxaMVNP/afmTvVuOcW2Xh8kQNWda8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gl1YhHMh1TmoQbXp2PfJI00b6nCmziXDgc68MqM3zqm1Smjvfe/iIPJeFSOO4EVxsf
         J+Hh58jjzwn4q+yIbpp7RZbrQoD5j55SVDcxdilxOBJFnPxQgbsL2gzNylqA7/DuySPv
         3FWRyDV7uCQcN4QXZJWhLTZFz74OWvRxc7GfY=
Received: by 10.227.154.142 with SMTP id o14mr692571wbw.49.1276195759288; Thu, 
	10 Jun 2010 11:49:19 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Thu, 10 Jun 2010 11:49:19 -0700 (PDT)
In-Reply-To: <20100610183019.GR14847@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148909>

Hey,

On Thu, Jun 10, 2010 at 8:30 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
>
> If its really a problem, maybe "remote: " prefix should turn into
> something shorter and language agnostic, like "<< ". =C2=A0But thus f=
ar
> we hadn't had to worry about it, since we didn't have translation
> support in Git... =C2=A0(though yes, I see that is changing now).
>

I would heavily be in favor of a change to '>>' or '<<'.  A lot of
services use the hook output to add useful info after or during a push
and the 'remote:' string is distracting for the user.  +1 to '>>'.  Or
perhaps be configurable, but default to '>>'.

Scott
