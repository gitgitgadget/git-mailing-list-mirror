From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Fri, 10 May 2013 08:42:37 +0200
Message-ID: <518C96DD.50304@viscovery.net>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com> <1368063095-22861-3-git-send-email-felipe.contreras@gmail.com> <7vvc6r7pii.fsf@alter.siamese.dyndns.org> <CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com> <7v38tv7n5y.fsf@alter.siamese.dyndns.org> <CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com> <7vobcj65wp.fsf@alter.siamese.dyndns.org> <7vk3n763is.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 08:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uah36-0005Co-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 08:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab3EJGnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 02:43:14 -0400
Received: from so.liwest.at ([212.33.55.13]:15843 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab3EJGnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 02:43:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uah2r-0007io-2N; Fri, 10 May 2013 08:43:09 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C55F31660F;
	Fri, 10 May 2013 08:43:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vk3n763is.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223818>

Am 5/10/2013 3:13, schrieb Junio C Hamano:
>  * On the other hand, "git log 'fc/*'" might be a handy thing for
>    any command that wants to have multiple starting points for
>    revision traversal, so in principle I would not mind such an
>    enhancement to rev-list machinery.

Currently, we spell this as "git log --branches=fc" or
"git log --branches='*export*'". But I do not mean to say that
"git log fc/\*" would be a bad thing to have.

-- Hannes
