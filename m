From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: HEAD file location
Date: Tue, 24 Jan 2012 09:22:09 +0530
Message-ID: <CAMK1S_jJUJvEz-OY0cMz1LFDSd71zuWhnSfYbg_sVi5DO-JJOQ@mail.gmail.com>
References: <loom.20120124T043119-263@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mfine <eboats@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 04:52:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpXQd-0001jZ-P2
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 04:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2AXDwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 22:52:11 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:63581 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753888Ab2AXDwK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 22:52:10 -0500
Received: by obcva7 with SMTP id va7so3812735obc.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 19:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qvvM3mldU0YtTbnlHvB5jllLLIiuu9/jJf/KeM9lR9Q=;
        b=Wb7XEC4zWIgyJCF1Gt+NnpmbmmKw7+38Vt5xE3FVa8jvY2HoiSfq9naR8ADARvZ43l
         6de8HC3vMUYiuR7le/4U1DBP0/OVUxz+3JITMccDb4BUmYp7FNO5wxvP0SZxzdOm/BE6
         gkD570ycOJLAXqE96j/gqB4PyZZ5afCda8o0c=
Received: by 10.182.132.105 with SMTP id ot9mr10272002obb.34.1327377129746;
 Mon, 23 Jan 2012 19:52:09 -0800 (PST)
Received: by 10.182.51.170 with HTTP; Mon, 23 Jan 2012 19:52:09 -0800 (PST)
In-Reply-To: <loom.20120124T043119-263@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189037>

On Tue, Jan 24, 2012 at 9:12 AM, mfine <eboats@gmail.com> wrote:
> I'm working on a Git project and had a question about HEAD.
>
> In our remote Git repository, I see the file
>
> git_repo_home/HEAD
>
> and another file
>
> git_repo_home/refs/heads/HEAD
>
> The content of the former file is =C2=A0refs/heads/master =C2=A0which=
 looks ok because
> we want HEAD pointing at master.
>
> However, should the latter file exist? =C2=A0I had thought only branc=
hes
> should exist in /refs/heads and HEAD isn't a branch right? =C2=A0I'm =
wondering
> if we erroneously created a HEAD branch.

Yes.  Someone did something like 'git push origin HEAD:HEAD'
