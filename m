From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Wed, 17 Jun 2015 10:01:04 +0200 (CEST)
Message-ID: <575469420.568311.1434528064283.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr> <1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr> <835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqoakh74fw.fsf@anie.imag.fr> <183774662.562924.1434489533064.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpq1tha4xxq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 09:59:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58GD-0005ou-35
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 09:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbbFQH7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 03:59:44 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40944 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754694AbbFQH7n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 03:59:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0088F291E;
	Wed, 17 Jun 2015 09:59:41 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6wpZrDWS5Gjy; Wed, 17 Jun 2015 09:59:40 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E1C9A28B3;
	Wed, 17 Jun 2015 09:59:40 +0200 (CEST)
In-Reply-To: <vpq1tha4xxq.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: FlzYqg77yV+obNfPs4AmdpRvvje8Fw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271813>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes: 

>> 
>>># terms_defined is 0 when the user did not define the terms explicitely 
>>># yet. This is the case when running 'git bisect start bad_rev good_rev' 
>>># before we see an explicit reference to a term. 
>>>terms_defined=0 
>> 
>> The thing is: 
>> 'git bisect reset 
>> git bisect new HEAD 

>"git bisect new" does not exist. Did you mean "git bisect start HEAD"? 

No I meant new but it can be 'git bisect bad' aswell
So 
'
git bisect reset
git bisect bad
answer yes to "autostart ?"
'

>I don't understand. The user didn't say either "bad" or "good", so in 
>both cases we haven't seen a term yet. Or I misunderstood what you meant 
>by "define a term". 

In the case I rewrited, we saw a 'bad' but terms_defined value in bisect_start
(called by the autostart) is 0. 


Thanks.
