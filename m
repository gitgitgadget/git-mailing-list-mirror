From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 22:21:33 +0200
Message-ID: <51E3084D.2040504@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org> <51E1B5DB.9080904@kdbg.org> <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 22:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UySnf-0006mg-5v
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 22:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3GNUVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 16:21:39 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:11229 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753176Ab3GNUVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 16:21:39 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2BE19CDF87;
	Sun, 14 Jul 2013 22:21:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BF70E19F61B;
	Sun, 14 Jul 2013 22:21:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230388>

Am 14.07.2013 21:17, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> I actually think that by implying allow-no-ff in --lockref, you are
>> hurting users who have configured a push refspec without a + prefix:
>> They suddenly do not get the push denied when it is not a fast-forward
>> anymore.
> 
> Of course, that is why you should not use --lockref when you do not
> have to.  It is a tool to loosen "must fast-forward" in a more
> controlled way than the traditional "--force".

Sorry, IMO, this goes into a totally wrong direction, in particular, I
think that this is going to close to door to make --lockref the default
some day in a way that helps everyone.

I think I have not understood your motivations for this feature, and I
am not able spend more mindwidth on arguing back and forth to make it
more usable (again: IMO).

So, I bow out, and I appologize to have wasted so much of your time.

-- Hannes
