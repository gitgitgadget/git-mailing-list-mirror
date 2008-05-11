From: "Patrick Aljord" <patcito-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 10:25:04 -0500
Message-ID: <6b6419750805110825t51730d16y211d2c502a1b302d@mail.gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet> <4826EEDF.4010404@gmail.com> <20080511132752.GA22778@atjola.homenet> <4826F72D.2070205@gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Dima Kagan" <dima.kagan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun May 11 17:25:52 2008
Return-path: <grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvDQu-0006ZP-C5
	for gcggu-git-users@m.gmane.org; Sun, 11 May 2008 17:25:52 +0200
Received: by ug-out-1516.google.com with SMTP id k24so2911992uge.9
        for <gcggu-git-users@m.gmane.org>; Sun, 11 May 2008 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=x2GwbCeBBxFplEZqtwwJr+TOvNW4USTdzK2ATa2K7MQ=;
        b=eiYQe/3qhtrLg9CSR/VQV+parsWQBFwYnnhiWKN/+a6NX1ZUeJbUa8J0y8fjR1SDeGfs2zObL+ae0I6V12gMsOHObjLrGjTPwgqzizPWUq0Osoi7ehRLi/nZWpVkvhpuy297iy+ddFBpRGDitEArt1bt0/lk/3B7wjYa77JdAy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=U6AP8I/xpThJPMN9zt1nqB/YXzzojILWxQT/Ve6JOwB3gWV0kPY4iCaHNVz3neJkuLRqdTUBrsQ/HMU9Zf+52w0QogCyXSmZjF2zM7nmaWeymZv+aDZcw6rEOyyIg3rt6WPI7pmydQMONEOOIeI9U5TwU+UNkrzQaMx0sW/uSs4=
Received: by 10.150.11.6 with SMTP id 6mr137446ybk.3.1210519506349;
        Sun, 11 May 2008 08:25:06 -0700 (PDT)
Received: by 10.44.54.11 with SMTP id c11gr44hsa.0;
	Sun, 11 May 2008 08:25:06 -0700 (PDT)
X-Sender: patcito-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.22.9 with SMTP id z9mr5833504pyi.1.1210519505525; Sun, 11 May 2008 08:25:05 -0700 (PDT)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29]) by mx.google.com with ESMTP id 7si7702478yxg.1.2008.05.11.08.25.04; Sun, 11 May 2008 08:25:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of patcito-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.46.29 as permitted sender) client-ip=74.125.46.29;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of patcito-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.46.29 as permitted sender) smtp.mail=patcito-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by yw-out-2324.google.com with SMTP id 9so1514953ywe.71 for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 11 May 2008 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=qRrtHFmcSP7cHIR6UWqtMkrLkBBvqGzsHsYklQB/0LM=; b=YsZ0tB2WmZ6tmqcnn2FjVq151ijXWUTKzkge/Y7PLFsJRkpn5e+WswkdcPCg8EcwYrDhsfCoC2U8+aDqSPN2K1rnjvYChkysALk0mwUWK6ma7VDPt7djkXVNqDBahaNZWIZ9tbYl2BQK/fCLrI54aU+1BkkKMttS5LE99hE+tSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=eslqL/3JvmySLN4SLv0oZUuE3tuQ4FBZVqVKttrHkDgHcJVUk/sRAT6LrMaSpfjF/gLcNA7qK/4NT5yRuyPDj65H0uYcZiWhuFl96ooGuSrY+XtODxCdCOd1w7O5a3nnqXoRu4n07Cwn1Q2aXFtmSRMpPEpr5UGDpADrzYJw5Jc=
Received: by 10.150.50.3 with SMTP id x3mr7210573ybx.32.1210519504474; Sun, 11 May 2008 08:25:04 -0700 (PDT)
Received: by 10.151.78.10 with HTTP; Sun, 11 May 2008 08:25:04 -0700 (PDT)
In-Reply-To: <4826F72D.2070205-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact git-users-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <git-users.googlegroups.com>
List-Post: <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:git-users-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/git-users/subscribe>,
	<mailto:git-users-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81777>


On Sun, May 11, 2008 at 8:39 AM, Dima Kagan <dima.kagan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> My proposed change shouldn't necessarily break the described workflow. Git can keep the current behavior for new branches, but automatically 'stash' the changes when checking-out an existing branch. At least having an optional parameter for "auto-stashing" will be nice.
>
> What do you think of that?

you can do just that with an alias, in .git/config add:

[alias]
        auto-stash = !git stash && git checkout $1

then type "git auto-stash master" or "git auto-stash some_branch" and
it should stash and checkout the branch.

Cheers,

Pat

--~--~---------~--~----~------------~-------~--~----~
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To unsubscribe from this group, send email to git-users-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en
-~----------~----~----~----~------~----~------~--~---
