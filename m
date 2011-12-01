From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: workflow for component based design (newbie to Git)
Date: Thu, 1 Dec 2011 13:53:19 +0100
Message-ID: <CAH6sp9NdJDsZJAfD0TX_rfi8_Uw66JxSczs6-sz6MSXu4S8hiw@mail.gmail.com>
References: <CAO8zR6N_kxQHA+Z=ruA5T8cc1A6km8Y3RouXib6oRXPWHzfA6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ivan Dimitrov <ivand58@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 13:53:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW68m-0007ch-JG
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 13:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab1LAMxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 07:53:20 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62524 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab1LAMxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 07:53:20 -0500
Received: by qadb14 with SMTP id b14so116357qad.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 04:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nSS61ypWVVlbJHrdmTeM9Xn3vSbumLfpyLRhFTtMDUQ=;
        b=IkQz4dhLbblC3WCFf7nlxkP7CV1gxlezdW2O9qeLaiskoj6Yk683a7WHQoiwGXpZQd
         /oVI4YhIuTyUfbwHY2FRUS81sXtY6oAc/f1WKQAfDEeCSNU8BPsQL+ejTvvBFoKowaqd
         oUm/uhMcX3pIKQ7W0iPuV+qrKeCLf1CSZZ8CM=
Received: by 10.229.79.206 with SMTP id q14mr1255478qck.101.1322743999234;
 Thu, 01 Dec 2011 04:53:19 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Thu, 1 Dec 2011 04:53:19 -0800 (PST)
In-Reply-To: <CAO8zR6N_kxQHA+Z=ruA5T8cc1A6km8Y3RouXib6oRXPWHzfA6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186169>

On Thu, Dec 1, 2011 at 12:29 PM, Ivan Dimitrov <ivand58@gmail.com> wrote:

> Please forgive me for asking this, but I can't seem to find
> instructions anywhere.
>
> I'm planning to migrate from Serena PVCS to GIT, but I can't realize
> how to assign a label only to particular files (component) and how to
> apply the promotion model to my project with GIT ?
>
> So, in general, how one can handle a project with component based
> architecture (and workflow) with GIT?

In general one would have one repository per component (typically a
module). You can manage multiple repositories using git-submodule[1]
or an alternative tool like it. Labels are then tags for that
particular submodule. Labeling single files is not something git is
going to do, as it is tracking repository content rather than files.

Frans

[1] http://book.git-scm.com/5_submodules.html
