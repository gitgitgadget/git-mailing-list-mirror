From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 15:42:47 +0200
Message-ID: <539AFFD7.6010908@viscovery.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net> <20140613114615.GE14066@sigill.intra.peff.net> <539AE8CA.50009@drmicha.warpmail.net> <539AED0C.8050107@drmicha.warpmail.net> <539AEF7E.1050402@drmicha.warpmail.net> <539AF49F.3010309@viscovery.net> <539AF748.3000901@drmicha.warpmail.net> <539AFAF3.9040707@viscovery.net> <539AFD3D.8090407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvRkv-0006ae-1U
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 15:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaFMNmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 09:42:53 -0400
Received: from so.liwest.at ([212.33.55.14]:46137 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbaFMNmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 09:42:52 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WvRkm-000735-7q; Fri, 13 Jun 2014 15:42:48 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F19DF16613;
	Fri, 13 Jun 2014 15:42:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <539AFD3D.8090407@drmicha.warpmail.net>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251598>

Am 6/13/2014 15:31, schrieb Michael J Gruber:
> rewrite of the form
> 
> a &&
> b &&
> test_must_fail c &&
> d || exit 1
> 
> hoping that will make things both readable (by avoiding !) and concise
> (by avoiding repeated exits).

Thanks!

Please note that we use 'test_must_fail' only for git invocations, but we
do write '!' in front of system commands that we expect to fail, e.g.,
'! grep'.

-- Hannes
