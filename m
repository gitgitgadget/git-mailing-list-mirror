From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: [tig] Feeding specific revisions to tig
Date: Wed, 4 Jun 2008 20:52:14 +0200
Message-ID: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:53:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3y6s-0007Ko-1a
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761618AbYFDSwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761588AbYFDSwS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:52:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:35892 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761562AbYFDSwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:52:16 -0400
Received: by wx-out-0506.google.com with SMTP id h29so166496wxd.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=NJ7JNPW8tB4077Esw8ELtZvCyXEAv9i7UvP9USqDb1s=;
        b=H90G1vAUAS0YFiTPdhY0kWz+JYDsoJsBa+LX0qfpkNkiWotEnBfcIsNfIGaHn305W7
         Oj19fvy4jXdgzJC4Ou0KNbBkLHF1USa5zSqMvsD74yRSdyv598i9CbgQWgojJ0BYSjA+
         43vwsaRYYiwyDvhRambzUkRV1519uefq3jxQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=XXpPI2bKll6rfFRqYgiwWX0mn87p1fzhFDqaqIynyQjj7CNKWhJL7lTUb3V9/Um30E
         i9v/fuw9jun+IN8XqTo02367tBFuihRg/OHYB71fxacySurSFoUyElQEnxVKTR+5yPYK
         3WuZCJl7Erp9uIDkXk/0RcK+Oxl1/wdUbYKDU=
Received: by 10.70.111.2 with SMTP id j2mr243353wxc.86.1212605535512;
        Wed, 04 Jun 2008 11:52:15 -0700 (PDT)
Received: by 10.70.115.20 with HTTP; Wed, 4 Jun 2008 11:52:14 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 5347cf7ceabef5cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83807>

Hi there,

In order to track changes between my development branch and the stable
branch that goes to production, I'm using git-cherry-pick and
git-cherry to list the changesets available for merging.

Ideally I'd like to feed this list of commits to tig, so that I can
watch the commit diff and summary easily and switch from one commit to
another.  But tig only behaves as a pager, and does not help for this.

To make it short I'd like to do something like this:

git-cherry origin/stable origin/trunk | sed -ne 's/^+ //p' | tig

And browse every available commit with tig.

Does it make sense?

Cheers,
-- 
Jean-Baptiste Quenot
http://jbq.caraldi.com/
