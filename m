From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sun, 03 Feb 2008 16:28:16 -0800 (PST)
Message-ID: <m3hcgp5zvs.fsf@localhost.localdomain>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
	<20080203193024.GV29522@dpotapov.dyndns.org>
	<bq6x38lc.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLpCk-0005t4-Do
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbYBDA2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbYBDA2W
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:28:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:43945 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbYBDA2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:28:20 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1829256fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=jXRpkMchfo3U9AMvnGrErATT0NpxPOY4m2X+MAHOsyM=;
        b=BqSoRESR7LGApR/B8AcprkHralSyjwc2RNeXtWAap3Io49psH9d61PvYz2hrbeYnS1WH6pDNHNRTzrLBik9T88GGOipXQSsHaU6KFM6YI3e9xutlDnyiSmpTaM8qHV+0BJ9P75Ji8NFdzvGWrpfqt5ymMY2OjACITh5LkdPWr1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=KHIlp0fbayJKmzR7xNoY1GcIsPiJXIE/5rJQKqSjLaxhmgw97lcg9ntEem9D4ZZtOUXeL+aeXJuaVa7mztbSKy34FR2iW7ST87xyEVUp2R6v9i1SLBqn57+eQG7MpZeT30Ffwq4hiv+F9ThMlcy5bPb6EmbVQz8sjn5eem8olHM=
Received: by 10.82.187.2 with SMTP id k2mr11831733buf.19.1202084897184;
        Sun, 03 Feb 2008 16:28:17 -0800 (PST)
Received: from localhost.localdomain ( [83.8.194.5])
        by mx.google.com with ESMTPS id d2sm18119646nfc.11.2008.02.03.16.28.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 16:28:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m140S9I0008735;
	Mon, 4 Feb 2008 01:28:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m140S85Z008732;
	Mon, 4 Feb 2008 01:28:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <bq6x38lc.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72435>

Jari Aalto <jari.aalto@cante.net> writes:

> * Sun 2008-02-03 Dmitry Potapov <dpotapov@gmail.com>
> * Message-Id: 20080203193024.GV29522@dpotapov.dyndns.org
>>
>> ^-syntax is very natural to specify the _previous_ commit. Have you
>> notice we usually say "previous", not "one commit before"?

And you usually say "yesterday", "the day before" and not "1 day ago",
"2 days ago".

<rev>^  means (first) parent of commit-ish <rev>, or 'previous' commit.
<rev>~N means Nth parent in first-parent line of commit-ish <rev>; as
you can see full explanation is decidely longer.

> Only if you're grown with git. Everywhere else the concept of HEAD or
> TIP is more natural, thus progression:
> 
>     HEAD, HEAD~1, HEAD~2

The fact that other SCMs are poorer in expressive power doesn't mean
that we have to bend backwards and follow (well, not braindamaged,
just poor) other SCM limitations / conventions. Git is git is git :-)

So "everywhere else" doesn't matter any... unless in "SCM rosetta" or
something like that chapter in Git User's Manual.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
