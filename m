From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 18:16:11 -0500
Message-ID: <4B636C3B.8040308@gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 	<fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com> 	<7veil8iqnj.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291614550.1681@xanadu.home> 	<fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com> 	<alpine.LFD.2.00.1001291628510.1681@xanadu.home> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:16:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb04d-0007gt-Cp
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab0A2XQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131Ab0A2XQR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:16:17 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:44440 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0A2XQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:16:17 -0500
Received: by yxe31 with SMTP id 31so2344787yxe.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=buxPJewvtLKlBpuOL/gJpRiAnR0RQ9VMYiwmowsLeRc=;
        b=wAyTljrA1rntn9kv6jvl5uQGEUL+svLU6hFRD9y/Q+HfMaGF/qjx76+0frRWQiyib5
         WBhYtGax88dWpuCwFkiJXF8eQtWalrcbyG0LP1oTU+M6qwVijpsfWBRZ+CZvU5iPAXOO
         H7eMqUNjU9dflTSp1QNrXSi/8Oytr+/XQ7u88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=hEajIJR3uYymqVBIMXvJV+9kwjWnozLYEM9WIcaMIga7t14lx0AZ7s5sf7YtY3bSx8
         J+EHqLqp4JVBoZylZ0CiuFabVpN+htx8vByAODW5v+TYxKNGMwil++DzOQxg3gpu/Wan
         ZmhlTl4cstb4E+OejE/YauGa3wLy5orfC5zO4=
Received: by 10.150.251.16 with SMTP id y16mr2585660ybh.188.1264806973670;
        Fri, 29 Jan 2010 15:16:13 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 21sm882328ywh.16.2010.01.29.15.16.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 15:16:12 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138399>

Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Jan 29, 2010 at 22:29, Nicolas Pitre <nico@fluxnic.net> wrote:
>> Then who was arguing about making Git more user friendly rather
>> then less?
> 
> Using a detached head is a more advanced feature than wanting to
> checkout a remote branch locally, creating a local tracking branch. As
> such, 'git checkout origin/topic' now means the same as 'git checkout
> -t origin/topic', and you can get the old behavior back by doing 'git
> checkout origin/topic^0'. I don't see what the problem is, if you're
> using a detached head you're an advanced enough git user that you can
> remember that you can use '^0' to detach your head. It's not all that
> uncommon to do 'git checkout HEAD^0' to detach your head to the
> current branch, no?
> 

[I'm still catching up on this thread]

What we call 'Detached head' is _the_ normal way ti use git for quite a 
number of users. And given the current UI, it's not really advanced.
