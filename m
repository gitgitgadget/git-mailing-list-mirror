From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 06 May 2012 11:53:42 +0200
Message-ID: <4FA64A26.1020406@in.waw.pl>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 11:55:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQyBs-00019o-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 11:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab2EFJzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 05:55:20 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35961 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab2EFJzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 05:55:19 -0400
Received: from ip-37-209-135-75.free.aero2.net.pl ([37.209.135.75])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SQyBK-0003QS-K0; Sun, 06 May 2012 11:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197159>

On 05/05/2012 03:04 PM, Felipe Contreras wrote:
> Proposal:
> 
> Avoid the terms 'cache' and 'index' in favor of 'stage'.
Yeah, I think that this is a very good idea. Having three different
terms for this great but relatively obscure idea adds an unnecessary
cognitive burden for newcomers to git. 'stage' is certainly the best of
the three options.

> stage: a 'stage' is a special area designated for convenience in order
> for some activity to take place; an orator would prepare a stage in
> order for her speak to be successful, otherwise many people might not
> be able to hear, or see her.  Git porcelain is using the staging area
> precisly as a special area to be separated from the working directory
> for convenience.
I think you missed the most relevant meaning-of/phrase-with this word in
this context, the one that is really the reason why it is used in git:

"A staging area (or staging point) is a location where organisms,
people, vehicles, equipment or material are assembled before use."
[http://en.wikipedia.org/wiki/Staging_area]

> The term 'stage' is a good noun itself, but also 'staging area', it
> has a good verb; 'to stage', and a nice past-participle; 'staged'.

-
Zbyszek
