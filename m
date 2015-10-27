From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Tue, 27 Oct 2015 09:47:43 +0100
Message-ID: <20151027084742.GA6492@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <xmqqk2q9fjyx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 09:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr05A-0002Th-7o
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 09:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbbJ0I6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 04:58:10 -0400
Received: from mx4.science-computing.de ([193.197.16.30]:62704 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbbJ0I6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 04:58:09 -0400
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2015 04:58:08 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 0C78E3B7F;
	Tue, 27 Oct 2015 09:47:44 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tj9N0Wx-pk0P; Tue, 27 Oct 2015 09:47:43 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 8B6DA1D28;
	Tue, 27 Oct 2015 09:47:43 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 6982CA78B1; Tue, 27 Oct 2015 09:47:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqk2q9fjyx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280247>

On 2015-10-26 13:33, Junio C Hamano wrote:
> Call yours "http.proxyAuthmethod" in the documentation, and use
> strcmp("http.proxyauthmethod", var) in the options callback code.
[...]
> Strange indentation here...
[...]
> Along the same line as how we do sslversions[] instead of a long
> if/else if/ chain is preferrable.

Thanks for the feedback, I'll fix these in the next iteration.


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
