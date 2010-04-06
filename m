From: Tim Visher <tim.visher@gmail.com>
Subject: Getting rid of a stale remote?
Date: Tue, 6 Apr 2010 14:03:55 -0400
Message-ID: <x2jc115fd3c1004061103z3154b6b3ge34493260f12925e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 20:04:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzD8V-000121-To
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 20:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab0DFSEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 14:04:23 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:61674 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0DFSEW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 14:04:22 -0400
Received: by ywh2 with SMTP id 2so67403ywh.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=aYldU5ZZ1Qwyyua/CPPlwBHcoNzz8kiz9fALCDUE+Vw=;
        b=lLhcMeiWSg+KYQMxAh3cWoKZORoP43+8Zh8Tdz0kdxuXTIGV5Nw/7J4C0aI0BRf1uB
         XeIqme0z+/op9frhjWH8vVwS7f6MT6jiZCiNWWBHN8c4swgOWApIVj8wqcqVqKSytxr7
         rsY7NS0orwRkKOJxoTKVdvXj5RyLZYhJ2zPf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=S5/El/3ZpUCOGzJaLVazCHHsixxbCt1eU5wDgbytdu41GGRR2HNzYTA/cdMRtb6CWw
         fdFvzXKEEgS99saguHrw2ur0WwmQrJAIjhnsZF5dftIFrVPADF2znx/t3ZiJWnNbKAg4
         UIdJXDKH04WeV8Oew/PmzXKksnkGqfibocBCM=
Received: by 10.100.209.20 with HTTP; Tue, 6 Apr 2010 11:03:55 -0700 (PDT)
Received: by 10.101.190.1 with SMTP id s1mr17032179anp.32.1270577055388; Tue, 
	06 Apr 2010 11:04:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144162>

Hello Everyone,

I'm trying to get rid of a stale remote.  I deleted the remote via
`git remote rm <remote>` and that removed it from .git/config but for
some reason the references stayed in the listing of `git branch -a`.

How do I get rid of the listing in `git branch`?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
