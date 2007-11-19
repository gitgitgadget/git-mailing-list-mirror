From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current
 branch
Date: Mon, 19 Nov 2007 10:27:45 +0100
Message-ID: <47415711.7060507@op5.se>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>	<11954023881802-git-send-email-prohaska@zib.de>	<119540238994-git-send-email-prohaska@zib.de>	<7vwssfqb0w.fsf@gitster.siamese.dyndns.org>	<EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>	<7vejempudf.fsf@gitster.siamese.dyndns.org> <7v4pfiptb5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 10:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu2vI-0003BQ-2t
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 10:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbXKSJ1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 04:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbXKSJ1v
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 04:27:51 -0500
Received: from mail.op5.se ([193.201.96.20]:54414 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbXKSJ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 04:27:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B4B0D1F08755;
	Mon, 19 Nov 2007 10:27:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXVxI6hwsyWW; Mon, 19 Nov 2007 10:27:48 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3DF371F08754;
	Mon, 19 Nov 2007 10:27:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7v4pfiptb5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65419>

Junio C Hamano wrote:
> 
> If we can come up with a way to tell projects that use the
> workflow better served with --current, perhaps when a remote is
> added to the repository (either the initial clone or "git remote
> add") and/or when a new branch is created.  If we automatically
> set up the configuration "push.defaultRefs = current" in such a
> case, I suspect that we do not have to have the built-in default
> (at least, the value of the built-in default would not matter
> much).

So when someone who's been using git of today adds a new remote
with a newer git, all of a sudden the default push behaviour
changes for that repo?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
