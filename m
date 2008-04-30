From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 00:10:53 -0700
Message-ID: <7vlk2v3jia.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
 <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
 <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
 <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net>
 <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness>
 <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness>
 <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.1
 7469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness>
 <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <481810C9.3030409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 09:12:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr6Tv-0004pR-EA
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 09:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbYD3HLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 03:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756266AbYD3HLL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 03:11:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbYD3HLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 03:11:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8729C305A;
	Wed, 30 Apr 2008 03:11:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AE1A33055; Wed, 30 Apr 2008 03:11:03 -0400 (EDT)
In-Reply-To: <481810C9.3030409@viscovery.net> (Johannes Sixt's message of
 "Wed, 30 Apr 2008 08:25:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B259FF8-1684-11DD-8EEB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80802>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> The problem I had was to figure out the way to go back to "rewritten X".
>> I assumed you would say "B" because that is the last insn in the sequence
>> that used that name.
>> 
>> But instead you are thinking of letting me just say "X", and somehow make
>> the machinery guess by noticing "Ah, original X is a merge between
>> original A and B, and we have a merge between rewritten A and rewritten B,
>> so we will treat that merge as rewritten "X"?
>
> You had used this notion in your post:
>
> 	merge B -- recreate X
>
> Did you mean the '-- recreate X' part as just a comment?

Purely as a comment to let the readers know what I was describing.
