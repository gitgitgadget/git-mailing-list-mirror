From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: problems getting uptodate from a remote repository
Date: Tue, 19 May 2009 19:19:03 +0200
Message-ID: <fabb9a1e0905191019j73067de9h3ecf3f9dd9ab44e4@mail.gmail.com>
References: <33710F9891EA4BFD8ACD60798E354138@HPLAPTOP> <9719867c0905190908n2364da92s88ad646e8667298c@mail.gmail.com> 
	<9719867c0905190909q74e4a6b9r4857fb6f32ff394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:19:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Sya-0004bH-86
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 19:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZESRTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZESRTY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 13:19:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:13937 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbZESRTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 13:19:23 -0400
Received: by mu-out-0910.google.com with SMTP id i2so1667824mue.1
        for <git@vger.kernel.org>; Tue, 19 May 2009 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GYAiZmAQULCwY/xiQvHb4YwI5yCaxygQJIoyZp97EAA=;
        b=inF2D/LdjzxG/GTy6ed7QdNXr9ADZ5wWxRlwXnwhL6pE8keJ9nRO12RbncPRjCVqR6
         Hnx4oMoV8N//B8gFMJmFYrTUubrp/3F1oOMZekuy1yWi2SxW/q/5K/MXUHpvDHt7h5ym
         n1JoFjY/b+LFJr2xGk7ilCva80z535TsuH5BE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Bs0Np7ZMQBKSbMGZiGgZgjE15rcSJB4NfjgEiu/Y9KDzMeGYbcIga8z/F2HlKhsyIc
         FeuKmBBXPkxM3K/4CFfi5Yk54EtXhKUdEW1Kt+/e7c0+FDGtvZiIv6Zti6Fw3ps5ZqWv
         XDjKaOwI6zuDOVE5BBGOZTib7bpA6AB1SeO5s=
Received: by 10.103.252.17 with SMTP id e17mr174562mus.14.1242753563111; Tue, 
	19 May 2009 10:19:23 -0700 (PDT)
In-Reply-To: <9719867c0905190909q74e4a6b9r4857fb6f32ff394@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119553>

Heya,

On Tue, May 19, 2009 at 18:09, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
> I have done a 'git fetch' but the repo is not being updated to latest changes.

Fetch only 'fetches' the data, it doesn't update your working copy. To
get your working copy up to date you can do 'git merge origin' after
you do 'git fetch origin'. That is such a common operation that there
is a single command that does just that, 'git pull origin' will do
what you want :).

-- 
Cheers,

Sverre Rabbelier
