From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy
 authentication
Date: Fri, 30 Oct 2015 19:24:27 +0100
Message-ID: <20151030182426.GA16389@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446025245-10128-1-git-send-email-k.franke@science-computing.de>
 <1446025245-10128-3-git-send-email-k.franke@science-computing.de>
 <CAPig+cRK-EPpH4dUMpYBcjR22Wqw4RnNTYeBvw-M7h=CTFGviQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:34:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEVP-00046T-P0
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760567AbbJ3SeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:34:22 -0400
Received: from mx1.science-computing.de ([217.243.222.155]:65035 "EHLO
	mx1.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbJ3SeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:34:21 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2015 14:34:20 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id DF56A3A91;
	Fri, 30 Oct 2015 19:24:27 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_XDbiiEBpZu; Fri, 30 Oct 2015 19:24:27 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 653993844;
	Fri, 30 Oct 2015 19:24:27 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 51112A7966; Fri, 30 Oct 2015 19:24:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPig+cRK-EPpH4dUMpYBcjR22Wqw4RnNTYeBvw-M7h=CTFGviQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280515>

On 2015-10-28 14:58, Eric Sunshine wrote:
> > +               }
> > +               if (!curl_http_proxy) {
> > +                       copy_from_env(&curl_http_proxy, "ALL_PROXY");
> > +                       copy_from_env(&curl_http_proxy, "all_proxy");
> > +               }
> 
> If this sort of upper- and lowercase environment variable name
> checking is indeed desirable, I wonder if it would make sense to fold
> that functionality into the helper function.

It's just for consistency with libcurl here, not generally desirable; so I don't
think it makes sense to add it to the helper.

Otherwise, will fix. Thanks.


Cheers,
Knut
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
