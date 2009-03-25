From: Jon Smirl <jonsmirl@gmail.com>
Subject: .git/index
Date: Wed, 25 Mar 2009 13:16:59 -0400
Message-ID: <9e4733910903251016n117c37fdp94f91b2862cd7bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmWkz-0000Jr-DM
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 18:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZCYRRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 13:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbZCYRRE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 13:17:04 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:47109 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbZCYRRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 13:17:02 -0400
Received: by qyk16 with SMTP id 16so278060qyk.33
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=WZi08NMSjYsoKaHODlpF2WkAOivQ34mMOB48obpaPhQ=;
        b=iHDLXGt+k23cdSeOBs/3qC4TiEm5QvxF/pWQwX92p5utJT8dTW3J35SEtOOJY59sGB
         cTo/auncPm44tcWmccAn5e/Y4S5cXVD1ZEQJetm6DKyhIi7cWasFr1JAHfcWeFK2UuPG
         /aBL1Xh56OQZ6+ApUY2/j3Rx+r2Qx/UzXMnhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QXJF050fDFHj/YMFf3GxA49oVYgJep56GAB0Ura7FZjghs2mjLXvTKTkVyXzY1IR04
         Kps+2iR8pvWZUQ+s699pmixQSq6ll7lmtifBp61fg8Cd4+goc3JBsykn6Q2bbRxqq7Lm
         l4jNtQKvisJxovS+fUlW9tC7fes/koiWMyiXc=
Received: by 10.224.61.12 with SMTP id r12mr12851947qah.254.1238001419400; 
	Wed, 25 Mar 2009 10:16:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114623>

I pushed a repo up to my server. I want to view this repo with gitweb
but it is not visible in my project list like my other projects. I
suspect this is because the newly pushed repo is missing .git/index. I
ran update-server-info on the repo and that didn't create .git/index.
What command builds this index?

-- 
Jon Smirl
jonsmirl@gmail.com
