From: Dobes Vandermeer <dobesv@gmail.com>
Subject: Git bash completion and special characters (particularly #)
Date: Fri, 30 Jul 2010 11:54:53 -0700
Message-ID: <AANLkTi=+HhRUJ2wGc4nUZ7pVbnKa+A3pq4tNXx0dBpn_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 30 20:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oeuk9-0000Oh-VK
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760265Ab0G3SzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:55:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47616 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759192Ab0G3SzO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:55:14 -0400
Received: by vws3 with SMTP id 3so1617894vws.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Y+ANvEzlLCCbRqKIe9t9rrNKKC1tOh+S2mtmanQTxII=;
        b=iqtlf5JXsMUev5LlwycngqT7zP88fzwbHCf47+IE2KdOhmPTZIwVDm0HyCsQU6s/yZ
         MI4TNyJsKr5yRDI6rmflZMxRjf+bAWfsemCNzFufqy+a1MfP4cdJ8NR8VJmSJmp7nBMT
         AdqB4nBYpJU8D+V0OQ+0s2aQ0/9WOPfoeDa6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=BFV5WgIveqwsauVEgDL0cVA1givNwrM70u6duOuUa+FQBQXuycWpx4uLPUyIUQOMxJ
         sgHABukrfRvLiH0QDwcXQinUciC+li9gmqcho3I2jMIeF23koftl/JcAOZel1Ejswjex
         zaDdVihdpQwXkXGyOAmRXyf0MLbVvlTQZSwXo=
Received: by 10.220.168.213 with SMTP id v21mr1328880vcy.274.1280516113432; 
	Fri, 30 Jul 2010 11:55:13 -0700 (PDT)
Received: by 10.220.85.70 with HTTP; Fri, 30 Jul 2010 11:54:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152260>

Git bash completion is great, but we always have special characters in
our branches - particularly we name the branch after the trac ticket
#, like "#1234-foo".

Git's branch completion mechanism doesn't quote the branch name in
this case, so the branch name and anything after it is commented out.

Any idea how hard it would be to wrap the branch name in quotes
(possibly only when there's characters requiring quoting in the branch
name) ?

Thanks,

Dobes
