From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Mon, 15 Jul 2013 22:27:01 +0200
Message-ID: <51E45B15.7070404@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org> <51E1B5DB.9080904@kdbg.org> <7v61wdgdd1.fsf@alter.siamese.dyndns.org> <51E3084D.2040504@kdbg.org> <7vd2qkfpm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 22:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UypMm-0005Uo-0A
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 22:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab3GOU1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 16:27:08 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:49063 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754342Ab3GOU1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 16:27:07 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1DD03A7EB0;
	Mon, 15 Jul 2013 22:27:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2D04619F61C;
	Mon, 15 Jul 2013 22:27:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vd2qkfpm8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230520>

Am 15.07.2013 05:50, schrieb Junio C Hamano:
>         ... or also with your "--lockref is default"
> 	$ git push origin +master
> 
> 	... rejected due to stale expectation
>         $ git fetch
> 
> You just have updated the lockref base, so if you did, without doing
> anything else, 
> 
> 	$ git push origin +master
> 
> then you will lose the updated contents.
> 
> The conclusion?  It does not make sense to make "lockref" the
> default.

Point taken.

> So it will not happen; "lockref" will not be on by default, even if
> it is made independent of "must fast-forward".

OK.

-- Hannes
