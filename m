From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: How to merge some specific project folder into an empty branch.
Date: Tue, 21 Jul 2009 14:48:57 +0800
Message-ID: <4A6564D9.10901@gmail.com>
References: <1248158311445-3293753.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: zoucunliang <zclgibson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 08:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT9A2-0006mE-9k
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 08:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbZGUGtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 02:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZGUGtF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 02:49:05 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:33146 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZGUGtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 02:49:03 -0400
Received: by pzk42 with SMTP id 42so321549pzk.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=RSTO6p01tVofW94/xEbTMRAjS4Vs+kmdS10Ppn+VSLw=;
        b=KZI/2amVJWDi053uQQNZup/x9s+NF8HypluT0U9ZFvzyCUQHq4/K2T9lOL5Ubc7Nrh
         QHYGF9wU2YL5Tpe95+hNwpEsveUmpLcS+A7phVysmtNydGiPwiWL7vaEbCZPQCNAO4iJ
         iSl5Oqtc5n4Lft8aenuozdypxDKFgyRI+ZVt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=IkktZ81yjGuTjMkIGX7CRQ1fPvUdUv5n1JtstsauOz47VK7XMhu/oNeM1MtO5637Rw
         dBCtc3mHUMOqnVMAy1PUe4O3WBFpui+T2S/gajxYGYcj8AXTr5vygVePPkdGSARsvYwI
         1r1HPSeL7KvTolJLcSpz/NOEXjV9k5bXixp1c=
Received: by 10.143.14.6 with SMTP id r6mr1358559wfi.24.1248158943240;
        Mon, 20 Jul 2009 23:49:03 -0700 (PDT)
Received: from ?192.168.1.200? ([58.33.2.161])
        by mx.google.com with ESMTPS id f42sm26032327rvb.1.2009.07.20.23.49.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 23:49:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <1248158311445-3293753.post@n2.nabble.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123646>

zoucunliang wrote:
> Hi all,
> 
> Currently i want to merge one project into another git branch. For example I
> have a branch name A and there is a project called p1 under folder
> projects/p1/. and i have a empty branch B. i just want to merge project
> "projects/p1/" into my empty branch B. But I don't want to merge other
> parts(for example projects/p2). Can anyone help me please? 
> 

OK,

I'm not sure if I understand your question clearly, but let's see if
the below will work for you:

# git remote add p1 ".../projects/p1"
# git fetch p1

And assume the branch you wanna merge in P1 is C

# git checkout B
# git merge p1/C

Yet I see no benefit of doing so with project p1 and p2 to be very different.
