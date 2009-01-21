From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 16:38:06 +0200
Message-ID: <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
	 <49773240.7090605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 15:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeEy-0004pt-A8
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZAUOiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 09:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbZAUOiK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:38:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:22757 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZAUOiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 09:38:09 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1804285fgg.17
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jXhZva1dlZZKnuL/u3p6ac9esD05Z+mTdkYg57a9K0M=;
        b=k+5kRjlipnGQQIhog1lGsZGPVsY4KfNzqFF8rQkjNOnFsczJd18anx7PhgIwjaVisI
         98TmVQ2P8lITrymgZXjoso1tX/csgqxwx+FuTChHFVIAfKgqOHbdLGGvURFco7fH8qW+
         9mH1QaJfExr++HI5TnGLTBCn5RwoGSKFQaIM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lOQj5UYxJBbXRSm6rcJoyZA03PFLh0OYLIpZaXE1+NLa5KmkRNo7jS7/xwxOiJnAmV
         fp9JOQJTc8r0eWWQVti3Xw90eRnHtA/e+YxiWzx7a3Uc59mysAWdUf8p1fEtue51txsv
         4N6PcDw9TfHs01GVy9kSzxeIdHWfdadMi+oJ8=
Received: by 10.86.89.20 with SMTP id m20mr1940926fgb.71.1232548686944; Wed, 
	21 Jan 2009 06:38:06 -0800 (PST)
In-Reply-To: <49773240.7090605@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106611>

On Wed, Jan 21, 2009 at 4:33 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Marc-Andr=E9 Lureau venit, vidit, dixit 21.01.2009 14:02:
>> Hi
>>
>> I deleted a remote branch which was pointed by HEAD, this way: "git
>> push origin :master"
>>
>> Then for almost every git command, I get this error: "error:
>> refs/remotes/origin/HEAD points nowhere!".
>
> You're talking about about the remote git repo, aren't you?
>

Sure. But the error is on the local repo.

>> I found this situation non-friendly. Fortunately, I could understand
>> what's going on. But a new user might be confused.
>>
>> Shouldn't the remote HEAD branch be updated or "protected" in some
>> ways? Or should the "error" be considered as a "warning" (silently?)
>>
>> What do you think?
>
> I think that git said
> "warning: updating the currently checked out branch; this may cause
> confusion,
> as the index and working tree do not reflect changes that are now in =
HEAD."

IIRC, it only says so if your local repo is on a branch tracking this
remote. At least, in some conditions, I didn't get this warning. When
I did second simple testing with git.git version, I also had this
warning.

> after your push and that this may have rung some bells. I also think
> that pushing to a non-bare remote repo (one with a worktree checked o=
ut)
> is strongly advised against in multiple places, unless you know what
> you're doing - which you seem to do since you were able to restore yo=
ur
> HEAD ;)

Isn't HEAD also on non-bare repo, to indicate what is the default branc=
h?

thanks,
--=20
Marc-Andr=E9 Lureau
