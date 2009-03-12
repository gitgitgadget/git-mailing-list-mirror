From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: [PATCH 1/2] Add a test for checking whether gitattributes is honored by checkout.
Date: Thu, 12 Mar 2009 10:53:05 +0100
Message-ID: <49B8DB81.7020100@nokia.com>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: ext Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhhcg-0001G1-7u
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbZCLJxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbZCLJxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:53:09 -0400
Received: from hoat.troll.no ([62.70.27.150]:45737 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbZCLJxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 05:53:08 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 436842110F;
	Thu, 12 Mar 2009 10:53:06 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 3CBEF2110A;
	Thu, 12 Mar 2009 10:53:06 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2C9r6Zr002510;
	Thu, 12 Mar 2009 10:53:06 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Thu, 12 Mar 2009 10:53:05 +0100 (CET)
In-Reply-To: <vpqr613jcoa.fsf@bauges.imag.fr>
References: <1236850575-27973-1-git-send-email-kristian.amlie@nokia.com>
References: <1236850575-27973-2-git-send-email-kristian.amlie@nokia.com>
References: <vpqr613jcoa.fsf@bauges.imag.fr>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.19 (X11/20090122)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113033>

ext Matthieu Moy wrote:
> Kristian Amlie <kristian.amlie@nokia.com> writes:
> 
>> +test_expect_success 'setup' '
> 
> If you have two separate patches for test and bugfix, you probably
> want the first to introduce test_expect_failure, and the second to
> change it to test_expect_success. This way: 1) the test-suite passes
> for all commits (and git-bisect will be your friend again), and 2) the
> second patch is self-explanatory about the bug it fixes.

Good point. I'll fix that in my next batch.

--
Kristian
