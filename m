From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using url.insteadOf in git-clone
Date: Fri, 27 Jun 2008 10:11:15 -0700
Message-ID: <7vbq1msszw.fsf@gitster.siamese.dyndns.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:12:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHUl-0007Ax-Eg
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbYF0RL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYF0RL1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:11:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYF0RL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:11:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3D799A5E;
	Fri, 27 Jun 2008 13:11:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4461B9A5B; Fri, 27 Jun 2008 13:11:20 -0400 (EDT)
In-Reply-To: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> (Pieter de
 Bie's message of "Fri, 27 Jun 2008 11:35:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12808DFA-446C-11DD-8842-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86602>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> [1] This is not really true. If I try that, I get an error:
> Vienna:git pieter$ git fetch -v repo:dscho.git
> fatal: I don't handle protocol 'it'
>
> If I change the url to "ggit://.." it does work. It seems there is an
> off-by-one
> error somewhere? It does work for another url.insteadOf I have in my
> global
> config though..

What version of git is this?

v1.5.5.1 and later contains 60e3aba (Fix config key miscount in
url.*.insteadOf, 2008-04-12).
