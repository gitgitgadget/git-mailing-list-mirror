From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC - draft #2] List of proposed future changes that are backward incompatible
Date: Mon, 16 Feb 2009 13:10:47 -0800 (PST)
Message-ID: <m363jat7fc.fsf@localhost.localdomain>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<7vskmff6fp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:12:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZAlM-0004OD-1a
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbZBPVKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbZBPVKv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:10:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:57379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZBPVKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:10:50 -0500
Received: by fg-out-1718.google.com with SMTP id 16so307285fgg.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NGVTzNkNj9LtIxUKSONJ+gByVdgI2Ah6HhXxA15x9qY=;
        b=Dk33jta3efkr0NHyN72KCuJsietU8Ybt2SH2MELxXWpIqhVGepJ+3eQs/iWwQQsViy
         Dg8KL+jB4bAgzPKiG+2GM3GhCkLiCezKMQi9rNi2d8GWJXZ4eIojB3INn3WOJdu8GeZk
         pifqNzTvCZdVpj3EsrgX/L6qFM41Otvi7PcIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KbhvBs10bkdMx0Ajx4ZRgwtH6S+8G0jhWwe1aITDEc1/zTfZsXfncblF7n+/jCM12x
         cdNXXFLvnAUcdQxBSa7ECQ/h8aFTLWLbXZ6ys4mevTHvyF2NJ8/J2Gf0G3QMwD7LzESJ
         /SRxBQgqhB+Tp+GOrElaUjGCZFcIZBaOe8rKg=
Received: by 10.86.60.14 with SMTP id i14mr1671896fga.70.1234818648512;
        Mon, 16 Feb 2009 13:10:48 -0800 (PST)
Received: from localhost.localdomain (abwe74.neoplus.adsl.tpnet.pl [83.8.228.74])
        by mx.google.com with ESMTPS id d4sm7460609fga.48.2009.02.16.13.10.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 13:10:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1GLAFNZ005864;
	Mon, 16 Feb 2009 22:10:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1GL9xqt005857;
	Mon, 16 Feb 2009 22:09:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vskmff6fp.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110241>

Junio C Hamano <gitster@pobox.com> writes:

> Here is a draft of a message I am preparing to send out around 1.6.2-rc2
> is tagged to this mailing list, and mailing list of the projects that use
> git to track their changes, to announce possible future changes that may
> affect the users in a backward incompatible way, and solicit comments.

>  - If your favourite project that uses git is not listed in:
> 
>    http://git.or.cz/gitwiki/ProjectContacts
> 
>    or it does not have "Forwarder" field filled in, please add the project
>    with an appropriate address for the message to be sent.
> 
>    Be careful NOT to list a mailing list address that non-subscribers
>    cannot send messages to.  For such mailing lists, we need to find a
>    subscribed volunteer to forward it.  If you are volunteering, great.

First, I have send announcements about Git User's Survey 2007 and 2008
to mailing list of various projects using git. I can find which didn't
bounced back with 'waiting for moderation', or 'subscribe only' and
provide you (on private or here on git mailing list) with the list of
addresses of mailing list which at least seem public.

Second, you can ask major git hosting sites: repo.or.cz, gitorious and
GitHub (and perhaps also Ohloh software metric site) to announce this
information about future incompatibilities somewhere public on the
site, or alternatively either in news section of a site, or in blog
(or announcements section) if there is any.


P.S. Hmmm... you can try asking on Stackoverflow how to announce and
propagate backward incompatibile changes for packaged OSS project,
like git :-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
