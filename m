From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Wed, 14 Nov 2007 12:13:07 -0800
Message-ID: <7vzlxgfuwc.fsf@gitster.siamese.dyndns.org>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
	<7vir45hyyn.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711141441530.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOcb-0004eR-IF
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762640AbXKNUNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762728AbXKNUNO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:13:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39283 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762640AbXKNUNN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:13:13 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AB8E32F2;
	Wed, 14 Nov 2007 15:13:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 345B5959F1;
	Wed, 14 Nov 2007 15:13:31 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711141441530.4362@racer.site> (Johannes
	Schindelin's message of "Wed, 14 Nov 2007 14:50:47 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65005>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 14 Nov 2007, Junio C Hamano wrote:
>
>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>> 
>> > This is a series of smallish, unrelated changes that were necessary
>> > for the MinGW port.
>> 
>> I was _VERY_ afraid of reviewing this series.
>
> Why?  Because we get closer to MinGW integration into git.git for real? 
> ;-)

I know you know me better than that.

Conversion from "Too UNIXy" stuff into another form that "claims
to" run on a different platform that I do not have a good way of
testing myself?  I should feel scared, even if I can always punt
and say "I'll only make sure UNIX side does not regress,
Windose, who cares" ;-).
