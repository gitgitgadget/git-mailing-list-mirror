From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Shallow clone
Date: Tue, 19 Aug 2014 19:01:29 +0700
Message-ID: <CACsJy8AhaiE0qjQhZfcd6pg5iYy129frvmQOkdR+zrVenuxhWg@mail.gmail.com>
References: <CAEfjWpHhLKpghGRFtzstndk_vYMkLSLAGfXx8agoQmakC-6Otg@mail.gmail.com>
 <CAEfjWpHmLXx7Cpyn-Pd+G7VpaXZhFSS741BFKY0kANrh49xt9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Steven Evergreen <i.stevenevergreen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 14:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJi7A-0004iN-AP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 14:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbaHSMCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 08:02:01 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:53052 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaHSMCA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 08:02:00 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so9474783iga.7
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eQW4Sq5nQeREwu9vcE++4/arcZeHSDJBwClHaAIb3qI=;
        b=VlzzD7gJKM9Z81lu49EwbNWaVenYgdC/QFuUT8uU1deJwIrww/Ahae1EoyR6UjUgKp
         8cU2jn2PwFdgxF+WqnPokARqqsEbWp48A9HJ1lqpp291twSzpwxYW5Z0yVLt6PVY4NGJ
         qm4RLLOIKjywECNaQjbh/yub1vApIWWMjZ8jFvE19EWJByZCgbI4CRtopQnmo/5go3Db
         WYk8XdPiRt/QTcaO5tT4x1iHfb9o/BtlXXY+93KoXX19VtvP3gh3CGKuJcAF+Z0wGjud
         kNsA50VWZVcPwsEznZKMbEHkRcsC3V69AYxzr08zi33N7lgc7FmPLnLPN7ZXiRzJcaTL
         sE6g==
X-Received: by 10.50.49.8 with SMTP id q8mr5273096ign.40.1408449719614; Tue,
 19 Aug 2014 05:01:59 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Tue, 19 Aug 2014 05:01:29 -0700 (PDT)
In-Reply-To: <CAEfjWpHmLXx7Cpyn-Pd+G7VpaXZhFSS741BFKY0kANrh49xt9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255456>

On Tue, Aug 19, 2014 at 6:11 PM, Steven Evergreen
<i.stevenevergreen@gmail.com> wrote:
> Hi, everyone. I'm trying to perform a shallow clone with visibility of
> all remote branches.
>
> git clone REPO --depth 1 --no-single-branch
>
> is consistently giving me
>
> Cloning into 'REPONAME'...
> fatal: (null) is unknown object
> remote: Total 0 (delta 0), reused 0 (delta 0)
> fatal: recursion detected in die handler
> remote: aborting due to possible repository corruption on the remote side.
> fatal: error in sideband demultiplexer
>
> with 2.0.3 .
>
> Is this command not supported? Have I hit a bug?

Yes it's supported and yes I think you hit a bug. Any chance you can
share this repository? If not, perhaps just SHA-1 so we know what the
commit DAG looks like?
-- 
Duy
