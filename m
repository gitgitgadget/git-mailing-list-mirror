From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Tue, 25 Aug 2009 19:52:16 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908251950010.19406@ds9.cixit.se>
References: <20090823203640.B195D189B12@perkele> <4A91B8BB.1030906@vilain.net> <alpine.DEB.2.00.0908241659380.16576@perkele.intern.softwolves.pp.se> <7vab1pf3fj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg195-0007k0-5T
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 20:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbZHYSwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 14:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbZHYSwZ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 14:52:25 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:37960 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755715AbZHYSwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 14:52:23 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7PIqGdt019783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Aug 2009 20:52:16 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7PIqG0W019779;
	Tue, 25 Aug 2009 20:52:16 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vab1pf3fj.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 25 Aug 2009 20:52:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127040>

Junio C Hamano:

> Unlike your "import-directories" that is a brand new program without any 
> existing users, you are touching code that other people have already used, 
> and you do not want to change the behaviour for them only because they 
> happen to have unrelated files in the same directory.

Indeed. Not that it is likely that one have stray filetar.gz.msg files just 
laying around, but I'll add a command line switch to enable the new 
functinality. That sounds like the most reasonable way to go, leaving the 
old usage completely unaffected by the change.

-- 
\\// Peter - http://www.softwolves.pp.se/
