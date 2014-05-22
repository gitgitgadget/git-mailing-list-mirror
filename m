From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset
 parameter
Date: Thu, 22 May 2014 11:19:57 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1405221118150.10958@ds9.cixit.se>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521103301.GG30464@sigill.intra.peff.net> <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com> <alpine.DEB.2.00.1405220809370.10958@ds9.cixit.se> <20140522090557.GB29669@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 12:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnQ6k-0004Sv-RL
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 12:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbaEVKUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 06:20:12 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:56842 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752056AbaEVKUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 06:20:11 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s4MAJwA1019813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 May 2014 12:19:58 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s4MAJvCq019810;
	Thu, 22 May 2014 12:19:57 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20140522090557.GB29669@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 22 May 2014 12:19:58 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249898>

Jeff King:

> I was really hoping to avoid getting into all of the real-world
> messiness that a real http client needs to deal with (as opposed to just
> following the standards).

Yeah, I agree, you're probably fine without all this detail in over 
99% of the cases where this code would ever be exposed. I'm a bit 
damaged after 10+ years as a web browser developer, responsible for 
exactly this kind of stuff... :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
