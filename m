From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Tue, 05 Jun 2012 11:09:34 +0200
Message-ID: <4FCDCCCE.5060201@viscovery.net>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com> <20120605065628.GA25809@sigill.intra.peff.net> <4FCDC894.7000905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbplm-0002qg-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 11:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab2FEJJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 05:09:38 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27395 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2FEJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 05:09:37 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Sbpmg-0002mH-Gv; Tue, 05 Jun 2012 11:10:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EA39B1660F;
	Tue,  5 Jun 2012 11:09:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FCDC894.7000905@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199222>

Am 6/5/2012 10:51, schrieb Johannes Sixt:
> The second problem is more severe and is at the lowest level of our
> infrastructure: We set up our child processes so that they know only about
> file descriptors other than 0,1,2 to the child process.

That should read:

We set up our child processes so that they know only about file
descriptors 0,1,2.

> Even if the first
> problem were solved, the child process does not receive sufficient
> information to know that there are open file descriptors other than 0,1,2.
> There is a facility to pass along this information from the parent to the
> child, but we simply do not implement it.
