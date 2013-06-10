From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Mon, 10 Jun 2013 07:30:51 +0200
Message-ID: <51B5648B.7020703@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net> <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net> <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com> <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org> <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com> <20130609001845.GC29964@sigill.intra.peff.net> <7vk3m3owk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uluhm-0005Fx-MF
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab3FJFbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:31:43 -0400
Received: from so.liwest.at ([212.33.55.13]:47455 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215Ab3FJFbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:31:42 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uluhb-0005Q5-Ve; Mon, 10 Jun 2013 07:31:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 953501660F;
	Mon, 10 Jun 2013 07:31:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vk3m3owk2.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227240>

Am 6/9/2013 22:31, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> I'm a little negative on handling just SIGTERM. That would make the test
>> pass, but does it really address the overall issue? To me, the
>> usefulness is having exit values with consistent meanings.
> 
> Yes.  Unless the goal is to give Windows port pratically the same
> signal semantics as ports on other platforms, I do not think special
> casing SIGTERM (unless it is a very common signal on Windows and
> others are unlikely to be useful) buys us much.

I'm thinking the same. And, no, SIGTERM is not very common on Windows.

-- Hannes
