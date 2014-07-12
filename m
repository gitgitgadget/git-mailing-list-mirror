From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Sat, 12 Jul 2014 11:11:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1407121110070.18850@ds9.cixit.se>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com> <20140709051040.GB2318@sigill.intra.peff.net> <CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com> <20140709061853.GA6731@sigill.intra.peff.net>
 <alpine.DEB.2.00.1407091142030.22132@ds9.cixit.se> <20140710201034.GB15615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Yi, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 12:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5uHR-0008UM-4k
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 12:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbaGLKLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 06:11:38 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49727 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752216AbaGLKLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 06:11:38 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s6CABJHE019003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jul 2014 12:11:19 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s6CABHvL019000;
	Sat, 12 Jul 2014 12:11:18 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20140710201034.GB15615@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Sat, 12 Jul 2014 12:11:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253387>

Jeff King:

> If that is the case, though, I wonder if we should actually be adding it
> as a git-protocol header so that all transports can benefit (i.e., we
> could be localizing human-readable error messages in upload-pack,
> receive-pack, etc).

That would be very nice, thre is a lot of language mixing going on at 
the moment.

-- 
\\// Peter - http://www.softwolves.pp.se/
