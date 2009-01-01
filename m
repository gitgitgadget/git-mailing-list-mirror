From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: git has modified files after clean checkout
Date: Thu, 1 Jan 2009 03:48:05 -0500
Message-ID: <81bfc67a0901010048l7a4a8fa1h42f7cd448dfc704@mail.gmail.com>
References: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com>
	 <402731c90812311541v28ac9617ge52e0e5c0f1298d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 09:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIJKG-0004Jk-Mz
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 09:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbZAAIsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 03:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbZAAIsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 03:48:09 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:61260 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZAAIsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 03:48:08 -0500
Received: by bwz14 with SMTP id 14so19129112bwz.13
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=R/F2jx8RIBQtMbYuOiMUBqmkTw7K62Ph6hv16D3aD0I=;
        b=SfowwmaNc8SIWHtZe03+2i8IRZVSybcysLANeqVbS88Y/JaBCMcNQKO5zlQ81hJNac
         xcGauJ+J4OV0IgiD3Hgb4OCo1HZlHUZ9VeJBDglu8C5KglYvRvdWzwNqNpl914fE4xe9
         G2ojdiLH0d+P4kYJ6G+oHm6n0EyGuM5vyK7R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u7C0tfOzX0Rb1sH+yNDwoApoH8kNLK4aggmuKXfrYnedMuWFrDWJjOo7c7rdSU0w+9
         +Fu91F0barLgXgc2XTPwBs3vZb9wXAibipUyXwXNz29tgnjrcNiDcMN8Uwdf4fUa2bIt
         tDsSiO8TX4++25B6S/XMNGyLz0h8IQiyiRTuU=
Received: by 10.223.112.201 with SMTP id x9mr12079210fap.69.1230799685376;
        Thu, 01 Jan 2009 00:48:05 -0800 (PST)
Received: by 10.223.107.205 with HTTP; Thu, 1 Jan 2009 00:48:05 -0800 (PST)
In-Reply-To: <402731c90812311541v28ac9617ge52e0e5c0f1298d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104293>

>  The files you mention contain CRLF.  Do you have core.autocrlf set
>  globally somewhere, perhaps in your ~/.gitconfig?

yes I have it set to input

>  Anyways.. like I said -- I couldn't reproduce your problem so this is
>  pure speculation on my part =)

it's inconsistent although I see something more often than not, and
only with this particular repository. Sometimes it's one set of files
other times it's others. this time it was 2 sometimes it's more like
40 (just throwing numbers around) and that can be the same unchanged
clone. seem to happen on checkout. heck even noticed a git reset
--hard HEAD didn't clear it all the first time today, in one case.

after sleep I'll see if 1.6.1 fixes my issue.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
