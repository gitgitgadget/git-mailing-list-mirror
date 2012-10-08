From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Mon, 08 Oct 2012 10:26:53 -0700
Message-ID: <7vzk3wlvs2.fsf@alter.siamese.dyndns.org>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin>
 <7vvcemovrh.fsf@alter.siamese.dyndns.org>
 <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
 <20121008080208.GC19733@elie.Belkin>
 <7v7gr1nfby.fsf@alter.siamese.dyndns.org>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Thomas Ferris Nicolaisen
 <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 
 Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,  August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Sverre
 Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCG77UMM3EJRBYUZZSBQKGQE7GJFV5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Oct 08 19:27:07 2012
Return-path: <git-users+bncBCG77UMM3EJRBYUZZSBQKGQE7GJFV5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCG77UMM3EJRBYUZZSBQKGQE7GJFV5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TLH6g-0003yx-FQ
	for gcggu-git-users@m.gmane.org; Mon, 08 Oct 2012 19:27:06 +0200
Received: by mail-oa0-f58.google.com with SMTP id l10sf3772158oag.3
        for <gcggu-git-users@m.gmane.org>; Mon, 08 Oct 2012 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=v9v4+fGLksnHhRFlLUKgsDg1LKdS/YoePmNyOI4WeG0=;
        b=QRovf8X2j7nkLhRri5bGC1hGUd0+XLRGtLTv0ewbX5OglwG0PRjgieKNxjCMkv5swo
         Dra5WNhj6Lkg1miUKTQXwb3VF9g8serLPB0WqeTgmj/5jtR7J0gdFeE++TVj7djGUchK
         GZr7bKtq63SblJZ/BdLLbmvpJP9k+HUVZ5gKqcWQmS2bJhqp/OZXlMA2Yo5A7iWSC2h6
         YjcC/+uMpbuskMZ5P1Lk8BNlJRs7a6hRCYi7lHPWmnUlOUq+FPDHuriPLm84m5hS/yui
         dnIwbjQv7Mw/dlwgkfj9TgMkRrpz5P2UfoJe4lT2tAERC1kv 
Received: by 10.224.190.200 with SMTP id dj8mr4428255qab.17.1349717219383;
        Mon, 08 Oct 2012 10:26:59 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.229.177.160 with SMTP id bi32ls1397865qcb.6.gmail; Mon, 08 Oct
 2012 10:26:58 -0700 (PDT)
Received: by 10.224.189.75 with SMTP id dd11mr13148630qab.6.1349717218661;
        Mon, 08 Oct 2012 10:26:58 -0700 (PDT)
Received: by 10.224.189.75 with SMTP id dd11mr13148629qab.6.1349717218649;
        Mon, 08 Oct 2012 10:26:58 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id f17si1532678qck.1.2012.10.08.10.26.57;
        Mon, 08 Oct 2012 10:26:57 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3784F8415;
	Mon,  8 Oct 2012 13:26:57 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 237838414;
	Mon,  8 Oct 2012 13:26:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86CE4840F; Mon,  8 Oct 2012
 13:26:54 -0400 (EDT)
In-Reply-To: <7v7gr1nfby.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 08:39:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AB78E16-116D-11E2-8DA8-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207244>

Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org> writes:

> Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>
>> I'd suggest dropping ", and will soon be removed." or replacing it
>> with ". Don't use them." to avoid the question of how soon "soon" is.
>>
>> With that change and with a clearer commit message, this will probably
>> be good to go imho.
>
> Yup; thanks.

Let's do this, then.

-- >8 --
From: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Git url doc: mark ftp/ftps as read-only and deprecate them

It is not even worth mentioning their removal; just discourage
people from using them.

Signed-off-by: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Helped-by: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
---
 Documentation/urls.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git i/Documentation/urls.txt w/Documentation/urls.txt
index 2890194..1d15ee7 100644
--- i/Documentation/urls.txt
+++ w/Documentation/urls.txt
@@ -6,8 +6,12 @@ address of the remote server, and the path to the repository.
 Depending on the transport protocol, some of this information may be
 absent.
 
-Git natively supports ssh, git, http, https, ftp, ftps, and rsync
-protocols. The following syntaxes may be used with them:
+Git supports ssh, git, http, and https protocols (in addition, ftp,
+and ftps can be used for fetching and rsync can be used for fetching
+and pushing, but these are inefficient and deprecated; do not use
+them).
+
+The following syntaxes may be used with them:
 
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - git://host.xz{startsb}:port{endsb}/path/to/repo.git/

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
