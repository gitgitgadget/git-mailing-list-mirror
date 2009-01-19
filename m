From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib: add 'git difftool' for launching common merge 
	tools
Date: Sun, 18 Jan 2009 21:32:17 -0800
Message-ID: <402731c90901182132i28f62474kae7595f89e2abdae@mail.gmail.com>
References: <1232092802-30838-1-git-send-email-davvid@gmail.com>
	 <200901182025.24045.markus.heidelberg@web.de>
	 <402731c90901181634u32b39c87t6e88d9efef0d3485@mail.gmail.com>
	 <200901190603.06506.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Jan 19 06:33:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOmla-0003oa-Uy
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 06:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbZASFcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 00:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbZASFcT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 00:32:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:34155 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbZASFcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 00:32:18 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2464565rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 21:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ot3EBWkmvkRDRSu61Cce8I563LpyqKaboFzTQ/Ioqo=;
        b=IQbKJlYzRggmMou+vgT1NwHf234K4N5dqq80fdKMeZseLiEx65zVOMQ0jdnU+ma9Gr
         OMmVggCqV01F7O6tqMcJRaZMTrriO3dXxMcuRbjq670o4ixiD6CJPd4sgcAqDurdVrxy
         u+M36wDptpBm7YvYl80GJ+Sv8vEtbz9vD2EgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bRNQSuTKHF/DLdPI8XKB4lwu8NEuMvJ/doHcRXmU/ma5g2Wd/hYZV38a1mEhz+AcOz
         W7BCvqRSzzvtmM1QtFEPpcPAKIBniR7lS0syf/QaNmSTdcb/MKu1htIeVqICgHXgdi/U
         zKDRPj1jchE+oY2iILuQ72tfhKn3AKFHJFHcI=
Received: by 10.142.199.10 with SMTP id w10mr935083wff.94.1232343137349; Sun, 
	18 Jan 2009 21:32:17 -0800 (PST)
In-Reply-To: <200901190603.06506.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106324>

On Sun, Jan 18, 2009 at 9:03 PM, Markus Heidelberg
> Well, in "wincmd l" "l" doesn't mean "left", it doesn't mean "put the
> cursor into the left window", it just moves the cursor into the next
> right window. So "wincmd r" doesn't mean "put the cursor into the right
> window", but "rotate the window" (see :help ctrl-w_r).

oops.. i should know better.  sorry... let's ignore 2/2 for now then.
I'll resend.  duh.. I should have known better.. h left, j down, k up, l right.



>
> So with "wincmd r" the local file would be moved to the left side and
> the index file to the right side, still containing the cursor. Not what
> we want.
>
> With "wincmd l" the local file would stay on the right side, the index
> file on the left side, but the cursor would move from the left to the
> right side. Now we can edit the local file.
>
>> > You have deleted all the '-' chars from git-command, but when using it as the
>> > name I think it's the preferred method, only when used as command then without
>> > slash.
>>
>> I was wondering about that.  I think I tried to follow the lead from
>> the git-diff.txt documentation, but "diff" is a builtin and thus
>> doesn't have an actual git-diff, so I see why they should be
>> different.
>
> Hmm, I don't think it makes a difference, whether it's a builtin or not.
> git-diff only exists behind the scenes, invoking it as "git-diff"
> doesn't work anymore with default settings. On the other hand, I can
> also invoke "git difftool" without the slash, git can find it. The same
> way I can for example call "git svn", which also isn't a builtin.
>
> Markus
>
>



-- 
    David
