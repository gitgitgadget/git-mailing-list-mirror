From: Russ Brown <pickscrape@gmail.com>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 14:00:39 -0500
Message-ID: <46FBFDD7.1080300@gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Pierre Habouzit <madcoder@debian.org>,
	Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 21:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaybY-0006cy-UH
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbXI0TAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbXI0TAu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:00:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:17773 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbXI0TAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:00:49 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1129122wra
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=5BrtZiDkh99gDhHA8+bj8O+GO2vaonBhr96N4EU7rJQ=;
        b=Xbw3kmoYv5szoygHrnbD1SvlXYlqTAgVCK+M9HyCqrPoqNyWnuRYfBw2IoSIZn5n5ZZQnkzNkxP7p1WjAM9Fip1KmTcuLaf0Tqcc2MIkOheUzGyPfbh4Ylef6p8HULaafiVz5YnRHWuyB64BW1nz3pcVVQWiAoJyMD0qlzQInSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ny8hR/ufJQltBYBQOyBTgb9lqdbYRUINZrs/aZcj7u319TBTVkanCD6aFTPt5Tvmvm2+MoIHMzcX3Fo/Ie7czpvNsshLPT5K1keITzy0lKnRAATHwaf2XBst/lyB3CtT1LAXbqjDLDyj3oN8wxGD/zAsMt6IpW98UDbv84bczMs=
Received: by 10.90.102.20 with SMTP id z20mr3556536agb.1190919647830;
        Thu, 27 Sep 2007 12:00:47 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id s30sm3526493elf.2007.09.27.12.00.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 12:00:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <20070927185707.GC12427@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59311>

Pierre Habouzit wrote:
> On Thu, Sep 27, 2007 at 06:31:19PM +0000, Kelvie Wong wrote:
>> At work, I've been using a git-svn import for my daily workflow (still
>> somewhat of a git newbie, but now has come to the point where it's
>> tough to work without it), and while rebasing from svn (on a rather
>> old branch), I found that the mergetool option does not work too well
>> for me.
> 
>   Which tool are you using ? kdiff3 ? I've noticed that it often fails
> miserably, or worse, create bad merges silentely with it.
> 
>   And as none of the other merge tool that are supported are able to
> either do 3way merges, or have a decent UI (that definitely seems to be
> exclusive features) I've given up on git-mergetool (and to be fair, it
> sucks, because it could be _sooo_ useful sometimes).
> 

What about meld? That does 3-way merge, and the UI is fine.

-- 

Russ
