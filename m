From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 6 Dec 2012 00:37:01 +0100 (CET)
Message-ID: <2439538.19317881.1354750621740.JavaMail.root@dewire.com>
References: <CAJDDKr6n2KSZz5zPHeWiYHAP7Zr02Ti-e24AX1yR_XAXAKhscg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, esr@thyrsus.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:45:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgOeO-0002Oa-DK
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 00:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab2LEXo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 18:44:56 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:38525 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2LEXoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 18:44:55 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2012 18:44:55 EST
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 9510B825B1;
	Thu,  6 Dec 2012 00:37:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tWSZ+yuUPpmH; Thu,  6 Dec 2012 00:37:01 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id C3B8C824FA;
	Thu,  6 Dec 2012 00:37:01 +0100 (CET)
In-Reply-To: <CAJDDKr6n2KSZz5zPHeWiYHAP7Zr02Ti-e24AX1yR_XAXAKhscg@mail.gmail.com>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211146>



----- Ursprungligt meddelande -----
> On Tue, Nov 27, 2012 at 11:58 PM, Eric S. Raymond <esr@thyrsus.com>
> wrote:
> > Junio C Hamano <gitster@pobox.com>:
> >> Roundtrip conversions may benefit from sub-second timestamps, but
> >> personally I think negative timestamps are more interesting and of
> >> practical use.
> >
> > You mean, as in times before the Unix epoch 1970-01-01T00:00:00Z?
> >
> > Interesting.  I hadn't thought of that.  I've never seen a software
> > project under version control with bits that old, which is
> > significant
> > because I've probably done more digging into ancient software than
> > anybody other than a specialist historian or two.
> 
> One example I've heard is someone wanting to throw the history
> of a country's laws into git so they can diff them.

Not sure any laws were passed on Feb 30th 1712 in sweden, but perhaps
you can define new time zones to handle that, but I doubt it is practically
doable when you get to countries and regions with less precise boundaries.

Seconds-since as a representation for dates is a dangerous and very
messy game. Java gets it wrong somewhere in 1910 and my guess is others
get it wrong too. There is change in time zones which triggers the bug.

-- robin
