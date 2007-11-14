From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 00:47:48 -0800
Message-ID: <7vk5olkybv.fsf@gitster.siamese.dyndns.org>
References: <20071112213823.GB2918@steel.home>
	<20071112213938.GC2918@steel.home>
	<20071113075240.GA21799@sigill.intra.peff.net>
	<20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home>
	<20071113230234.GI3268@steel.home>
	<7vmythr8xf.fsf@gitster.siamese.dyndns.org>
	<20071114071929.GA2942@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:48:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsDut-0008C1-DS
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 09:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbXKNIrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 03:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbXKNIrz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 03:47:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54799 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbXKNIry (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 03:47:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3DC592F0;
	Wed, 14 Nov 2007 03:48:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B279E9451A;
	Wed, 14 Nov 2007 03:48:11 -0500 (EST)
In-Reply-To: <20071114071929.GA2942@steel.home> (Alex Riesen's message of
	"Wed, 14 Nov 2007 08:19:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64961>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Nov 14, 2007 01:02:20 +0100:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > Ignore exit code of git push in t5404, as it is not relevant for the
>> > test
>> 
>> This proposed log message solicits a "Huh? -- Since when
>> ignoring exit code is an improvement?" reaction.  If this push
>> is expected to error out, then wouldn't you want to make sure it
>> errors out as expected?  If the problem is that the exit status
>> is unreliable, maybe we need to make it reliable instead?
>
> Well, it is kind of undefined. git push just updated some remote
> references and failed on the others. It has had some failures, so it
> returns non-0. And as I said, it really is not about the operation,
> but about if the tracking and remote branches are set as we want them.

Ok, I guess the proposed log message was not clear enough, at
least for me.

Will apply.
