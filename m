From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Fri, 11 Jan 2008 15:57:34 -0800
Message-ID: <7vr6gn29w1.fsf@gitster.siamese.dyndns.org>
References: <200801082154.21282.stimming@tuhh.de>
	<7vk5mkq669.fsf@gitster.siamese.dyndns.org>
	<18308.17099.334609.80415@cargo.ozlabs.ibm.com>
	<7vk5mg3fjf.fsf@gitster.siamese.dyndns.org>
	<7vfxx43f5r.fsf@gitster.siamese.dyndns.org>
	<18311.64910.643392.816623@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTlL-0004bi-AQ
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbYAKX5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 18:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbYAKX5o
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:57:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbYAKX5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:57:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CDE924E6;
	Fri, 11 Jan 2008 18:57:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AA1BC24E5;
	Fri, 11 Jan 2008 18:57:36 -0500 (EST)
In-Reply-To: <18311.64910.643392.816623@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 12 Jan 2008 10:36:46 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70226>

Paul Mackerras <paulus@samba.org> writes:

> I get:
>
> ~/gitk$ git pull master.kernel.org:/pub/scm/git/git.git/ gitk
> error: no such remote ref refs/heads/gitk
> fatal: Fetch failure: master.kernel.org:/pub/scm/git/git.git/

My bash history tells me that I only did push --dry-run.  Stupid
me.  Sorry about the noise.

>> Christian Stimming (2):
>>       gitk: Fix typo in user message.
>
> I was going to ignore this one since "descendent" is actually a valid
> alternate spelling, and is the one I am used to.  However, I don't
> have a strong feeling about it.

I agree with you that both are valid spellings, but when I
received 9e5d87d49070fe0463040e826824d6ce41beb089, I consulted a
couple of dictionaries and descendant seemed to be more widely
used.  Besides, I think the german translation update depends on
it ;-).

Anyway, I pushed it (this time without --dry-run) to

    master.kernel.org:/pub/scm/git/git.git/ gitk-for-paulus

Sorry, and thanks.
