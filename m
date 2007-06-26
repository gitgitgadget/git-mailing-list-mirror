From: "Eoin Hennessy" <eoin.hennessy@gmail.com>
Subject: GIT + CVS workflow query.
Date: Tue, 26 Jun 2007 23:20:24 +0100
Message-ID: <47281e410706261520r5b3549c7t39d93924d0a8ceea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 00:20:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3JOd-0007DM-OI
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 00:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbXFZWU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 18:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757521AbXFZWU0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 18:20:26 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:56512 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbXFZWUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 18:20:25 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1863915nzf
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 15:20:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=twDPEELFTcf3JYQg04eQRxf+VrqOyumVan5Aq+AKLyEfzf4bftcXU83Cn6wK3y6JZHJSz9HVN+m7igCoZ1QceSz1fo1tEQjFWWcRfykXPNrEx2hYdld6mHdYR929y+i80WFvyiqjuy77WH9e+LrT8ja1u6cLPK3zVCRJRAwmvbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PLcNZozh5cG1wyBfTw+VD1uKaviOPrCGGcRjqLaiv0CY4xPWzDi59ZVamF56EtRwjvTN4FNle2NnzqMWKwgr9BXNurXXfIxQCB5CEzfPgLV6tC+dYuLalF66ljKQTyzyyUfOC4aKNjn2XH5BcJz8fHVBSSARwEspW1KOaf4DGp0=
Received: by 10.114.166.1 with SMTP id o1mr6842952wae.1182896424321;
        Tue, 26 Jun 2007 15:20:24 -0700 (PDT)
Received: by 10.114.110.6 with HTTP; Tue, 26 Jun 2007 15:20:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50981>

Hi there,

I'd like to use GIT to track changes in a CVS repository. As well as
tracking changes, I will also need to push patches back to CVS from
GIT. My workflow is currently as follows:

  - Use git-cvsimport to import and update a mirror of the CVS
repository; 'project.git'.
 - Pull changes from the mirror to a cloned working copy; 'project'.
 - Fix bugs in the working copy and push commits back to the mirror.
  - Use git-cherry to identify commits in master not currently in the
branch updated by git-cvsimport. Then use git-cvsexportcommit to push
these commits into a CVS checkout.

My question is; as a next step in the workflow, should I be applying
the list of commits identified by git-cherry to the branch updated by
git-cvsimport? How else does one clear this list so that they do not
interfere with the next iteration of the workflow.

I hope I've been clear, and thanks for any suggestions.
