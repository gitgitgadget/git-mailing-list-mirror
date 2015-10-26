From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] Remove unused #include "sigchain.h"
Date: Mon, 26 Oct 2015 21:59:14 +0100
Message-ID: <562E9422.5080708@alum.mit.edu>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Tobias Klauser <tklauser@distanz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 22:00:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqos7-0001Zf-CY
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbbJZU7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:59:32 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45655 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458AbbJZU7b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 16:59:31 -0400
X-AuditID: 1207440d-f79136d00000402c-b1-562e94250beb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CC.39.16428.5249E265; Mon, 26 Oct 2015 16:59:17 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB06FB.dip0.t-ipconnect.de [93.219.6.251])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9QKxE2R018618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 26 Oct 2015 16:59:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqKs6RS/M4EUvl0XXlW4mi4beK8wW
	Bw78ZXRg9rhy6jS7x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGccvHmPsWAra8WJb6sYGxjX
	s3QxcnBICJhI3Pga18XICWSKSVy4t56ti5GLQ0jgMqPErx/vmCCcc0wSUxftZwGp4hXQlniw
	s48VxGYRUJXoPLCKCcRmE9CVWNTTDGaLCgRJrFj+ghGiXlDi5MwnYL0iAlkSnZ9usYEsFhaw
	kbg8mw0kLCTgLLHw/1NmEJtTwEVi2/Yr7CA2s4CexI7rv1ghbHmJ7W/nME9g5J+FZOosJGWz
	kJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRESoLw7GP+vkznEKMDB
	qMTDa1ChFybEmlhWXJl7iFGSg0lJlDe/DyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPfyRKAc
	b0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC98EkoEbBotT01Iq0zJwS
	hDQTByfIcC4pkeLUvJTUosTSkox4UDzGFwMjEiTFA7T3Jkg7b3FBYi5QFKL1FKMxx7q5N9Yy
	cSz4cXstkxBLXn5eqpQ470yQUgGQ0ozSPLhFsNT0ilEc6G9h3mkgVTzAtAY37xXQKiagVe5X
	dEFWlSQipKQaGBc8fN6lIJXCa2Xv29t+eu0DMSOlg4y/asuDmVVapjpdmPX82/uk+/KKC9s9
	ea5GB+4Pf2z1Vfz/pYN/erl91h93WRb7Jvdxx5FLOVaWq4PfTt29YUW0mHvqp5WP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280224>

On 10/22/2015 02:43 PM, Tobias Klauser wrote:
> This series removes the #include of sigchain.h from several modules
> after they were changed to use the tempfile module and they thus no
> longer use any declarations from sigchain.h
> 
> Tobias Klauser (5):
>   gc: remove unused #include "sigchain.h"
>   credential-cache--daemon: remove unused #include "sigchain.h"
>   diff: remove unused #include "sigchain.h"
>   read-cache: remove unused #include "sigchain.h"
>   shallow: remove unused #include "sigchain.h"

Thanks for cleaning these up, Tobias. I totally forgot to look for
includes that were no longer needed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
