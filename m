From: Michael Weiser <m.weiser@science-computing.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Fri, 4 Oct 2013 15:32:18 +0200
Message-ID: <20131004133217.GA85032@science-computing.de>
References: <20121127163004.GC7499@science-computing.de>
 <20130305115837.GD21473@science-computing.de>
 <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
 <20130306081942.GA11151@science-computing.de>
 <CABPQNSbd_baEe7pstZPSdNQQCAUMBCgV2FGcszy-8zoeuD+M5w@mail.gmail.com>
 <20130417060647.GA66718@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 04 15:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS5e8-00082m-7z
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 15:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab3JDNmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 09:42:16 -0400
Received: from mx4.science-computing.de ([193.197.16.30]:61292 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3JDNmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Oct 2013 09:42:15 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2013 09:42:15 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 67304414007;
	Fri,  4 Oct 2013 15:32:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kk3RlmolD3u2; Fri,  4 Oct 2013 15:32:21 +0200 (CEST)
Received: from science-computing.de (dhcphag71-144.science-computing.de [10.10.11.144])
	by scmail.science-computing.de (Postfix) with ESMTPS id 9AA69414002;
	Fri,  4 Oct 2013 15:32:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130417060647.GA66718@science-computing.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235710>

Hi,

On Wed, Apr 17, 2013 at 08:06:47AM +0200, Michael Weiser wrote:

> > >> >> Support determining the binaries' installation path at runtime even if
> > >> >> called without any path components (i.e. via search path).

> > What's the reason you want it on other platforms?

> It's part of an in-house development toolchain featuring git that I want
> to hand to users as a binary installation for a number of platforms but
> give them the choice where to install it.

I'd still like to have this included in mainline git. What can I do to
get it there?

Thanks,
-- 
Michael Weiser                science + computing ag
Senior Systems Engineer       Geschaeftsstelle Duesseldorf
                              Martinstrasse 47-55, Haus A
phone: +49 211 302 708 32     D-40223 Duesseldorf
fax:   +49 211 302 708 50     www.science-computing.de
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Michael Heinrichs, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
