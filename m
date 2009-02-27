From: Caleb Cushing <xenoterracide@gmail.com>
Subject: FEATURE suggestion git commit --amend <ref>
Date: Fri, 27 Feb 2009 02:45:28 -0500
Message-ID: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 08:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcxYL-0006BB-2P
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 08:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZB0HxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 02:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbZB0HxI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 02:53:08 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:35494 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbZB0HxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 02:53:07 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1683201qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 23:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=qEs0xXdSPXdiK6ggK4mn/1ap/3DvAZFALdqb/0uCSZs=;
        b=GG83yrDBBMxEhWSECdjFUj9voPnICJiEkgOJOCMlPn8e3SYzLGnXJ7XEgGoU+ehiiw
         toVq8G1Ci0BdE6YypgwvadE3kg3iQXOV1zAE3u/rU6pLAHu0anbQYIPPycZoO2IUVCtq
         mJqZgzlAtLl6Vv63IELP4eZbto5WnkcuULftE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=F+WT7rErfAzUBRAwcGL25FHf+vWDW13ZwlWRHqlSzErklu2pzdRWH8ukDAKIlllE/0
         GWQOHiMRhlCE9nkx0xybEFfGixGWGP/yRij5Yl41qYWstyRYr5Tj1gYhSPRYcI9z5clV
         RCmHxCoH8OCYNNWFkbpF8xOaICXxmkaAkfIyQ=
Received: by 10.229.81.129 with SMTP id x1mr1764395qck.16.1235720728305; Thu, 
	26 Feb 2009 23:45:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111642>

git rebase -i seems a little more tedious/unfriendly than I'd like if
all I want to do is edit HEAD~2 (assuming no merges) it's a bit of a
pain to do a rebase -i and then pick which patches to edit. might be
nice to be able to do stuff like git commit --amend <ref> and have
that call rebase  (as I think not rebasing is impossible?) with edit
only on the ref I picked.

hopefully I've explained well enough.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
