From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 10:05:10 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071109090509.GA20121@ins.uni-bonn.de>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711090225110.4362@racer.site> <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr> <473420FE.7010807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPo2-0002A1-Qf
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 10:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXKIJFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 04:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXKIJFO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 04:05:14 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:44468 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbXKIJFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 04:05:13 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 35EF140000237;
	Fri,  9 Nov 2007 10:05:11 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Jonas Fonseca <fonseca@diku.dk>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <473420FE.7010807@viscovery.net>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64144>

* Johannes Sixt wrote on Fri, Nov 09, 2007 at 09:57:34AM CET:
> Benoit Sigoure schrieb:
>> Off topic question: why do you guys always do this instead of doing, say, 
>> this:
>>
>> INTERACTIVE=false
[...]
>> if $INTERACTIVE; then
>>   git_editor "$TODO" || die ...
>> fi
>
> Because in some shells 'false' is not a built-in.
[...]
>         INTERACTIVE="! :"       # false

Which shells do not have 'false' but do support '!' as process exit
status negation?  For them, is it important to save another fork?
Solaris sh has neither (it will error on the '!'), but it's ruled out
for git anyway.  

Cheers,
Ralf
