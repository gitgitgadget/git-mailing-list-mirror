From: Andreas Ericsson <ae@op5.se>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 09 Nov 2007 11:29:23 +0100
Message-ID: <47343683.7080904@op5.se>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711090225110.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 11:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqR7N-0003pF-UE
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 11:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXKIK31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 05:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbXKIK31
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 05:29:27 -0500
Received: from mail.op5.se ([193.201.96.20]:55724 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbXKIK30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 05:29:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 643BD1F0871F;
	Fri,  9 Nov 2007 11:29:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7PS4Fz6Weth; Fri,  9 Nov 2007 11:29:24 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 694971F08715;
	Fri,  9 Nov 2007 11:29:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0711090225110.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64152>

Johannes Schindelin wrote:
>> +		case "$INTERACTIVE" in
>> +		t)
>> +			git_editor "$TODO" || die "Could not execute editor"
>> +			;;
>> +		esac
> 
> 
> Would that not be easier to read as
> 
> 		test t = "$INTERACTIVE" &&
> 			git_editor "$TODO" || die "Could not execute editor"
> 

Written like that, it would die every time $INTERACTIVE isn't "t". You'd need
curly braces around 

	git_editor "$TODO" || die "Could not execute editor"

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
