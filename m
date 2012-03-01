From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 3/4] t5510: ensure we stay in the toplevel test dir
Date: Thu, 1 Mar 2012 23:09:26 +0100
Message-ID: <871upcht2h.fsf@thomas.inf.ethz.ch>
References: <cover.1330637923.git.trast@student.ethz.ch>
	<80204781996b200d08b73cf61fa50df468e4b51d.1330637923.git.trast@student.ethz.ch>
	<7vipiokmrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:09:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3EBs-0008KH-8f
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 23:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058Ab2CAWJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 17:09:30 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:25641 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758025Ab2CAWJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 17:09:29 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 23:09:25 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 23:09:26 +0100
In-Reply-To: <7vipiokmrz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 01 Mar 2012 13:57:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191982>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The last test descended into a subdir without ever re-emerging, which
>> is not so nice to the next test writer.
>
> True.  Making the test suite more robust like this patch does is very much
> appreciated.
>
> Is there a reason why we shouldn't be sticking to the more usual
>
> 	mkdir dups &&
>         (
>         	cd dups &&
>                 do whatever in dups
> 	)
>
> pattern?

None in particular.  It would also perhaps reduce the churn since (as it
touches every line anyway) it could be squashed with 2/4.  Should I reroll?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
