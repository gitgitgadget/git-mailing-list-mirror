From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently
 processed
Date: Fri, 21 Jun 2013 07:34:15 +0200
Message-ID: <51C3E5D7.6040604@viscovery.net>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr> <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se> <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr> <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se> <0b88af05ea8d4723a870476036992abc@ensibm.imag.fr> <51BF26F9.1080900@viscovery.net> <7vvc5cg0i8.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1306200853250.7267@ds9.cixit.se> <51C2B8DA.6040400@viscovery.net> <7vzjukveiz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	=?ISO-8859-1?Q?Mathieu_Li=E9?= =?ISO-8859-1?Q?nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 07:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UptzP-0007Wt-NF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 07:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756Ab3FUFeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 01:34:24 -0400
Received: from so.liwest.at ([212.33.55.13]:58110 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161096Ab3FUFeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 01:34:23 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UptzD-0001OV-TQ; Fri, 21 Jun 2013 07:34:16 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8048A1660F;
	Fri, 21 Jun 2013 07:34:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vzjukveiz.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228576>

Am 6/20/2013 20:11, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> But you can't have this string:
>>
>>   "Splitting a commit while rebasing branch '%2$s' on '%3$s'."
>>
>> neither in the template nor in the translation, because the numbers must
>> begin at 1 (and must be used without gaps).
> 
> Did any message we saw in the patch (and the discussion to possibly
> improve it) need to have such a format string, or are you pointing
> out a common gotcha we may want to warn translators about in
> po/README?

I took the example from Peter's message earlier in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/228062/focus=228064

-- Hannes
