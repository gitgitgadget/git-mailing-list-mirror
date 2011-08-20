From: Ron Panduwana <panduwana@gmail.com>
Subject: Re: [PATCH] bash-completion: Make use of git status
Date: Sat, 20 Aug 2011 19:46:14 +0700
Message-ID: <CAOSnc=hzehOJ9RCs2huZ4b99ZG4Mgok-MfSNXN7OzFq1K9gYrQ@mail.gmail.com>
References: <1313474948-13531-1-git-send-email-panduwana@gmail.com> <201108191210.59538.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lee Marlow <lee.marlow@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 20 14:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qul1S-0006gt-Ty
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 14:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab1HTMrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 08:47:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50169 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1HTMro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 08:47:44 -0400
Received: by fxh19 with SMTP id 19so2426005fxh.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4H5XKHMzMep8kxVfwl7Zaa1/kUDltxtsXdMiXxXM8d4=;
        b=FEvHDsl9WtWRtjA1Jf55JtnyX8GTgG6yaooY0zLfJSi6Vm95fN1CAq93ZlTNBEg6cJ
         HfDEl4rYFnKEfcuEkUR7Qt0mkzdGnCTYBr488GGBxtBM9Srere/EvX+7daCPdubVM8n7
         Xw65mpcXF+DxSikhnDujwGwKhq4Sy1tBgCExc=
Received: by 10.223.52.66 with SMTP id h2mr758871fag.92.1313844462752; Sat, 20
 Aug 2011 05:47:42 -0700 (PDT)
Received: by 10.223.86.3 with HTTP; Sat, 20 Aug 2011 05:46:14 -0700 (PDT)
In-Reply-To: <201108191210.59538.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179760>

On Fri, Aug 19, 2011 at 5:10 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Some thoughts:
>
> * running git-status for . has some issues: it doesn't work in the
> =A0case of
>
> =A0 =A0cd subdir
> =A0 =A0git add ../some/file[TAB]
>
> =A0It's also inefficient if you are at the top level and
>
> =A0 =A0git add path/to/file/a/few/levels/down[TAB]
>
> =A0since it wouldn't actually have to look for untracked files in the
> =A0entire repo.

OK I'll change it to git-status $cur*


> * -uall is not required unless you are looking for untracked files.
> =A0 For the other commands you could speed up completion by passing
> =A0 -uno instead.

Will add second param to __git_files_having_status


Ron Panduwana
--
panduwana@gmail.com
