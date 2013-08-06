From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] commit: reject non-characters
Date: Tue, 6 Aug 2013 08:03:51 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1308060802570.9867@ds9.cixit.se>
References: <cover.1372957719.git.sandals@crustytoothpaste.net> <20130704171943.GA267700@vauxhall.crustytoothpaste.net> <alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se> <7vfvvozvx4.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1307091213090.2313@ds9.cixit.se>
 <alpine.DEB.2.00.1308051346530.3657@ds9.cixit.se> <7vpptskrhd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 09:04:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6bJT-0004yB-Nj
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 09:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab3HFHEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 03:04:06 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:33463 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754607Ab3HFHEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 03:04:05 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r7673qs5010764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Aug 2013 09:03:52 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r7673pq2010749;
	Tue, 6 Aug 2013 09:03:51 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vpptskrhd.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 06 Aug 2013 09:03:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231730>

Junio C Hamano:

> Indeed.

Thanks. Testcases are good, but not if they don't actually catch the 
bug one has just introduced :-)

> -- >8 --
> Subject: [PATCH] commit: typofix for xxFFF[EF] check
>
> We wanted to catch all codepoints that ends with FFFE and FFFF,
> not with 0FFFE and 0FFFF.
>
> Noticed and corrected by Peter Krefting.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>

-- 
\\// Peter - http://www.softwolves.pp.se/
