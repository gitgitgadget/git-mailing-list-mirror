From: Junio C Hamano <gitster@pobox.com>
Subject: Re: email address handling
Date: Fri, 01 Aug 2008 14:25:44 -0700
Message-ID: <7v4p64sa07.fsf@gitster.siamese.dyndns.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
 <20080801124550.26b9efc0.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
 <20080801132415.0b0314e4.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <alpine.DEB.1.00.0808012314580.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP29j-0006T8-GM
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 23:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762873AbYHAVZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760189AbYHAVZx
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:25:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764083AbYHAVZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 17:25:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95BA7422D1;
	Fri,  1 Aug 2008 17:25:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D93D9422CD; Fri,  1 Aug 2008 17:25:45 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808012314580.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 1 Aug 2008 23:16:01 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A0D9396-6010-11DD-BFF7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91102>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 1 Aug 2008, Andrew Morton wrote:
>
>> I very very frequently copy and paste name+email address out of git 
>> output and into an MUA.  Have done it thousands and thousands of times, 
>> and it has always worked.  I'm sure that many others do the same thing.

>
> $ git log --pretty=email
>
> after this patch:

You are quoting only Author: and not Signed-off-by: and Cc: that are used
for e-mail purposes.  I already said send-email is the right place to do
this kind of thing, didn't I?  Your patch makes things worse by making
some <name, mail> pair already quoted and some others don't.

Please don't do this.
