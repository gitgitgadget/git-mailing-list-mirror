From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 17 Nov 2007 17:29:01 -0800
Message-ID: <7v1waoz6hu.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<20071117234240.GB7664@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 02:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYyU-0007mg-HZ
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 02:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbXKRB3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 20:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbXKRB3I
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 20:29:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41251 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbXKRB3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 20:29:07 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A81FA2EF;
	Sat, 17 Nov 2007 20:29:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B21296EEA;
	Sat, 17 Nov 2007 20:29:25 -0500 (EST)
In-Reply-To: <20071117234240.GB7664@steel.home> (Alex Riesen's message of
	"Sun, 18 Nov 2007 00:42:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65333>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sat, Nov 17, 2007 21:51:04 +0100:
>> * mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
>>  - Do git reset --hard HEAD when using git rebase --skip
>> 
>> Some people on the list may find this debatable.  Opinions?
>
> I like it (and didn't like the previous behaviour). Anyway, it is not
> obvious what to do when --skip refuses to continue rebase because of
> dirty index.

True.  Let's have it in 'next' then.
