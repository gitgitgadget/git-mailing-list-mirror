From: "S. M. Ibrahim (Lavlu)" <smibrahim@gmail.com>
Subject: hosting multiple project in single git repository
Date: Wed, 13 May 2009 23:48:44 +0600
Message-ID: <4997275b0905131048t1b5c1427w85a2f96964ea16b6@mail.gmail.com>
References: <4997275b0905131031q3c572854r4b0a899ca43063be@mail.gmail.com>
	 <4997275b0905131046s407e334ag6783a6365c89fe10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 19:48:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4IZa-0005dW-Ao
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317AbZEMRsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759259AbZEMRsp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:48:45 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:43149 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758497AbZEMRso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 13:48:44 -0400
Received: by qyk39 with SMTP id 39so1471600qyk.33
        for <git@vger.kernel.org>; Wed, 13 May 2009 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=19nKxS1AnYulvQ4fnwR8nAFxnjfNm1mezm6iz4MiNdI=;
        b=Ou3z+T4FJoLjdAhl9wEqya1UNhFhPpG++oS3+djyGNQnhn6otsA+iJraKLRVKxkKmO
         7zCc7FGUfWlUo8LOmLg2eMNIAil3GnI8N7X0OD19CIMtykOEZUqY/Q2u8qL0s45VMqZA
         k7JKxNzy9l2qNrtkEKxR7VvmU6BFQ6TJuVUjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=rvKBxmiMUtprQ71SS35N0nZJ9ArEaRL14Qd/8lfX+J4pIir1C4VE/ZkUIKHWdqpXPX
         AxgCGXaoG6ZL2aTX6H5icIvTjI+ybiuQGHNme8IuOe9fLvN8P8s2C4tBrOklXpAnk9Es
         T+Mg8B9IqtAUzPD4uDOIlODUgLEYlvy2wrsy4=
Received: by 10.224.60.202 with SMTP id q10mr1551006qah.243.1242236924841; 
	Wed, 13 May 2009 10:48:44 -0700 (PDT)
In-Reply-To: <4997275b0905131046s407e334ag6783a6365c89fe10@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119077>

hi,

in our company we are moving all our subversion repository to git.
git-svn is working really nice. but facing a problem. we have one svn
repository where we hosted two projects and both the projects are
under development. project a is trunk and project b is branch/xxxx .
and project b was copied from trunk . we have plan to merge this two
project in future. what is the best way to maintain this two project
in git ? should we make to different git repository .

thanks

--
S. M. Ibrahim Lavlu
software engineer, php
somewhere in...
