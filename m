From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 04 Apr 2008 22:51:53 -0700
Message-ID: <7vmyo8yhl2.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <1207340506.10992.28.camel@gaara.boston.redhat.com>
 <7vzls9xs05.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0804050221000.4008@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 05 07:52:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji1Kj-0006re-Lk
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 07:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYDEFwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 01:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbYDEFwD
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 01:52:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYDEFwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 01:52:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 64EA25E56;
	Sat,  5 Apr 2008 01:51:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A2FDC5E4F; Sat,  5 Apr 2008 01:51:55 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0804050221000.4008@racer.site> (Johannes
 Schindelin's message of "Sat, 5 Apr 2008 02:26:53 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78839>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 4 Apr 2008, Junio C Hamano wrote:
>
>> Judging from the fact that we recently had to deal with the fallouts of 
>> C rewrites that happened during the 1.5.4 timeframe, I would have to say 
>> that any C rewrite of a substantial and important program needs to be 
>> cooked at least for one (or preferably two cycles, especially we are 
>> trying to have shorter cycles) in 'next'.
>
> That would mean that you'd have to merge it into 'next'.  And rather 
> sooner than later, since everything else would lead to a dragging out of 
> the timeline.

Yes, which means somebody needs to present a mergeable history rather
sooner than later, and that somebody does not have to be me ;-)
