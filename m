From: Andreas Ericsson <ae@op5.se>
Subject: git/lib and git/git-gui/lib merge mis-hap?
Date: Sat, 01 Nov 2008 20:30:08 +0100
Message-ID: <490CAE40.4060300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 20:31:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMC5-0007kf-2t
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbYKATaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYKATaU
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:30:20 -0400
Received: from mail.op5.se ([193.201.96.20]:40855 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYKATaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:30:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3AB051B80066;
	Sat,  1 Nov 2008 20:25:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aI8dVT1oD0Zl; Sat,  1 Nov 2008 20:25:03 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id E31181B800A4;
	Sat,  1 Nov 2008 20:25:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99763>

Settling down to get some libgit2 hacking done (adding build-rules
to git.git), I noticed that there's a file in git.git called
lib/remote_add.tcl, which looks as if it belongs in git-gui/lib.

I don't know how this happened, but since I assume it's subtree
merged (thus requiring more work to correct than a simple patch),
it would be nifty if it could get corrected so as to make space
for the up-and-coming git library :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
