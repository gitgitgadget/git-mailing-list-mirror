From: "Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net>
Subject: Manipulating existing revisions by push or pull?
Date: Mon, 16 Nov 2009 21:49:10 +0000 (UTC)
Message-ID: <hdshcm$c06$1@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 22:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA9S9-0003YO-Lu
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 22:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbZKPVta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 16:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZKPVta
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 16:49:30 -0500
Received: from lo.gmane.org ([80.91.229.12]:33468 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991AbZKPVta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 16:49:30 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NA9S2-0003VI-A7
	for git@vger.kernel.org; Mon, 16 Nov 2009 22:49:34 +0100
Received: from h1283867.stratoserver.net ([85.214.127.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:49:34 +0100
Received: from lasse-gmane-git-2009 by h1283867.stratoserver.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:49:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: h1283867.stratoserver.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133027>

I've got a conceptual question.

I know that one can change history in a local repository with the 
'rebase' command, e.g., using the interactive mode. 

Is there any way to modify existing revisions in a local 
repository by a pull (and merge, whatever) from a remote one? Or 
is there any way to modify existing revisions in a remote 
repository by a push (or whatever) from a local one?

Put a different way: consider there is a hostile entity from 
which I pull or which I allow to push to me. Can this entity 
fiddle with my history? Can it change the data in existing 
revisions in my repository? Or can it only make new revisions 
grow on my side?

Thank you
Lasse
