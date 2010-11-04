From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: can subversion 1.6 be made "just as distributed as git"?
Date: Thu, 4 Nov 2010 10:26:16 +0100
Message-ID: <AANLkTim0N99M488k3vR5zVDkZv7Wz-08hRwdy0jaHh4c@mail.gmail.com>
References: <loom.20101104T014408-903@post.gmane.org>
	<BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MDellerus <mdellerus@yahoo.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:26:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDw5R-0000qV-1X
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0KDJ0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:26:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42685 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0KDJ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:26:17 -0400
Received: by fxm16 with SMTP id 16so1252904fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Jd1cUwbB7l9DcrIiXaBy+dF5b2FDhQmKZNR7mgZ9UZg=;
        b=gkEgB1DggdtP8y5V0+9QaYDO95zMPjWnH8X47H/zeIzbD7819zycyfNZ/oJBgazY+w
         qbXyB8smcUJB/6bsbiVGh4dmPqiF/Bo4oqWe8d+hqKKz6G4FUqb6TESYJdeENui1s/PW
         moDz+z4IXcTjyTlEnWEWlpkjEIRe3JmDLqYnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fp6lCce6BkNHlcKOFEUB5UV+S1o48Y4K45Hh2SwvmyWOYkExfqnNlOPcNd4i9Elk9W
         Tgn7VC/Y/83zB+AUKzGDohLTvRCI2JRgfbFXiA+/xQT9q8OckjhT6EnSLz+1zOyGZmP0
         qFkbf688yr3Y2nGZrQqt4bserxxYeRmO34vXU=
Received: by 10.223.115.203 with SMTP id j11mr415912faq.35.1288862776085; Thu,
 04 Nov 2010 02:26:16 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Thu, 4 Nov 2010 02:26:16 -0700 (PDT)
In-Reply-To: <BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160702>

On Thu, Nov 4, 2010 at 01:58, Kevin Ballard <kevin@sb.org> wrote:
> Using "svnadmin hotcopy" you could certainly get your own local repo, but I fail to
> see how you could easily join your history up with someone else's history using this
> mechanism. If you really want to use SVN in a distributed manner, I would recommend
> you simply use SVK.

SVK gives you *disconnected* SVN, not distributed. You still can't
(easily) share your
uncommited revisions with others. It just solves the problem of you
being on a plane
for a few hours. It doesn't turn SVN into Git.
