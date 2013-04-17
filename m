From: Michael Weiser <m.weiser@science-computing.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Wed, 17 Apr 2013 08:06:48 +0200
Message-ID: <20130417060647.GA66718@science-computing.de>
References: <20121127163004.GC7499@science-computing.de>
 <20130305115837.GD21473@science-computing.de>
 <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
 <20130306081942.GA11151@science-computing.de>
 <CABPQNSbd_baEe7pstZPSdNQQCAUMBCgV2FGcszy-8zoeuD+M5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 08:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USLkJ-0002Xe-0i
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 08:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965744Ab3DQGV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 02:21:27 -0400
Received: from mx4.science-computing.de ([193.197.16.30]:30096 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab3DQGV0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 02:21:26 -0400
X-Greylist: delayed 873 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2013 02:21:26 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id C81EFAC003;
	Wed, 17 Apr 2013 08:06:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbsoRXIqfOnr; Wed, 17 Apr 2013 08:06:49 +0200 (CEST)
Received: from science-computing.de (dhcphag71-188.science-computing.de [10.10.11.188])
	by scmail.science-computing.de (Postfix) with ESMTPS id 233D4AC002;
	Wed, 17 Apr 2013 08:06:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABPQNSbd_baEe7pstZPSdNQQCAUMBCgV2FGcszy-8zoeuD+M5w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221512>

Hello Erik,

On Tue, Apr 16, 2013 at 05:18:49PM +0200, Erik Faye-Lund wrote:

> >> >> Support determining the binaries' installation path at runtime even if
> >> >> called without any path components (i.e. via search path).
> I think the motivation for the feature in the first place is Windows,
> where the installation path isn't known at build-time. In the
> unix-world, this is generally known (/usr/bin or something like that).
> What's the reason you want it on other platforms?

It's part of an in-house development toolchain featuring git that I want
to hand to users as a binary installation for a number of platforms but
give them the choice where to install it.

Secondly, once the infrastructure is in place, it's easier to do or
enhance relocatability support for other platforms such as Windows.

Finally: Others do it. Perl's done it and I've already needed that as
well - on Mac OS X.

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
