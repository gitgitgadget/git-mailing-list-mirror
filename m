From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntax
Date: Sat, 02 Feb 2008 02:23:19 -0800 (PST)
Message-ID: <m3lk637j3k.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net> <ir185c73.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 11:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLFXR-0005bB-3N
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbYBBKXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbYBBKXX
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:23:23 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:7056 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbYBBKXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:23:22 -0500
Received: by py-out-1112.google.com with SMTP id u52so2134582pyb.10
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=nydYaAvoMqzMdKJ0cEVH3p6wu+sqJ1uzw6sTJbNM4Yc=;
        b=VpRQI5NMzebvkwPwHCPW1afJiM6NGekjQNsAMk9W+KxLja6NbMWP1yCpg/mA8o96MGkdB3JmiFuIKgGNQSA3LrU9OkroK1DViFHmQqTKyko56nUeDQq6Ly2U1SEh7SnkFQ5K74q9yNHAy9vYvwWx3lhFE2fw8OKJhvaWhHcWsU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=hIvS6RNtxRR+gkFmvW2fvtTuY4esSz8bbV3VM3VLKP5bW4WgwGU/InfwDXWz7v+MhW051KdHI05Hq98hcf66+z2LwRMWLQQmnbfLpHcEdW76HLtWAyoN6LqFJVxXYO49vICj9qEvMCGihS6l4+c8TVLUGaqZHmHjFgFSeL6CyDU=
Received: by 10.65.52.1 with SMTP id e1mr7738808qbk.79.1201947801163;
        Sat, 02 Feb 2008 02:23:21 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id 1sm12210351nfv.3.2008.02.02.02.23.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 02:23:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m12ANDGO026523;
	Sat, 2 Feb 2008 11:23:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m12ANCGg026520;
	Sat, 2 Feb 2008 11:23:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <ir185c73.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72243>

Jari Aalto <jari.aalto@cante.net> writes:

I think it would beb better if you split this patch in two,
as it deals with two separate issues, and in one case it doesn't
deal with the issue fully

> Change (list|...) to {list|...} to denote required commands.

This is one thing, and I think when you are resubmitting this patch
for discussion (with Cc: to the authors that introduced the (-a|-b)
syntax) you should change (list|...) to {list|...} *everywhere* in the
git manpages.

> Adjust
> the 'save' command syntax to better reflect the call parameters:
> [save] [message...] => [save [message...]].

This is just simple bugfix in git-stash synopsis, and I think this
patch would be accepted (especially now that it is after 1.5.4
released, and after feature freeze) without doubt.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
