From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 12:28:28 -0500
Message-ID: <9e4733910711120928r6d9d08f0l22f3c6f0b2d80313@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	 <Pine.LNX.4.64.0711121613570.4362@racer.site>
	 <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
	 <Pine.LNX.4.64.0711121635130.4362@racer.site>
	 <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ird5Z-00009a-38
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbXKLR2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbXKLR23
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:28:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:47001 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbXKLR23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:28:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1600442wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 09:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Uh0ib6rL7uDrEfVrnSzqhxeDlsuhaHjetr3NVMMPkZY=;
        b=sZ8OsdrKCJl0Zk+tlchyaKPBMhEXuG8/Fa+Roq3Y7+WqNKGkqcP96FJxIuG0pIkwYUKo0gAGlVqwuk16aJMzwNZS2KOtb4P0D4rQW+A2mrACqpmLAF0oEEtdsi2W8Rt2lo8cFdu+7R2tMQQyZHTFOp32T3jH4HbKTJFNbNfgA1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t1Pa42no/EWTGF90M1vIZC96sipNn4w9huXxmJ/vnkvprlzztfGdKsjtybx0kBmiWNeUD9rg1n4E1qomy+B1iTrA/sFD4Mv2oZrX5kkMHaWi5Vwzce8MhV1hHkKAlMQACqa84MJ3aFxt/5mhmdSZU+QaByUDTeFBFWHS6S/rjWU=
Received: by 10.115.54.1 with SMTP id g1mr1307060wak.1194888508488;
        Mon, 12 Nov 2007 09:28:28 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 09:28:28 -0800 (PST)
In-Reply-To: <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64669>

Actually, fetching from kernel.org first and then switching the origin
isn't helping. The host is http only since I can't get access to the
git network port. When I pushed up my local repo it ends up in one big
pack.

I do this:
git clone kernel.org
move the origin
git pull
-- it still pulls down the entire pack and takes an hour

Will this fix it?
at my remote host, first clone from kernel.org
then push my local changes?


-- 
Jon Smirl
jonsmirl@gmail.com
