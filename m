From: Jon Smirl <jonsmirl@gmail.com>
Subject: stgit, rebasing with 100 patches
Date: Thu, 1 Oct 2009 19:04:14 -0400
Message-ID: <9e4733910910011604w68cdca86l2baa2f2fe4db4a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 02 01:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtUhE-0001Fx-5k
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 01:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbZJAXEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbZJAXEL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 19:04:11 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:36144 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbZJAXEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 19:04:11 -0400
Received: by qyk3 with SMTP id 3so508330qyk.4
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=HtxLHVtCpWJRrJ85RZ610lq1nzt45fgD/2PUat+bYNg=;
        b=NsrlWVAo/FCqzxn2FxRPzhU7IInVpO0Fee0nejjtd+my7kBxodkObavjTN2hNLb2hD
         LN15V7tZBUZp/5WJaBmnH1RngrS1p7deRF4Ek07O1Wg10Yt2BELQQVQfTofB19/rbcxy
         7G3WwJt4ZbUVnuQkuW+QsIZrRKXPyfliCZN9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=NgKPODDJ6HKikHESf/Qs2DHEk9cym9VcxG7DflJjbyDBPiFD+RfgqTQDRm/Cx6xMgy
         UgPalfQnbgoVKdj9s2EBxCde9jNrsk7zcYSYEV3B26h5nu5eVuW1OL+SkyP4rZoMwTGQ
         VC6tPtHP70fZeafvdoSEVHJE+vW0hJe/8nLJ4=
Received: by 10.229.44.2 with SMTP id y2mr2389029qce.76.1254438254703; Thu, 01 
	Oct 2009 16:04:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129416>

I have 100 patches loaded into in stgit. My tree is at 2.6.30. Now I
want to rebase to 2.6.31-rc1. About 30 of these hundred patches got
committed in this interval.

If I rebase directly to 2.6.31-rc1 I end up with a bunch of merge
conflicts as the patches are applied. That's because patches 'a,b,c'
got applied in the merge window. When I push 'a' back down it sees the
combination of 'a,b,c' not just 'a'. It is unable to figure out that
'a' was applied and then 'b' and 'c' applied on top of it.

Is there a better way to locate the patches the got applied?

-- 
Jon Smirl
jonsmirl@gmail.com
