From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Wed, 09 Jan 2008 00:19:35 -0800
Message-ID: <7vy7azl8bs.fsf@gitster.siamese.dyndns.org>
References: <200801082154.21282.stimming@tuhh.de>
	<7vk5mkq669.fsf@gitster.siamese.dyndns.org>
	<18308.17099.334609.80415@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWAY-0003yj-V6
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYAIITr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYAIITr
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:19:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYAIITr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:19:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 950DE1825;
	Wed,  9 Jan 2008 03:19:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 239BB1824;
	Wed,  9 Jan 2008 03:19:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69963>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> I see somwhat funny spacing there.  I'd suggest giving up
>> aligning with spaces and consistently saying "var ?= val"
>> instead.
>
> I made those lines all have one space before and after the ?=, and
> committed Christian's patches (plus one from Gerrit Pape), and pushed
> it out.  Please do a pull.

There were a couple of things I noticed that made me somewhat curious:

 * There are more spaces around ?= in Christian's patch to Makefile.

 * You have two patches from Christian and one patch from
   Gerrit; the author and commit timestamps of these commits are
   the same and in your timezone.

but nothing to complain about.  Pulled and pushed out.
