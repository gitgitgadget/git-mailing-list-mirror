From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Thu, 8 Apr 2010 00:03:24 -0500
Message-ID: <20100408050323.GA5987@progeny.tock>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 <20100407224942.GA20239@progeny.tock>
 <7vzl1eamss.fsf@alter.siamese.dyndns.org>
 <x2of3271551004072154r62d10023r32e74064d38aff75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzjtp-0003xD-8v
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab0DHFDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 01:03:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:25560 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab0DHFDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 01:03:19 -0400
Received: by qw-out-2122.google.com with SMTP id 8so665573qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 22:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cQAMHLOi+7fQxiuFTrnG8uYDvUfLDTpLLucEkqsdL54=;
        b=qXOn89PIlf7TXkHnaXoqXc/fN0OhwWfs90Ymo6tLdu75RAK1/YWxtHrxg0rbmrnd5N
         x2EYzVBMoOHqpA59o3SiumzhunVb+gVkcS0evwFVddoVUgDs6cdZMmeDKmE1ESQ6Nsb2
         xU0VBDsSjj4IW8P4+YuMSoE2aPa3acTRit7w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nfgEFXWYs+Z0lLeHJjLxjMzrbvQHB9PWpXUSagdYdqbfVnyCKt6cRZZ5NX2sUFKoQV
         Y4uygoBWpRCossSeS8MRWQF4fCxccOPujVedg0VgFLpM23uXVuzRgBd+SpC9914turPF
         jsN+bo1bG4JDD+Z2JKUzd/zAwOXQwMNjbuNzQ=
Received: by 10.229.242.85 with SMTP id lh21mr117306qcb.67.1270702998297;
        Wed, 07 Apr 2010 22:03:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4079481iwn.11.2010.04.07.22.03.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 22:03:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <x2of3271551004072154r62d10023r32e74064d38aff75@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144314>

Ramkumar Ramachandra wrote:

> Can I see the topic branch corresponding to my patches? If this is
> possible, I can avoid the more painful procedure of extracting it from
> the latest pu using git-resurrect.sh.

I tend to do the extraction by hand:

 1. git log --first-parent origin/pu
 2. Search for "rr/".
 3. git branch -f rr/whatever <relevant sha1>

Maybe it would be nice to have a script that does just that instead of
the more costly "git resurrect -m rr/whatever".

Cheers,
Jonathan
