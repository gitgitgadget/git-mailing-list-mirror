From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: pre-receive hook ; how to detect file and append code ?
Date: Fri, 22 Jun 2012 18:37:09 +0530
Message-ID: <20120622183709.2f0beaa6@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 15:07:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si3aT-0003zb-V3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 15:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762075Ab2FVNHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 09:07:33 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:50302
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762071Ab2FVNH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 09:07:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 9F278DE3A00
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 15:07:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhgH5Sgfzvpv for <git@vger.kernel.org>;
	Fri, 22 Jun 2012 15:07:25 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 2BD10DE39FE
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 15:07:23 +0200 (CEST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200435>

Dear list,

How can I detect a specific file during push, if it is modified or not ?
And how can I then append a block of code into that file; if modified
during push ? I think pre-receive hook is the best for this operation.

Thanks
