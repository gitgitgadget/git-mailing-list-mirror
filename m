From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Fri, 05 Oct 2012 14:48:40 -0700
Message-ID: <7vwqz4si87.fsf@alter.siamese.dyndns.org>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Konstantin Khomoutov
 <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,  August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sverre Rabbelier
 <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Thomas Ferris Nicolaisen <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCG77UMM3EJRBPFLXWBQKGQEKO5CQNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Oct 05 23:48:51 2012
Return-path: <git-users+bncBCG77UMM3EJRBPFLXWBQKGQEKO5CQNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCG77UMM3EJRBPFLXWBQKGQEKO5CQNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TKFlK-0001Vu-Sw
	for gcggu-git-users@m.gmane.org; Fri, 05 Oct 2012 23:48:51 +0200
Received: by mail-qa0-f58.google.com with SMTP id n12sf810640qat.3
        for <gcggu-git-users@m.gmane.org>; Fri, 05 Oct 2012 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=y4tG3jPwXiaUQZJXNIrennkvP3dT7bsQ1M64XVb3ndQ=;
        b=Z7tIuXB3Mezz7iKBh0vPEbyfatkaw1j4K/VA5szIciX7NdXoByJgpcjlSIVgBObffa
         1x3k/BfM5r35czj+yIxCBt9B6SpilVM09GzxxVvpvoJ06bRNuPvffseMv2X1C5RRis/o
         AbCCs01G6pn4/QCuMlKPH8PQ5bXDWsMtXz3Jc3VLiBR2G1+D7bZNSPhAtBjQw7dAaI8i
         BeeSSQQ7l/R65Tf9EVkPWkLSO/9RC8pd1XHqc+QhHz8928drKPgQinK2WDvjp3XVqtKU
         DhIq0i2zryh2WGTSTeZiS8/gJriKgb1j+2T2kDBAA8yVUdxX 
Received: by 10.224.10.82 with SMTP id o18mr3262169qao.2.1349473724712;
        Fri, 05 Oct 2012 14:48:44 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.224.180.143 with SMTP id bu15ls7452424qab.4.gmail; Fri, 05 Oct
 2012 14:48:44 -0700 (PDT)
Received: by 10.224.78.209 with SMTP id m17mr8310618qak.3.1349473724256;
        Fri, 05 Oct 2012 14:48:44 -0700 (PDT)
Received: by 10.224.78.209 with SMTP id m17mr8310617qak.3.1349473724245;
        Fri, 05 Oct 2012 14:48:44 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ek33si2398355qcb.0.2012.10.05.14.48.44;
        Fri, 05 Oct 2012 14:48:44 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C548979C;
	Fri,  5 Oct 2012 17:48:43 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D82979B;
	Fri,  5 Oct 2012 17:48:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDE259799; Fri,  5 Oct 2012
 17:48:41 -0400 (EDT)
In-Reply-To: <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> (Thomas
 Ferris Nicolaisen's message of "Fri, 5 Oct 2012 17:21:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DD83722-0F36-11E2-9948-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207123>

Thomas Ferris Nicolaisen <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On Fri, Oct 5, 2012 at 3:46 PM, Philippe Vaucher
> <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> > On the git-users mailing list we're trying someone to help with
>> > running `git push` over FTP.  That person is runnig Git 1.7.9.5
>> > on Ubuntu 12.04.
>>
>> I don't think vanilla git supports pushing over ftp.
>>
>
> At least according to the documentation[1], "Git natively supports [...] ftp".
>
> This could need some clarification if pushing over ftp is not supported.

The commit 5ce4f4e (Documentation/urls: Rewrite to accomodate
<transport>::<address>, 2010-04-06) that came from

  http://thread.gmane.org/gmane.comp.version-control.git/145196/focus=145205

was supposed to be just a clarification of the document, but it
added ftp to the list without justification.  Its earlier round is
this

    http://thread.gmane.org/gmane.comp.version-control.git/143499

and it did not mention ftp; I wonder why we missed this addition
during the review process.

The ftp transport might have worked for fetching in the distant past
for "dumb and slow" commit walking fetches, but it was never
supposed to work with any kind of pushes as far as I know.  I
wouldn't be surprised if the dumb and slow commit walking fetch no
longer works with ftp.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
