From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 08 Jun 2011 10:25:27 -0700 (PDT)
Message-ID: <m3hb80dynr.fsf@localhost.localdomain>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<7vvcwh4ako.fsf@alter.siamese.dyndns.org>
	<20110607214532.GB7663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:28:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMYF-00021T-Vg
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab1FHRZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:25:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40529 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1FHRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:25:29 -0400
Received: by fxm17 with SMTP id 17so473491fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=3mQhn1B8u+fHx7rOI8g/GfXMdZ80D9zaccPPQooQi1k=;
        b=QNZCuvS+JtslL2zfGRz7IYEcarYchAJvdqVnxyZUwVQKSCuBzpvJs/ThIgruMKpM0B
         stHi9tv6IPSYoIfc5yzE2tgjVobu8gAmFTrGULXhbnaSiI+GTeXW29NJHzJii8NqQtGM
         XQbksp+tyaMFsmB1yWCv8v/BdCdEE0fY2JzMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=p0+SqvoRyyeU5J4/+6jOY0qpNRhaPhv3gO9/L5NnBZPsbQ2t8/QYI5diBerklrt06V
         2y8blZ5xeJstPxQTyHW/u13NumIYIIqybXl8zIJbcTlw+BKy9nFnD1cf7cd81k7Rq2dP
         oESFt9Rs2GfqZaHVP6KOUHOiTzt7HCVr13RXE=
Received: by 10.223.4.136 with SMTP id 8mr584273far.16.1307553928125;
        Wed, 08 Jun 2011 10:25:28 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id y14sm324323fah.13.2011.06.08.10.25.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:25:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p58HOjf5020295;
	Wed, 8 Jun 2011 19:24:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p58HOOuL020284;
	Wed, 8 Jun 2011 19:24:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110607214532.GB7663@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175407>

Jeff King <peff@peff.net> writes:

> I find the all-caps ugly, and it is part of what confuses them with
> HEAD. At the same time, we are using the same namespace that ref lookup
> uses. So calling it "worktree" might be too ambiguous. I tried to avoid
> using "--worktree" because I wanted to make it clear that these were
> ordered arguments, not options.

Perhaps we can use some character that is forbidden in ref names,
doesn't make trouble when doing allowed operations on said refs, won't
confuse user, and is not trouble with shell... ehhh...

* @{wtree} would confuse users that it has something to do with reflog
* [tree]   would be trouble with some shells
* ~tree~   looks a bit strange, might be trouble with username expansion  
* :tree:   might be mistaken for 'tree:' in index

-- 
Jakub Narebski
Poland
ShadeHawk on #git
