From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 3 Jun 2016 08:56:47 +0200
Message-ID: <57512A2F.7030100@kdbg.org>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
 <57511B2D.7040501@kdbg.org> <vpqr3ce6afi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 08:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8j2N-0003SP-1h
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 08:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbcFCG4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 02:56:51 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:25145 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcFCG4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 02:56:50 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rLZdX0kgnz5tlQ;
	Fri,  3 Jun 2016 08:56:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 48C5652C2;
	Fri,  3 Jun 2016 08:56:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <vpqr3ce6afi.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296271>

Am 03.06.2016 um 08:41 schrieb Matthieu Moy:
> Rejecting colon anywhere in the line would also reject valid patterns
> like this:
>
> a:hover {
>
> Rejecting it at end of line is probably a good trade-off.

Good point. Could be worth another test case.

-- Hannes
