From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/25] Remove assumptions about each_ref_fn arg lifetimes
Date: Thu, 30 May 2013 21:55:31 +0200
Message-ID: <51A7AEB3.6090309@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu> <8761y2ura8.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 21:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui8wm-0006WE-4u
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 21:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423Ab3E3Tzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 15:55:37 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:64826 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752874Ab3E3Tzf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 15:55:35 -0400
X-AuditID: 12074414-b7fb86d000000905-61-51a7aeb60030
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.E2.02309.6BEA7A15; Thu, 30 May 2013 15:55:34 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A59.dip0.t-ipconnect.de [87.162.74.89])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4UJtWH5024932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 May 2013 15:55:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <8761y2ura8.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqLtt3fJAg3W7TSy6rnQzWTT0XmG2
	mHd3F5PFj5YeZou7l1exO7B6XHr5nc3j9uv5zB7Pevcwely8pOzxeZNcAGsUt01SYklZcGZ6
	nr5dAnfG0hltrAUTmCsurHjP3MB4gKmLkZNDQsBE4sPnkywQtpjEhXvr2boYuTiEBC4zSjSt
	2s8C4Zxjktj59CsrSBWvgLbE78Z3YN0sAqoSDxdOB4uzCehKLOppBouLCoRJvF82FapeUOLk
	zCdAgzg4RASUJbYtrAGZySzQxChx+8JqsBphgQCJxgs3mUFsIYF8ieftTawg9ZwC5hIvv+iB
	hJkFdCTe9T1ghrDlJba/ncM8gVFgFpINs5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJe
	XmqRroVebmaJXmpK6SZGSIiL7GA8clLuEKMAB6MSD29m0vJAIdbEsuLK3EOMkhxMSqK8gauA
	QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4l/YA5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5ak
	ZqemFqQWwWRlODiUJHit1wI1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiNb4Y
	GKsgKR6gvZog7bzFBYm5QFGI1lOMuhwzfkx+xyjEkpeflyolzhsAUiQAUpRRmge3ApbQXjGK
	A30szMsEUsUDTIZwk14BLWECWvLEGmxJSSJCSqqBMdWgeZ6I24Oqc9+Tti3yYTFJ0pCrWDKl
	RnFXo9CKKSf+TjLz/GwYOtGjZHv7qtpPCnpBb39nt2Qrarh1tNUoPv/2YorJrFWB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226033>

On 05/29/2013 10:25 AM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> I read the entire series on Monday, and give it an Ack at maybe 90%
> confidence level -- sorry, I was short on caffeine and sleep ;-)

Thanks very much.  I'll buy you a coffee the next time I see you :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
