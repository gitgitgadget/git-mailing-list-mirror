From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 12:29:40 +0100
Message-ID: <AANLkTinzQodqYsy5pdE6wNPGFCD-Y0oj2w_u_U-CtOyz@mail.gmail.com>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vitaliy Semochkin <vitaliy.se@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:29:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPv2-0007HX-4k
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab0KHL3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 06:29:42 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60718 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab0KHL3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 06:29:42 -0500
Received: by gyh4 with SMTP id 4so3245279gyh.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 03:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tnqvyqoCYnyX3CQi1qno7xiVDxxXI/Y5/2q1xX1Zdxc=;
        b=P9OSRO0yawVUhzYxTSp8Y//hjn1eJwdkROIk6luzg3UzSWu7HoVv2PKArTLyqUCKGy
         KlAX8I4vqOKCIln2x5iYPxdy7Wl90OJ0SURL7ffXeH1ASigpXomrHOAy1lWPyhQ2G5/f
         6/NnMi2yr7ys/H3DbzqyPX9DaEYUR/+jjNpSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rFLVKImD4EkZCEyLVGocg1q+7uYLIKHjBWGOE0xDoU0plTgczO+gZtN0uI4xAzAWIe
         G0zOf0tVFdfAExkuBwoeHDumAepVfP8VGWwSlU1qwxNSUrh4gJFphGbOEoQh6Xeak3RQ
         SQepIHRGgqgUuEOlyOjl/9nu8lwefvJN08pGs=
Received: by 10.90.4.6 with SMTP id 6mr5215161agd.16.1289215780515; Mon, 08
 Nov 2010 03:29:40 -0800 (PST)
Received: by 10.90.6.32 with HTTP; Mon, 8 Nov 2010 03:29:40 -0800 (PST)
In-Reply-To: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160928>

On Tue, Oct 26, 2010 at 21:47, Vitaliy Semochkin <vitaliy.se@gmail.com> wrote:
> I cloned a remote repository
> to check recent changes in origin/master I do:
> git fetch origin master
> git log origin master
>
> recently I found out that log doesn't show recent commits

The command "git log origin master" lists all commits
of the branch "origin" affecting the file "master".
Are you sure that is what you want?
Maybe you meant:

  $ git log origin/master # the history of upstream ("origin") branch "master"

or

  $ git log origin/master.. # changes in the active branch not merged
into upstream
