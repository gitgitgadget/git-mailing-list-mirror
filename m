From: Francis Stephens <francisstephens@gmail.com>
Subject: Re: Confusing git log --- First time bug submission please advise on
 best practices
Date: Fri, 7 Feb 2014 09:43:46 +0000
Message-ID: <CAJaBJzKy0b8MBuB_X_4n8E2=q=CyrpxOyFFrgv_2CQ19pkNmwQ@mail.gmail.com>
References: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
	<CAAH6HY8unuytrKpEA-eisojUkG=X4D+o+vQDO5bC5YCSmusoHw@mail.gmail.com>
	<874n4cjk83.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 10:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBhyU-00066w-AB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 10:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbaBGJnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 04:43:50 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:34754 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaBGJnr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 04:43:47 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so4810607qaq.15
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d98suLIY8Mcew3tm4YHTXh64JZI4rno5YkRcQjjyDhA=;
        b=txAL+ck4NBklwmYK8QkymwxCf58FbJq5XqBDDR/4f/fc59Tmzf+pjyxZoLdbp6wRu+
         eA6WH0QoVxoVXtbvkoGjI79QHBsMrxA98tZzmUUuWNQQXAbazuIYOn+7uawgfHTJL61u
         41FxdjcYtcgA/0fCfJP7a5ekB2+F0KajXx0Qs4ifIcIBGOjDyvm/u5RhzhxRH22JnsiK
         liCTVvFkpnvO5WA57HroIPij1w19WPmH6vQ4JeZFfxzuXmDC3cr5BXUh7jSzAAU1hz84
         REXBXqjKITGc8iMdTxcWwHYnSNzZvr7qA0B/8YerFpZpYcO9vebEDVXp3pPJSi999lGj
         7+0Q==
X-Received: by 10.140.98.135 with SMTP id o7mr18502098qge.102.1391766226464;
 Fri, 07 Feb 2014 01:43:46 -0800 (PST)
Received: by 10.140.35.211 with HTTP; Fri, 7 Feb 2014 01:43:46 -0800 (PST)
In-Reply-To: <874n4cjk83.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241764>

Thanks for your clear response. I can see where I went wrong now.

On Thu, Feb 6, 2014 at 4:10 PM, David Kastrup <dak@gnu.org> wrote:
> Vincent van Ravesteijn <vfr@lyx.org> writes:
>
>> The commits that are in the log for master and which are not in the
>> log for originssh/master are merged in at "6833fd4 (HEAD, master);
>> Completed merge".
>>
>> As "git log" can only present the commits in a linear way, it shows
>> the commits from the ancentry of both parents of HEAD in a reverse
>> chronological order. This means that the commits from the two
>> ancestries are mixed and commits that are shown after each other don't
>> have to be parent and child. See the documentation of "git log" and
>> the section "Commit Ordering": "By default, the commits are shown in
>> reverse chronological order."
>
> git log --graph can help with getting a better picture.
>
> --
> David Kastrup
