From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Tue, 25 Sep 2007 12:46:52 +0200
Message-ID: <46F8E71C.1070409@qumranet.com>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>	<7vhcllc9bz.fsf@gitster.siamese.dyndns.org>	<85ps08k2fj.fsf@lola.goethe.zz> <86bqbsta3g.fsf@lola.quinscape.zz>	<7vodfr8wts.fsf@gitster.siamese.dyndns.org>	<85hcljgtlr.fsf@lola.goethe.zz> <7v4phj6yxb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7oO-0002vY-A6
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXIYKid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXIYKid
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:38:33 -0400
Received: from il.qumranet.com ([82.166.9.18]:38716 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbXIYKid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:38:33 -0400
Received: from firebolt.argo.co.il (unknown [10.64.7.6])
	by il.qumranet.com (Postfix) with ESMTP id 1002325028F;
	Tue, 25 Sep 2007 12:38:40 +0200 (IST)
Received: from firebolt.argo.co.il (localhost.localdomain [127.0.0.1])
	by firebolt.argo.co.il (Postfix) with ESMTP id 995AEC01F1;
	Tue, 25 Sep 2007 12:46:52 +0200 (IST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7v4phj6yxb.fsf@gitster.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (firebolt.argo.co.il [0.0.0.0]); Tue, 25 Sep 2007 12:46:52 +0200 (IST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59110>

Junio C Hamano wrote:
> David Kastrup <dak@gnu.org> writes:
>
>   
>> As a completely irrelevant side note: the autoconf documentation
>> mentions that "false" is more portable than "true" since calling it
>> returns a non-zero exit status even when it is not installed or
>> built-in.
>>     
>
> Ah, I like that ;-)  It is obvious when you think about it, and
> it is so true but in a very twisted way...
>
>   

You mean, it is not false but in a twisted way, don't you?


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
