From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 5/6] am: Fix launching of pager
Date: Mon, 15 Feb 2010 21:26:43 +0100
Message-ID: <4B79AE03.6050108@kdbg.org>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com> <20100213235156.GA9054@coredump.intra.peff.net> <20100214115430.GA1849@progeny.tock> <20100214120731.GE3499@progeny.tock> <20100215025958.GB17444@progeny.tock> <20100215032533.GA19230@progeny.tock> <20100215044223.GA3336@coredump.intra.peff.net> <20100215050413.GA19586@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh7X2-0006wY-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 21:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456Ab0BOU0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 15:26:55 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:18781 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756202Ab0BOU0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 15:26:54 -0500
Received: from [77.119.192.246] (77.119.192.246.wireless.dyn.drei.com [77.119.192.246])
	by bsmtp.bon.at (Postfix) with ESMTP id 2E04F2C400C;
	Mon, 15 Feb 2010 21:26:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100215050413.GA19586@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140027>

Jonathan Nieder schrieb:
> tty is portable, but "test -t 1" is cleaner.

tty is not portable enough: we don't have it on Windows. test -t 1 is fine.

Thanks.

-- Hannes
