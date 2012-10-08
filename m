From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Mon, 08 Oct 2012 08:39:13 -0700
Message-ID: <7v7gr1nfby.fsf@alter.siamese.dyndns.org>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin>
 <7vvcemovrh.fsf@alter.siamese.dyndns.org>
 <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
 <20121008080208.GC19733@elie.Belkin>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Thomas Ferris Nicolaisen
 <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 
 Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,  August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Sverre
 Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCG77UMM3EJRBJHHZOBQKGQETUSMRGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Oct 08 17:39:27 2012
Return-path: <git-users+bncBCG77UMM3EJRBJHHZOBQKGQETUSMRGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCG77UMM3EJRBJHHZOBQKGQETUSMRGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TLFQR-0006MV-DZ
	for gcggu-git-users@m.gmane.org; Mon, 08 Oct 2012 17:39:23 +0200
Received: by mail-qa0-f58.google.com with SMTP id n12sf2667367qat.3
        for <gcggu-git-users@m.gmane.org>; Mon, 08 Oct 2012 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=JEZyAG0hlQOazFzmK/wbwz29czPiYJmm7QhR4etjiYk=;
        b=El6ltJ4mTDm2OsCIqhbnf5em9kS5X5xZOUuJEmHKhWmu5hMxi3D5cPVcrcXuVSkez7
         Z50hG7YGB+B+njQ0fmLjaXVmadC2OioMLETOoORpuiqPxjs0ByeMehsDCFb8iKMv9ok6
         hkKroawBsY8TJ4nCRjeGgRt/CFmgOHBBXoSjF+ZtxT6kS3gZreLwuQkvoRC+O2YNLZ40
         oP+jz1oFRV2e+gNI0KyEcUEyDqXrn8NFDdajQpba7kkqd4SXyIs7koSxH5L2drFesDnC
         zaZZQi4qSUyY4WyeIAvXOsbewM3U3MNbm01ABn/zwKNEdJ5p 
Received: by 10.229.102.143 with SMTP id g15mr871943qco.14.1349710756905;
        Mon, 08 Oct 2012 08:39:16 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.224.188.14 with SMTP id cy14ls7726589qab.8.gmail; Mon, 08 Oct
 2012 08:39:16 -0700 (PDT)
Received: by 10.224.117.143 with SMTP id r15mr12890076qaq.1.1349710756416;
        Mon, 08 Oct 2012 08:39:16 -0700 (PDT)
Received: by 10.224.117.143 with SMTP id r15mr12890075qaq.1.1349710756405;
        Mon, 08 Oct 2012 08:39:16 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id a27si3708222qck.3.2012.10.08.08.39.16;
        Mon, 08 Oct 2012 08:39:16 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED8B38411;
	Mon,  8 Oct 2012 11:39:15 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA8E1840F;
	Mon,  8 Oct 2012 11:39:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FCB2840E; Mon,  8 Oct 2012
 11:39:15 -0400 (EDT)
In-Reply-To: <20121008080208.GC19733-fcEM2ccDkbL2nhBuCrrZHw@public.gmane.org> (Jonathan Nieder's message
 of "Mon, 8 Oct 2012 01:02:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50BB9C7C-115E-11E2-B00D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207232>

Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> I'd suggest dropping ", and will soon be removed." or replacing it
> with ". Don't use them." to avoid the question of how soon "soon" is.
>
> With that change and with a clearer commit message, this will probably
> be good to go imho.

Yup; thanks.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
