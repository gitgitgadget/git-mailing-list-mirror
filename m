From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Fri, 16 Apr 2010 08:08:10 +0200
Message-ID: <4BC7FECA.2010202@viscovery.net>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org> <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net> <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net> <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net> <20100415163607.GA4279@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 08:08:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ej0-000774-J4
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 08:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab0DPGIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 02:08:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54351 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0DPGIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 02:08:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O2eio-0007nZ-PJ; Fri, 16 Apr 2010 08:08:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6E65D1660F;
	Fri, 16 Apr 2010 08:08:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100415163607.GA4279@coredump.intra.peff.net>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145051>

Am 4/15/2010 18:36, schrieb Jeff King:
> I think it is because the reachability test is defined as "from the
> current ref".

Thanks, this clears my confusion. I see the problem that Junio wants to
fix, but IMHO this:

> I think another way of addressing the same problem would be to redefine
> "reachable" in this context as "reachable from any current ref".

would be a better approach for a fix rather than an exception for HEAD.

-- Hannes
