From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [BUG?] git-pull and git-merge don't support option --ff as the document says
Date: Mon, 29 Oct 2007 08:14:54 +0100
Message-ID: <8c5c35580710290014o5750214te5b20eaf6127de9c@mail.gmail.com>
References: <46dff0320710280936g4b1022fcpab02e72b99afa0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImOq6-0000qE-38
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 08:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbXJ2HO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbXJ2HOz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 03:14:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:29653 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbXJ2HOz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 03:14:55 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1992681wah
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/5GAbn6hP/5qe61pN93huz2L1TR82vv9wo/aco4FFwE=;
        b=RheKnCQZj7XPX3MKDW97cqCpvzcPXhBTBpw/fTAuBrFaQ5axYxaYhnVol47OhAMneDsXmt4UncN03AQhl4hkhp43XSeD6tb/eKRE+uNboxQhOnjUoqEBuTyq4LB0lzpWiN2m+o5s+12FcqyE33rVyGnEO1okkmRdJ15dLu0O1wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aYmt9271cJ+mUy1QBbZqmhExP+3lyBmQt842jPveQ9vTRjEetwg1kQXb1Ipn5XCHAhf/shk1QN0WH012aF2HJC5TRFrM9pARi9jv8Nh3NcNdLj1NAieZ87u3whrbEY7tgwUk3kcW2wDkwEZNyXDUhzBRpfSeDsexxfq+aCqiSDo=
Received: by 10.114.150.1 with SMTP id x1mr6658747wad.1193642094687;
        Mon, 29 Oct 2007 00:14:54 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Mon, 29 Oct 2007 00:14:54 -0700 (PDT)
In-Reply-To: <46dff0320710280936g4b1022fcpab02e72b99afa0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62607>

On 10/28/07, Yin Ping <pkufranky@gmail.com> wrote:
> Released git version 1.5.3.4

--ff/--no-ff is not part of any released git version; you'll need to
build the 'master' branch of git.git. And they're currently only
supported by git-merge, not git-pull (the same goes for --no-squash).

-- 
larsh
