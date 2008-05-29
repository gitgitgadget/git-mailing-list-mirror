From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-init: treat option `--bare'
Date: Thu, 29 May 2008 11:31:27 -0700
Message-ID: <7v4p8hotc0.fsf@gitster.siamese.dyndns.org>
References: <20080519175313.GA17305@bit.office.eurotux.com>
 <20080520194850.GB19226@bit.office.eurotux.com>
 <7vy761sgks.fsf@gitster.siamese.dyndns.org>
 <20080528185103.GA4431@bit.office.eurotux.com>
 <20080528185357.GB4431@bit.office.eurotux.com>
 <7vzlqaq67h.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805291448161.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luciano Rocha <luciano@eurotux.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 20:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1mvS-0001Gw-At
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYE2Sbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYE2Sbm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:31:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYE2Sbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:31:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 742C058CB;
	Thu, 29 May 2008 14:31:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CECA9586B; Thu, 29 May 2008 14:31:36 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805291448161.13507@racer.site.net> (Johannes
 Schindelin's message of "Thu, 29 May 2008 14:51:06 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AD94516-2DAD-11DD-8313-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83232>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also keep in mind that "git --bare <some-command-other-than-init" is 
> _really_ rare, at least in my experience.  I had to use it exactly _twice_ 
> since I started using Git.

Exactly.  That is really the contributing factor that I am in favor of
this (perhaps redundant from theoretical point of view) addition.
