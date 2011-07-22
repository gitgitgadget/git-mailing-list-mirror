From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 11:30:27 +0200
Message-ID: <CAP8UFD0FG47D0hV8ifj1p7bRfEXJ7Ez3mTw4Yv-KUWXPJnWLOg@mail.gmail.com>
References: <20110721125544.26006.qmail@science.horizon.com>
	<1311263869.9745.72.camel@drew-northup.unet.maine.edu>
	<4E2852A1.30800@cisco.com>
	<j0a9te$vcv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?UMSTdGVyaXMgS8S8YXZpxYbFoQ==?= <klavins@netspace.net.au>
X-From: git-owner@vger.kernel.org Fri Jul 22 11:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkC42-0001MO-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 11:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab1GVJa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jul 2011 05:30:29 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59826 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1GVJa2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2011 05:30:28 -0400
Received: by gxk21 with SMTP id 21so1091629gxk.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P/YUw7544tXeTprT7qdjBX5GKCo/RNiygBOEOa2Yq90=;
        b=ifvvTsP5wwXfqNYUf4XXnH/sOB2W2NpaSQHVgKzdhH5X8SBAuF3wmlvQsnZiW8wtpW
         cnroRgtMzqNO44E9mocT/f0EBlLZSNHE60ULSDY86U1KvkKAOZ3k8lKKSZGxqknC+E8V
         NbAk792idqlMbFZ66FhmZ2N0pijIJYUam0ajE=
Received: by 10.236.182.200 with SMTP id o48mr1736482yhm.23.1311327027746;
 Fri, 22 Jul 2011 02:30:27 -0700 (PDT)
Received: by 10.147.169.7 with HTTP; Fri, 22 Jul 2011 02:30:27 -0700 (PDT)
In-Reply-To: <j0a9te$vcv$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177639>

On Fri, Jul 22, 2011 at 12:40 AM, P=C4=93teris K=C4=BCavi=C5=86=C5=A1
<klavins@netspace.net.au> wrote:
>
> The beauty of Git is that no two copies of a Git repository as a whol=
e are
> the same: =C2=A0some people make shallow copies; =C2=A0others prune a=
way all branches
> except for the one they are interested in; =C2=A0yet others graft tog=
ether
> multiple original repositories. =C2=A0The upshot is that two copies o=
f the same
> repository may end up having different commits as their root commits,=
 and so
> the generation numbers computed for their repositories would be diffe=
rent.
> =C2=A0Indeed, the shallow repository copy could later be filled out w=
ith
> additional underlying commits, and so on.

Not only people want different repos, but with their own repo they
want different "views" (or "virtual graph") of it.

> Given this context, I can't see the value in fixing generation number=
s
> within commits. =C2=A0In my mind generation numbers are extremely use=
ful
> transient helper objects in every Git repository but they have no mea=
ning
> outside that repository, sort of like GIT_WORK_TREE.

It's not even per repository that they have a meaning, it's per "view"
of the commit graph.

Thanks,
Christian.
