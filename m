From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Sun, 07 Oct 2012 13:46:42 -0700
Message-ID: <7vvcemovrh.fsf@alter.siamese.dyndns.org>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Thomas Ferris Nicolaisen
 <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 
 Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,  August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Sverre
 Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCG77UMM3EJRBNOUY6BQKGQEHIBK4XI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Oct 07 22:46:55 2012
Return-path: <git-users+bncBCG77UMM3EJRBNOUY6BQKGQEHIBK4XI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCG77UMM3EJRBNOUY6BQKGQEHIBK4XI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TKxkT-0005kc-1N
	for gcggu-git-users@m.gmane.org; Sun, 07 Oct 2012 22:46:53 +0200
Received: by mail-pb0-f58.google.com with SMTP id rq2sf3076688pbb.3
        for <gcggu-git-users@m.gmane.org>; Sun, 07 Oct 2012 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=e48NWz5arvJHiGuCgLVJ7xRqJREZUVe5pN/cY6INpvk=;
        b=mEYt1r2TH8z+QbFWxH5+n+BehbQhx7ssgvxcqHNu8uLhjWkhTwXh2vNBphV1BjX3C1
         aUYtIgydZ0OPp7T1BTxh8WSf4ufg5QedJHZ2jWp3c0acPeoDKSisl54XmrOWyPkOQE0l
         sZJ6MP9KNZOWtilCHRpPQ4O6DcJUiIU/V2hP3yjhCh52Cb7IGgXSYqKDARBB4yAc4LJ3
         Yy9fSet+KxDwVeyhMGG2f1mREPY3xV1MInfhNEu2AEJs/3ASfcoOPiHPMevdqt4LdutQ
         RVMnCpzEt92NHnRT5j9LZa1zz5DPLKMkYyJQa4lGkfOT9UZg 
Received: by 10.224.35.67 with SMTP id o3mr424152qad.13.1349642805852;
        Sun, 07 Oct 2012 13:46:45 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.229.78.102 with SMTP id j38ls7151411qck.7.gmail; Sun, 07 Oct
 2012 13:46:45 -0700 (PDT)
Received: by 10.224.117.143 with SMTP id r15mr11506752qaq.1.1349642805197;
        Sun, 07 Oct 2012 13:46:45 -0700 (PDT)
Received: by 10.224.117.143 with SMTP id r15mr11506751qaq.1.1349642805187;
        Sun, 07 Oct 2012 13:46:45 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id g28si3299188qcq.2.2012.10.07.13.46.45;
        Sun, 07 Oct 2012 13:46:45 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F6194CA;
	Sun,  7 Oct 2012 16:46:44 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09C794C9;
	Sun,  7 Oct 2012 16:46:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFFDA94C6; Sun,  7 Oct 2012
 16:46:43 -0400 (EDT)
In-Reply-To: <20121007172754.GA29560-fcEM2ccDkbL2nhBuCrrZHw@public.gmane.org> (Jonathan Nieder's message
 of "Sun, 7 Oct 2012 10:27:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A94C5B8-10C0-11E2-B977-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates
 208.72.237.35 as permitted sender) smtp.mail=junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en_US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en_US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207194>

Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> Ramkumar Ramachandra wrote:
>>> Thomas Ferris Nicolaisen <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>
>>>> At least according to the documentation[1], "Git natively supports [...] ftp".
>>>>
>>>> This could need some clarification if pushing over ftp is not supported.
> [...]
>> -Git natively supports ssh, git, http, https, ftp, ftps, and rsync
>> -protocols. The following syntaxes may be used with them:
>> +Git natively supports ssh, git, http, https, and rsync protocols. The
>> +following syntaxes may be used with them:
>
> Perhaps the initial list should not be exhaustive, in which case we
> could say:
>
> 	Git natively supports ssh, git, http, and https protocols.  The
> 	following syntaxes may be used with them:
>
> 	...
>
> 	Git also has (less efficient) support for fetching and pushing
> 	over rsync protocol and fetching over ftp or ftps, using the
> 	same "protocol://host/path/to/repo.git/" syntax.

Yeah, that, possibly with "These are deprecated; do not use them.",
would be a better way forward.  As we deprecated "rsync" long time
ago, perhaps we should remove it at Git 2.0 or somewhere around
that.

By the way, that old patch by Ram in question was *not* incorrect
per-se back then when dumb http was still more prevalent option
between the two http transports.  Fetching over dumb http and dumb
ftp were both equally bad ;-)  It just has become less relevant as
more people start equating http with the smart http, where there is
no equivalent "smart ftp".

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
