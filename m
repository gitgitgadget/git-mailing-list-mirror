From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 2/2] status -s: obey color.status
Date: Thu, 26 Nov 2009 16:36:10 +0100
Message-ID: <4B0EA06A.1050101@viscovery.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net> <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 16:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgOL-0004Bq-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 16:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbZKZPgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 10:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZKZPgJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 10:36:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40352 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZKZPgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 10:36:09 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NDgOA-0007eI-JL; Thu, 26 Nov 2009 16:36:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 50BA81660E;
	Thu, 26 Nov 2009 16:36:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133803>

Michael J Gruber schrieb:
> * Is there any policy regarding use of putchar/puts vs. printf?

If the printed string contains color escapes that should be obeyed, you
can use only fputs, printf, and fprintf. You should not use puts or putchar.

> * Even if I were to write tests for status -s: How do I test colors?

See t4034-diff-words.sh.

-- Hannes
