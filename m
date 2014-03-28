From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be
 sha1 based
Date: Fri, 28 Mar 2014 18:46:35 +0100
Message-ID: <5335B57B.4080606@kdbg.org>
References: <cover.1393257006.git.kirr@mns.spb.ru>	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>	<20140325092215.GB3777@mini.zxlink>	<xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>	<20140326195201.GB16002@mini.zxlink>	<xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>	<20140327142438.GE17333@mini.zxlink>	<xmqq1txneavo.fsf@gitster.dls.corp.google.com>	<53351C1B.6040609@viscovery.net> <xmqq4n2ickx4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, kirr@mns.spb.ru,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTarh-0006ek-3C
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbaC1Rqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:46:42 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:55653 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753249AbaC1Rqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:46:40 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1F447130053;
	Fri, 28 Mar 2014 18:46:36 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 200EB19F409;
	Fri, 28 Mar 2014 18:46:35 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqq4n2ickx4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245404>

Am 28.03.2014 18:06, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Am 3/27/2014 19:48, schrieb Junio C Hamano:
>>>> From: Kirill Smelkov <kirr@mns.spb.ru>
>>>> Date: Mon, 24 Feb 2014 20:21:46 +0400
>>>> ...
>>>
>>> By the way, in general I do not appreciate people lying on the Date:
>>> with an in-body header in their patches, either in the original or
>>> in rerolls.
>>
>> format-patch is not very cooperative in this aspect. When I prepare a
>> patch series with format-patch, I find myself editing out the Date: line
>> from all patches it produces again and again. :-(
> 
> I am not sure what you mean.  If you are pasting the format-patch
> output into an editor your MUA is using to receive the body of the
> message from you, you would remove all the non-body lines, not just
> Date: but Subject: and From:, no?

Correct. So I should add that my gripe is about when I want to send a
patch series with git-send-email that was prepared with git-format-patch.

-- Hannes
