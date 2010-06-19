From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule	links
Date: Sat, 19 Jun 2010 17:54:48 +0200
Message-ID: <4C1CE848.5020602@web.de>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006170239.01951.johan@herland.net> <4C1A8FDC.7010309@web.de> <201006181140.16652.johan@herland.net> <4C1B7ABE.8080905@web.de> <20100619094301.GA2667@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jun 19 17:55:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ0Nm-00080Q-3F
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 17:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347Ab0FSPyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 11:54:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59552 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab0FSPyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 11:54:52 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7ABA316079A4A;
	Sat, 19 Jun 2010 17:54:51 +0200 (CEST)
Received: from [80.128.109.62] (helo=[192.168.178.26])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OQ0Nf-000730-00; Sat, 19 Jun 2010 17:54:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100619094301.GA2667@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+ufW1tT/lBxi/763q02iIGUjFMEiaWtcdpXOBZ
	sCeAllRS8kBiEhWYe8W3wEnr8TprudBXhQb7mxQjULe/epcorL
	Uhxr9/wNEs4FVREEWKIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149382>

Am 19.06.2010 11:43, schrieb Heiko Voigt:
> On Fri, Jun 18, 2010 at 03:55:10PM +0200, Jens Lehmann wrote:
>> Nice summary. Heiko, would you please post a new patch implementing this
>> approach?
> 
> Yes sure. I agree with the proposed scheme.

Thank you very much!


> As Jens is working on the automatically checkout submodules extension I
> will base the merge patch on your branch. Is the checkout_submodule()
> function already stable enough to be used?

Unfortunately not (the checkout itself is working fine, but the test if
the checkout would overwrite local changes in the submodules is still
missing, so be warned!).
