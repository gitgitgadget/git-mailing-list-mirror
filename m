From: Scott Yan <scottyan19@gmail.com>
Subject: Re: How to identify the users?
Date: Thu, 31 Jan 2013 14:07:37 +0800
Message-ID: <CACkbeiKR4aYxP6uWtPVCsOLmNfj6fqv48vHdQokuAogR2b_a_Q@mail.gmail.com>
References: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
	<CAH5451nd81aHtaxqpkTeCNG0xpuPd8ptdxRcOgGHaYuN3Qb7WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:08:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nJa-0005ZI-O6
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab3AaGHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:07:41 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:57224 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3AaGHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:07:39 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so3030845lbj.17
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 22:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=A7nlNr35dCrdbio1rjuqLIEhlSyljgJALGVC5nun670=;
        b=igyhvWcjSVQvNwSg0K62KNoZTxlZm2ZJSjkaikDyfgybkKYje26z/bOhpC0jCyVi4w
         OJ41SxNoiTTvble4cB0qhG5PtrGFms3bW5Q3IlXOPiw5LavIRhDtj5io5s4QMcyCBqii
         z+iVWDspzc2k2pvsf1WdEScDpJnBkS8Ou9isjAHObxCaMrLgJ3LsunJ+JsdN0a8Vq+Qj
         AvimpLgn7kOfK+Dq5p5CuLJrrKHHBXQuZhPXh1N+8maVAY06wyYPnc0tgP7VeSIiuI+v
         mGKST3cpla1DqFG1ML81pfIiiNQlfQybetIzYpNN8yumJ3Ema8L6xlB65UeggUFipFNd
         d6iw==
X-Received: by 10.152.110.228 with SMTP id id4mr6816129lab.34.1359612457938;
 Wed, 30 Jan 2013 22:07:37 -0800 (PST)
Received: by 10.112.13.207 with HTTP; Wed, 30 Jan 2013 22:07:37 -0800 (PST)
In-Reply-To: <CAH5451nd81aHtaxqpkTeCNG0xpuPd8ptdxRcOgGHaYuN3Qb7WA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215093>

Thanks, Andrew.

you said:
--have the server reject commits that have the 'committer' set to
someone other then the  authenticated user

but I don't know how to do that?
Our central repository is hosted by apache, and there are some
username and passwords saved by apache to authentication valid user,
but as I know,  there are no relation between the apache username and
the git client user ino (saved in .gitconfig), so can you describe
some detail?

Regards,
Scott Yan

On Thu, Jan 31, 2013 at 1:56 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>
>
>
> On 31 January 2013 16:52, Scott Yan <scottyan19@gmail.com> wrote:
>>
>> The user info of git client (user name and email) is set by the users
>> themselves, so , how to avoid userA pretend to be userB?
>>
>> Git server could authentication the user, but it do nothing about the
>> user info of commit message.
>
>
> The simplest thing is to have the server reject commits that have the
> 'committer' set to someone other then the  authenticated user.
>
> Of course, there are potential workflows that this would cause problems for,
> such as if you sync directly to another user's repository and then try and
> push those to a central server.
>
> The most robust system would probably involve using signed tags to verify
> what is being pushed, however I am not aware of any set-ups that have done
> this yet.
>
> Regards,
>
> Andrew Ardill
