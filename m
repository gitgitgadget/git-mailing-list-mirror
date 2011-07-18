From: Mike Shal <marfey@gmail.com>
Subject: Re: git show-branch --topics and merge commits
Date: Sun, 17 Jul 2011 23:37:47 -0400
Message-ID: <CA+6x0LXHKZgvW4_hWz8qrWQshqxB3pQ-=08itqnV5smA_NCrBA@mail.gmail.com>
References: <CA+6x0LWXz-SpnZjdiV3UKJzUz3+0LiMOsbZHTn2gJ+v6bPGndA@mail.gmail.com>
	<7v8vrwl46q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 05:37:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QieeX-0001QH-M2
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 05:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab1GRDhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 23:37:48 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60007 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab1GRDhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 23:37:48 -0400
Received: by vxh35 with SMTP id 35so1371927vxh.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 20:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=sLorQcPnY63hptfYAdxJF7u5r1v8x0okjDCpr4IJMew=;
        b=iYh0KRIq7vN7HaRWV6zqZgeU9oxFigV/g2JMaZsbe3sCcsf3Yp0Vb/+5lCXwceb/6M
         9rD+sWppLASou2skXSDy6ddS0E9iYhfshqCVCVWnI3ZwgKqYdrWt+jdysF4gWHt//V8R
         UaaqVUUGoxbOCsZa4BT/84Pjho/18TIT+aDSM=
Received: by 10.52.180.8 with SMTP id dk8mr5687173vdc.377.1310960267221; Sun,
 17 Jul 2011 20:37:47 -0700 (PDT)
Received: by 10.52.188.102 with HTTP; Sun, 17 Jul 2011 20:37:47 -0700 (PDT)
In-Reply-To: <7v8vrwl46q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177334>

On Sun, Jul 17, 2011 at 10:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Shal <marfey@gmail.com> writes:
>
>> So rev-list shows my merge commit and the 'new' commit, but
>> show-branch --topics doesn't show 'new'. Is this the expected
>> behavior?
>
> Yes, show-branch was specifically written for people with strict sense of
> project hygiene who do not merge into their topic from upstream (which
> would turn the branch from "place to hold commits on this topic" into
> "place to hold commits on this topic and unrelated random changes made in
> upstream").
>
>

Ok, makes sense. Is 'git rev-list' supposed to give the same list of
commits then? In my example, rev-list shows the commit on the branch
even after upstream has been merged in. My confusion comes from this
line in the man page of git-show-branch:

   When given "git show-branch --topics master topic1 topic2", this
will show the revisions given by "git rev-list ^master topic1 topic2"

Thanks again,
-Mike
