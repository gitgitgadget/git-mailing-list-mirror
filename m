From: Michael Weiser <M.Weiser@science-computing.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Wed, 6 Mar 2013 09:19:43 +0100
Message-ID: <20130306081942.GA11151@science-computing.de>
References: <20121127163004.GC7499@science-computing.de>
 <20130305115837.GD21473@science-computing.de>
 <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 09:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD9kP-0004eA-39
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 09:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab3CFIaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 03:30:23 -0500
Received: from mx3.science-computing.de ([193.197.16.20]:11517 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab3CFIaX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 03:30:23 -0500
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2013 03:30:22 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id E128841405B;
	Wed,  6 Mar 2013 09:19:43 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 723OJcRWAUm7; Wed,  6 Mar 2013 09:19:43 +0100 (CET)
Received: from verus.science-computing.de (verus.science-computing.de [10.160.1.22])
	by scmail.science-computing.de (Postfix) with ESMTP id 3CE55414002;
	Wed,  6 Mar 2013 09:19:43 +0100 (CET)
Received: by verus.science-computing.de (Postfix, from userid 1176)
	id 196EF1044B4; Wed,  6 Mar 2013 09:19:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217505>

Hello Junio,

On Tue, Mar 05, 2013 at 08:13:50AM -0800, Junio C Hamano wrote:

> >> Support determining the binaries' installation path at runtime even if
> >> called without any path components (i.e. via search path).

> The default for any change is not to include it.  Is there any
> reason why we want this change?

It makes a binary git installation fully relocatable. Seeing how git
already has basic support for it I thought other people might be
interested in this.

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
