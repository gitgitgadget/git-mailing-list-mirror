From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is
	nothing to commit.
Date: Tue, 9 Jan 2007 06:42:39 +0100
Message-ID: <17827.11087.870000.177936@lapjr.intranet.kiel.bmiag.de>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
	<17823.44049.943881.536532@lapjr.intranet.kiel.bmiag.de>
	<1168283894.6134.8.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 06:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49lH-0002uS-Da
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbXAIFnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbXAIFnA
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:43:00 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:33825 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbXAIFnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:43:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 21BAA3AF21;
	Tue,  9 Jan 2007 06:42:58 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03912-06; Tue, 9 Jan 2007 06:42:57 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 1A8F53AEE2;
	Tue,  9 Jan 2007 06:42:55 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 82A123ADC8;
	Tue,  9 Jan 2007 06:42:55 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25262-07; Tue, 9 Jan 2007 06:42:48 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 07A8E3ADC6;
	Tue,  9 Jan 2007 06:42:46 +0100 (CET)
To: Michael Loeffler <zvpunry@zvpunry.de>
In-Reply-To: <1168283894.6134.8.camel@ibook.zvpunry.de>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36315>

Michael Loeffler writes:
 > hi,
 > 
 > Am Samstag, den 06.01.2007, 15:02 +0100 schrieb Juergen Ruehle:
 > ...
 > > I'd appreciate feedback on my series from the 2nd of January,
 > > especially part 3/4 (Subject: [PATCH 3/4] Improve "nothing to commit"
 > > part of status output). This is already part of next.
 > A very positive feedback from me, I like this and it is much better then
 > just removing this "use git add"-message. ;)

How about Junio's case where there are only untracked files in the
working directory? I tend to send a patch that either just prints
"nothing to commit" (simpler) or provides a different message that
just advertises git-add.
