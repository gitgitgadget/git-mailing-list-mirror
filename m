From: "Christian MICHON" <christian.michon@gmail.com>
Subject: More help needed on merging unrelated repos
Date: Tue, 4 Nov 2008 14:14:51 +0100
Message-ID: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 14:16:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxLlO-00021t-Ma
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 14:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYKDNOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 08:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbYKDNOw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 08:14:52 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:44750 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYKDNOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 08:14:52 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3191004wfd.4
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Nir8BpgoFGX+I01O5JkeuglXI5ujOEhGsfAhopF4rww=;
        b=wbna/rf1XaZuDFZTV/3LOc39lgvHMOmZBe4SkHcfjJEBPTugktC8/+UBMs3TyjCs0j
         oImTtiP4s/HAohJSD+76W7nNbMKs4DNSpkp6RZ+ejsGL+wddFa+TNut6kai2/y+b27N+
         2FSGnAX95/VF71uJ+Jbvl52h0ddHRAHG5czmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ixywWnivFywWxN55TNre+RFvVVluf6iK8pB26Mv016wJcOJkSfxt6Qa9ZD1Izs0rZv
         aNueASNtxvmxkK6CtdvfdEF8DIEhVHiw38ldpRQ2NDF7qUfx/eTwDcqSQ0DP1OLo0xaC
         xpdAx5cVG9srye3aEXNH6Xv6cmm8qQLv5MNcI=
Received: by 10.142.185.13 with SMTP id i13mr767005wff.219.1225804491403;
        Tue, 04 Nov 2008 05:14:51 -0800 (PST)
Received: by 10.143.1.15 with HTTP; Tue, 4 Nov 2008 05:14:51 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100076>

Hi,

I previously posted here a question on how to merge unrelated repos,
and I was quite happy with the answer.
git pull repo_name repo_branch

Yet, when I merge these repos (they're unrelated), I'd like to merge
all of them at once.

How do I pull for example 2 repos in 1 command ? I cannot figure out
the exact syntax to use.

I tried:
git pull ../i1 0.5 ../i2 master
git pull ../i1 0.5 -- ../i2 master

I also tried to play with --no-commit and -s to no avail.

Does anyone of you already use this and knows the trick ? Thanks in advance!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
