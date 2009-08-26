From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Wed, 26 Aug 2009 10:17:14 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908261016050.30577@ds9.cixit.se>
References: <20090823203640.B195D189B12@perkele> <4A91B8BB.1030906@vilain.net> <alpine.DEB.2.00.0908241659380.16576@perkele.intern.softwolves.pp.se> <7vab1pf3fj.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908251950010.19406@ds9.cixit.se>
 <7v8wh7pumr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgEi7-0000Gn-6B
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbZHZJWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756325AbZHZJWV
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:22:21 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:53911 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756443AbZHZJWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:22:21 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7Q9HEJ9031759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Aug 2009 11:17:14 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7Q9HETZ031756;
	Wed, 26 Aug 2009 11:17:14 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7v8wh7pumr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 26 Aug 2009 11:17:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127080>

Junio C Hamano:

> And the switch could be "--metainfo=<ext>", so that people can choose to 
> use other extensions, e.g. with "--metainfo=info" file.tar.info would be 
> read for descriptions.

That's a good idea. I just made a simple "-m" switch to enable the new code. 
I'll change it into a "--metainfo" and post an updated patch later.

-- 
\\// Peter - http://www.softwolves.pp.se/
