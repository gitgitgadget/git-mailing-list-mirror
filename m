From: Dan Libby <danda@osc.co.cr>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Fri, 21 Sep 2007 14:21:56 -0600
Message-ID: <200709211421.56587.danda@osc.co.cr>
References: <200709161857.06065.danda@osc.co.cr> <7vabrgjyg3.fsf@gitster.siamese.dyndns.org> <20070921102420.GJ11204@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYp0q-0003xG-LD
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 22:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbXIUUWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 16:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbXIUUWA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 16:22:00 -0400
Received: from 207-36-180-175.ptr.primarydns.com ([207.36.180.175]:39919 "EHLO
	mail.osc.co.cr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801AbXIUUWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 16:22:00 -0400
Received: from [192.168.0.11] (unknown [200.122.156.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.osc.co.cr (Postfix) with ESMTP id A413CD0B95;
	Fri, 21 Sep 2007 13:21:58 -0700 (PDT)
User-Agent: KMail/1.9.4
In-Reply-To: <20070921102420.GJ11204@kiste.smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58874>

Hi,

I saw this, so I haven't run the strace command you mentioned.  No need now, 
right?

I'm no expert on these things, but I'd think that it should be replacing (or 
escaping) any characters (not just spaces) that are not allowed by 
git-check-ref-format.

For us, replacing any such characters with _ should work fine.

regards,

On Friday 21 September 2007 04:24, Matthias Urlichs wrote:
> Hi,
>
> Junio C Hamano:
> > Matthias Urlichs <smurf@smurf.noris.de> writes:
> > >> we do not like 'Cristian new code' as a tag name.
> > >
> > > Duh? That's a perfectly valid tag name.
> >
> > Is it?
> >
> > $ man git-check-ref-format
>
> Bah, stupid me. You're right, obviously.
>
> I'll replace them with underscores. :-/

-- 
Dan Libby

Open Source Consulting
San Jose, Costa Rica
http://osc.co.cr
phone: 011 506 223 7382
Fax: 011 506 223 7359
