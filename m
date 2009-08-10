From: John Tapsell <johnflux@gmail.com>
Subject: Re: give a hint/solution for "It looks like git-am is in progress. 
	Cannot rebase."
Date: Mon, 10 Aug 2009 16:59:03 +0100
Message-ID: <43d8ce650908100859m50379376y410a67b69244f38a@mail.gmail.com>
References: <acf3f2e60908100734l6388d9a8k90ed835304a69918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lucian Adrian Grijincu <lucian.grijincu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXHE-0004SO-My
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbZHJP7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 11:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbZHJP7D
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:59:03 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:50734 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbZHJP7C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 11:59:02 -0400
Received: by yxe5 with SMTP id 5so3916659yxe.33
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L9yzlFH2IEhbIQu7aq90sqJI6b6lrYQstwnd53gduOU=;
        b=SCpCa8VFuoPHftS7Qhc1m1iZ+aT7WYepFcAtf3UMtkKM7k9MnW/lW2GKKYbd9VUY7A
         ROmXeQPVsiMWMGNdJEA7Osm3xcnOo99jLS1mhe6f82J0/CeQwOfsrSiYWVTRpWTGN5AM
         nxbVdmsnGaMXUTvqCnKOruprsrFic5fZPhgaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ektHm0VWPTYJQ0lCt5hSYeGg6DEK7GTmP2zk3jHfEKsfJsqdMd81v2AeHvALEBYXU3
         aVtJlscK51UqdMRVAACIboZF2Wc39SYfJmY/Ih51PD8YT7IBaBmwiLNSynK2bVxvglZL
         WYpuisuyPbp1qTGSywfvNQjzthmsGRg/wzjvU=
Received: by 10.150.91.1 with SMTP id o1mr8524093ybb.239.1249919943045; Mon, 
	10 Aug 2009 08:59:03 -0700 (PDT)
In-Reply-To: <acf3f2e60908100734l6388d9a8k90ed835304a69918@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125472>

2009/8/10 Lucian Adrian Grijincu <lucian.grijincu@gmail.com>:
> Hi,
>
> I ran git-am instead of git-apply on my repo. The git-am complained
> about the input data, I completely ignored it because I never use
> git-am (except on typos + tab-completions like today).
>
> Later, after a few commits I wanted to rebase (interactively) my tree
> to merge a few commits.
> =C2=A0$ git rebase -i HEAD~4
> =C2=A0It looks like git-am is in progress. Cannot rebase.
>
> Ok, the message is nice, it tells me it can't do something, but I'm
> stupid enough not to know how to proceed.
> I see that this message is the same in HEAD (master and next).
>
> It would be nice if git would output one or two hints. For example:
> * run "git cancel-a-git-am-in-progress" to cancel a git-am in progres=
s
> * run "git commit-the-git-am-in-progress" to commit the git-am in pro=
gress

+1

git am --help  suggests  --abort      btw.  That would be the most
obvious guess :-)



> Of course, the commands need to be replaced with some valid git
> commands, but I don't know which those commands are :)
>
> The message is generated in git-rebase.sh by this code:
> =C2=A0test -f "$GIT_DIR"/rebase-apply/applying &&
> =C2=A0die 'It looks like git-am is in progress. Cannot rebase.'
>
> For now I think I'll `rm -rf .git/rebase-apply` (and hopefully not
> break anything).
>
> --
> =C2=A0.
> ..: Lucian
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
