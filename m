From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 is not cloning perforce code properly
Date: Tue, 10 Feb 2015 15:27:59 +0000
Message-ID: <CAE5ih78VwwSFcXxXopbmKFoi_HP_9RU_KQFr_h5GRyfeq8b73w@mail.gmail.com>
References: <1423576488362-7625215.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Sandeep <varshneysan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:28:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLCjY-0004W2-KO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 16:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbBJP2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 10:28:10 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:54248 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbBJP17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 10:27:59 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so32421658obc.11
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vpSIGLrESdHs8CmuKlQoGUMrxdcwuaFpvfUbK+JEtZo=;
        b=ggUyyaNyTCMRVF5deaHDrGvDlkbKKXdSUArL80SSrreP2U0u+6cgHxi9uE7s9mS328
         kZwkQB3We7ADPbepEdYgZR+dxjMMpBtjJu5l6580P/u69J0MFt/BojtLWoo8tW9HQ5pc
         xEkV22kd/r6VmfOHPhvVD+PiqyxbWiWNWYTFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vpSIGLrESdHs8CmuKlQoGUMrxdcwuaFpvfUbK+JEtZo=;
        b=lKaMcK2RZQC5+llGskp+F/KeWpGbzHRZSmNygFDFZj9MSiFk2Dn71yOUQO4Ceejh21
         kU+aAya7q4e3VlskCVR2Lb3fOZqhzYmf4QDPDZMputjH7gUAENs3tCR9sIJ6XxPDeu5A
         2TW7Ot6fcNDfhnbupOzDK6oRa+ZIMo0hkDxc0zOlxA3+gswaf3DyOAWb0QMBHSgZUzlG
         Kcb3vuNwT9ByirbuTLdX5PEYE3tkDA5sdU54Z0x2QzyGm1JCmLIIWobQQ61yZYgMuM6d
         6OfCfzbFAAspZCfGyQEXoyp3+FBnMDJMIIj2m7eTmxWprNG8ErjnUqKrbgWUIpHGYgXx
         JKgA==
X-Gm-Message-State: ALoCoQlUSdIe4LHWArZWglw79pqpbL2LYVkollOLANF0M/X+pVM4KR5TT0R8dv5imgkStpcUR21J
X-Received: by 10.60.134.200 with SMTP id pm8mr16252561oeb.61.1423582079152;
 Tue, 10 Feb 2015 07:27:59 -0800 (PST)
Received: by 10.60.175.130 with HTTP; Tue, 10 Feb 2015 07:27:59 -0800 (PST)
In-Reply-To: <1423576488362-7625215.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263634>

When you say "skipping", can you be more specific please? What command
line are you using?

If I want to clone the P4 tree at the current revision, I do something like:

$ git p4 clone //depot/sometree/...

That gets me just a single revision.

If I want all revisions back to the start of time, I do:

$ git p4 clone //depot/sometree/...@all

Thanks,
Luke


On 10 February 2015 at 13:54, Sandeep <varshneysan@gmail.com> wrote:
> Dear All,
>
> I am trying to clone perforce branch from git to my local drive, but it's
> skipping too many files and change list while fetching it from perforce.
>
> it'll be very helpful if anyone can suggest me about how to git rid with
> this issue.
>
> Thanks in Advance,
> Sandeep
>
>
>
> --
> View this message in context: http://git.661346.n2.nabble.com/git-p4-is-not-cloning-perforce-code-properly-tp7625215.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
