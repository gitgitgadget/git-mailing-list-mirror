From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 10:47:45 -0800
Message-ID: <4B101ED1.9000607@gmail.com>
References: <20091125203922.GA18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net> <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com> <20091127062013.GA20844@coredump.intra.peff.net> <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> <20091127095914.GA4865@sigill.intra.peff.net> <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302> <6839293b0911270827x54947c64q5f93e37664bc20f3@mail.gmail.com> <7vk4xbn7nl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5zE-0008PR-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbZK0Sz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbZK0Sz5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:55:57 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58856 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZK0Sz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:55:56 -0500
Received: by pwi3 with SMTP id 3so1118570pwi.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=vXFmBdLJnt2lvOPxXI6XiYaHl1rrEHBUUCZ+P+8L9ck=;
        b=d5r0NsRLsBrz77uyw1LuvfNk9Jz+aL0TjU7fRc4P5jCQZqXZk1gGh8oPLWTIOt1YRs
         5nXM9Tw52pAdPNcG6+8mbs1j8RuEggY5MWLUKrcr5BIK/dJBcHp9EjuKA+TEZV1FATh5
         kMPsOpxeZgXSEMmFRJYub5pLSX5m27nIG6vEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Wjqa1agzrifnyzLwFhWAjpUQ/NgZoVHqK77kiJxSBIPT5aYRDFooM5tUyTeSK5TudQ
         s+56Ih/H+GbrVDI6chO4XUHDJbkGdhHkP48ePQVDaDhZTinP3XAUOsL0SVMaEkCrzIL/
         8IuKiH7Q/GelXmpwBh6+5VxcvoawQSmr1CMbo=
Received: by 10.114.187.7 with SMTP id k7mr2248135waf.106.1259347671828;
        Fri, 27 Nov 2009 10:47:51 -0800 (PST)
Received: from ?192.168.0.8? (cpe-76-90-12-237.socal.res.rr.com [76.90.12.237])
        by mx.google.com with ESMTPS id 21sm1337972pzk.15.2009.11.27.10.47.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 10:47:51 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vk4xbn7nl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133924>

Junio C Hamano wrote:
> You preach to the choir.
> 
> That is exactly how we work and what people have been working hard for
> 1.7.0.  Check the planned changes listed in the recent (and not so recent)
> "What's cooking" summary reports.

Yes, I guess my only point here was that maybe even 1.7 is not enough of
a "Big Deal" (in the eyes of the public) to warrant breaking scripts. A
2.0 version would be a more visible way to say "Hey test your scripts
before upgrading". Adopting a strategy like that would mean making
backwards incompatible changes a lot let frequently, but when we do we
go for broke.

> Changing "grep" is too late for 1.7.0, but we are trying to find an easy
> migration path like you mentioned in your message and that is exactly what
> this thread is about.

I wasn't actually suggesting we change grep for 1.7. As a matter of
fact, my personal opinion (which I probably neglected to mention) is
that grep default behavior should stay the same since it is semantically
closer to unix (or gnu) grep.

-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
