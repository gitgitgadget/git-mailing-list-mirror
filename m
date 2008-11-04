From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: More help needed on merging unrelated repos
Date: Tue, 4 Nov 2008 23:30:56 +0100
Message-ID: <46d6db660811041430l74d9a100kc15ac46dea8ff63f@mail.gmail.com>
References: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com>
	 <4910ACCA.7080007@op5.se>
	 <46d6db660811041308o19f1131dm4d49b6703fa6d22b@mail.gmail.com>
	 <4910C6F4.5010407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 04 23:32:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxURe-0004QA-40
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 23:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbYKDWa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 17:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbYKDWa5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 17:30:57 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:8265 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYKDWa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 17:30:57 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3464162wfd.4
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 14:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gi7bTka/BhcOXMdm2LDK3EcdkrfHCtRauF9YocU95bo=;
        b=BJaYcNbSqhW2nNiwcBVb/qlfe0yeG+oZyYTD2JDY8kSe8QvgqJoaqQTqHtFSREj1ZJ
         xcZ/NeeVT5v1u3vYBGOty1IDSw3WBDygFycQTBH0FyDsyDAZ9koLEzizMc3eY9aaOeXQ
         Bzi2SQjKIMamEY/FkWOeIvozESZddBOwZoLsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZY7k16esAn6krsII9SWZfUup2yZI3mNNpyliGZjIzyL6U26xCYbyayufEaVhA4cjww
         U1SZJMcLGFUUL2Mwvo/TTDtEUDh+bPN4kt98BmyWh2vI4DhZbPwh6clemmaRjQnu4q2N
         hSFBWFSJsD1v6BiK5abGjp0dqz3DLyhNO3sVE=
Received: by 10.142.52.9 with SMTP id z9mr52848wfz.201.1225837856530;
        Tue, 04 Nov 2008 14:30:56 -0800 (PST)
Received: by 10.143.1.15 with HTTP; Tue, 4 Nov 2008 14:30:56 -0800 (PST)
In-Reply-To: <4910C6F4.5010407@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100109>

On Tue, Nov 4, 2008 at 11:04 PM, Andreas Ericsson <ae@op5.se> wrote:
> Ah, right. Octopus merge always does merge head reduction, but to do
> that it needs to find a common ancestor. When no such ancestor exists,
> it will fail (with a message like "shouldn't be doing octopus merge"?).
>
> If there's no "--no-reduce-heads" option to "git merge", I think you're
> screwed with getting that to happen in a single commit.

:(

>
> Oh wait.
>
> git merge i1 && git merge --no-commit i2 && git commit --amend
>
> might work. I'm still shooting from the hip though, and now it's far too
> late for me to think more. gl though.
>

it's late for me too!

$ git merge i1/master
Merge made by recursive.
 a |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a

$ git merge --no-commit i2/master
Automatic merge went well; stopped before committing as requested

$ git commit --amend
fatal: You are in the middle of a merge -- cannot amend.

note the merge can work, but it's still done in 2 steps. :(
thanks for suggesting this.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
