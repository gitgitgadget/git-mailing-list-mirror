From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Reverting to old commit
Date: Tue, 27 May 2008 21:32:13 +0200
Message-ID: <bd6139dc0805271232x53e91c0fx699c1ea0769e50ec@mail.gmail.com>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Tue May 27 21:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K14v4-00022r-7I
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 21:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbYE0TcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbYE0TcW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 15:32:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:25216 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbYE0TcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 15:32:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1693258ywe.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UZEOGXAVMb7f+dxCnA3n8cEambdGBLroMlI+4CPPRls=;
        b=rWMcVRnS1TdbCp5KxsRqcyYSEkOg97ze6lVrGXIaQ4qww2Hr5k9Jboc9UrQOKt2XtOqkz4kOtwUHUTOLi0ezA6/wWHxtu5KsePXZQumgGGHKT9FK7Ky0o5c1kEipe+GNZjDCnxuUsRNzl4k351YJ3L1+mJDwfli2f0Z2apFwZHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LDjeizO8cIYUlMLb/8REkO3KI8iux4ivDsoxcCv5By4JAtnwx7sQ64Dr4awprzBDuNW/faO+t0sluGm5+gLBEH/AxaCpt/qgIGvaOUkz7Fs/i9iX6lC5w4iHY9d7e/9f0cQlVxYMQb8TXXID1F4Skubz6SVR9VZLYnCk9umVo5U=
Received: by 10.143.33.19 with SMTP id l19mr661584wfj.112.1211916733624;
        Tue, 27 May 2008 12:32:13 -0700 (PDT)
Received: by 10.143.10.16 with HTTP; Tue, 27 May 2008 12:32:13 -0700 (PDT)
In-Reply-To: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83037>

On Tue, May 27, 2008 at 7:50 PM, Marcus <prima@wordit.com> wrote:
> Newbie question: What's the simplest way to find an old commit and revert?
>
> Say you have a version from yesterday which worked and today's
> experiments failed, so you want to go back to that working version.
> Unfortunately, it's not tagged. Instead you need to actually view the
> code to identify the version you want. I thought maybe gitk might
> help, but I can't find my way with gitk. I hoped you could browse
> revisions easier in a GUI and tell gitk or git-gui to revert?

Have a look at the reflog (git reflog) perhaps combined with "git log
-p" which will show the changes each commit introduced as well.

-- 
Cheers,

Sverre Rabbelier
