From: Andreas Ericsson <ae@op5.se>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 04 Dec 2007 16:14:42 +0100
Message-ID: <47556EE2.6040105@op5.se>
References: <20071204130922.731c407a@pc09.procura.nl>	<Pine.LNX.4.64.0712041343040.27959@racer.site>	<20071204140326.14d9e7a0@pc09.procura.nl>	<Pine.LNX.4.64.0712041439590.27959@racer.site> <20071204150102.7f3ec3e9@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZUI-00044b-CX
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXLDPOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbXLDPOq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:14:46 -0500
Received: from mail.op5.se ([193.201.96.20]:34998 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbXLDPOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:14:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6F6FF1F08052;
	Tue,  4 Dec 2007 16:14:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcwDmv-m4IRz; Tue,  4 Dec 2007 16:14:43 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5A0AD1F08050;
	Tue,  4 Dec 2007 16:14:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071204150102.7f3ec3e9@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67053>

H.Merijn Brand wrote:
> 
> I also meanwhile forced copied the git binaries to my bin dir
> 

That's no good. "make test" will test binaries residing in ..
relative to where the tests are executed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
