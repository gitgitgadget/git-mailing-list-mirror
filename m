From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Editing Git Log
Date: Thu, 18 Sep 2008 09:13:50 +0300
Message-ID: <48D1F19E.60907@panasas.com>
References: <48D1ECB4.9080808@tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piet Delaney <piet.delaney@tensilica.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCnj-0001g4-0y
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbYIRGN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755629AbYIRGN5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:13:57 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13884 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbYIRGN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:13:56 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1576444eyi.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=Y+zBGWemfi/lIrgPzFVTggrkfVLTe4MH6Yh46D7bKKQ=;
        b=owD4Y5x4uMs5NUkDTpUXYI0GIO4cJVesUkZjeAZo9S5h85GWsS6nWhh35zc9s6haNA
         Jvo4Nc5epl8VxQv3/SuNmCBFYvmW+9mN28WSMDZB0/zmxoO8BqVTSREaQruLeQ+m+nPe
         TBQemELerLFgmLsiDN5tuuPZddWd/NEK18hSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=YxADD2l0Lso1CF5u/T3nCZwjfF6nGiF8qHFiXbwq8j6DK7UDjERppEctgvfOtKK23s
         71T3iS9WvxNiEjfj1vip04ejyVoLsu5jxdPKAPhfOtqIWHkrjg8tgXmxuglz6Jktto+8
         b4OOA0fMna4MhGpqSUz56Tf7ea4PnEDWB7otQ=
Received: by 10.210.77.2 with SMTP id z2mr4404969eba.96.1221718435490;
        Wed, 17 Sep 2008 23:13:55 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id 31sm24546195nfu.9.2008.09.17.23.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 23:13:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48D1ECB4.9080808@tensilica.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96163>

Piet Delaney wrote:
> I think I recall reading that a feature of git was the prevention of the 
> git commits
> from being changed. I noticed today that a couple of us have checked in 
> files
> without our customary [XTENSA] architecture prefixed to the 1st line of our
> Commit Messages.
> 
> I couldn't find a way to do this, other than our reverting back to a 
> earlier repository
> and recommitting (each?) change with the slightly changed Commit Message;
> not an attractive investment of our time.
> 
> Any suggestions?
> 
> -piet
> --

git rebase --interactive FIRST_BAD_COMMIT^ will effectively do the same
as above but in a nice automated way. Just change pick => edit on these
patches that need fixing, you'll see.

Boaz
