From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Fri, 17 Sep 2010 16:14:04 +0200
Message-ID: <4C9377AC.7070001@viscovery.net>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <4C935FF2.7080502@viscovery.net> <4C9374B5.9020907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 17 16:14:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owbhi-0006YB-5o
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 16:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab0IQOOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 10:14:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10148 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752195Ab0IQOOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 10:14:09 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OwbhV-0002U7-IE; Fri, 17 Sep 2010 16:14:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4B7DC1660F;
	Fri, 17 Sep 2010 16:14:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
In-Reply-To: <4C9374B5.9020907@web.de>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156384>

Am 9/17/2010 16:01, schrieb Jens Lehmann:
> But I was trying to fix a problem introduced by 496b35e7 in current next,
> where the new function fetch_populated_submodules() is located there. And
> in that function the output is not read and so cp.out = 0 is the right
> thing to do here.

Got it! You are right.

-- Hannes
