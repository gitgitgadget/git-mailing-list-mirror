From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 13:49:00 -0800
Message-ID: <7vk5m6by9f.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<m3tzlbl6he.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Imran M Yousuf" <imyousuf@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFz6F-0004mX-Id
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 22:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766006AbYARVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 16:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765943AbYARVtK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 16:49:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765826AbYARVtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 16:49:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4556B4F51;
	Fri, 18 Jan 2008 16:49:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB224F4F;
	Fri, 18 Jan 2008 16:49:02 -0500 (EST)
In-Reply-To: <m3tzlbl6he.fsf@roke.D-201> (Jakub Narebski's message of "Fri, 18
	Jan 2008 03:26:50 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71068>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Here is an update to the list I sent earlier.  Topics that I
>> thought may deserve attention, discussion and eventual inclusion
>> but are not 1.5.4 material.
>> 
>> I think some of them actually have a slight chance of being
>> 1.5.4 material, if interested parties present good enough
>> arguments that they are actually good and safe bugfixes.
>  
>>  * submodule subcommand parser fix for "git submodule add init
>>    update" (Imran M Yousuf and me)
>
> Isn't it a bugfix, and shouldn't it for this reason be in 1.5.4?

Yeah, I tend to agree.  I was waiting for an Ack or failure
report from Imran, as I turned the table around.
