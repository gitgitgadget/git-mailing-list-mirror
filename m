From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 13:50:56 -0400
Message-ID: <6F09BF8D-BD4B-4A33-951C-7707A270803B@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <vpqej8pnaru.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 28 19:52:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXWA-0007MH-9K
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbYD1RvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934342AbYD1RvA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:51:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:32893 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934275AbYD1Ru7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 13:50:59 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 701551FFD6C5;
	Mon, 28 Apr 2008 17:50:52 +0000 (UTC)
In-Reply-To: <vpqej8pnaru.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80571>


On Apr 28, 2008, at 1:34 PM, Matthieu Moy wrote:

> J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>
>> And what about something like this: 'tac || rev || perl =85'
>
> Be careful: rev and tac are different. tac reverses lines, while rev
> reverses chars inside lines.

Indeed you are correct.  This is a mistake I made in my original =20
email, which people have been parroting.  My mistake, sorry.

~~ Brian