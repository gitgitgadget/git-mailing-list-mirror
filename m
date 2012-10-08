From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Mon, 08 Oct 2012 14:38:28 -0700
Message-ID: <7vy5jgiqzv.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin>
 <7vvcemovrh.fsf@alter.siamese.dyndns.org>
 <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
 <20121008080208.GC19733@elie.Belkin>
 <7v7gr1nfby.fsf@alter.siamese.dyndns.org>
 <7vzk3wlvs2.fsf@alter.siamese.dyndns.org> <20121008201816.GB7698@elie.Belkin>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Thomas Ferris Nicolaisen
 <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 
 Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,  August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Sverre
 Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCG77UMM3EJRBVUPZWBQKGQE53WVZFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Oct 08 23:38:38 2012
Return-path: <git-users+bncBCG77UMM3EJRBVUPZWBQKGQE53WVZFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCG77UMM3EJRBVUPZWBQKGQE53WVZFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TLL25-00047s-SD
	for gcggu-git-users@m.gmane.org; Mon, 08 Oct 2012 23:38:38 +0200
Received: by mail-qc0-f186.google.com with SMTP id y9sf3949866qcp.3
        for <gcggu-git-users@m.gmane.org>; Mon, 08 Oct 2012 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=CVly0/K4WrXMPIMqN3K6ESIFZrFEitkvFX3YrGrmUGY=;
        b=DMnCV2s/CGQA4DJKOlpULxoPUEgUI6t2qvi/JOAT5uPXFoxb68pQjJwgZ/93NYmP4E
         exejC2BOZgFjiFFA0qTmwe8qlhQhDUJQpu17ERjM1zDq6C6Ua2HjpQdTRhqamOrvGT2e
         7XMmlh52ylKMs9UkGPvym5ZjSG8JmgBjfRb/3ylJtV3eKObloHw/q7UC4pAqzL9/m1nz
         bs00+O3nweTonkgsz28iLj6QmfHnffZrTkmdiyRMBDeFuKmqebgy/9BONGfwCPVvkC4h
         YJ9p7tyaezqRcNcAogW1evc4rVg/INkaVa3Ujbe0PIDQnM4W 
Received: by 10.224.221.145 with SMTP id ic17mr1754263qab.10.1349732311329;
        Mon, 08 Oct 2012 14:38:31 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.229.177.160 with SMTP id bi32ls1749506qcb.6.gmail; Mon, 08 Oct
 2012 14:38:30 -0700 (PDT)
Received: by 10.224.78.209 with SMTP id m17mr13593497qak.3.1349732310842;
        Mon, 08 Oct 2012 14:38:30 -0700 (PDT)
Received: by 10.224.78.209 with SMTP id m17mr13593496qak.3.1349732310833;
        Mon, 08 Oct 2012 14:38:30 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ba11si366100qcb.2.2012.10.08.14.38.30;
        Mon, 08 Oct 2012 14:38:30 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D09F8CDC;
	Mon,  8 Oct 2012 17:38:30 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AD2F8CDB;
	Mon,  8 Oct 2012 17:38:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 837DE8CDA; Mon,  8 Oct 2012
 17:38:29 -0400 (EDT)
In-Reply-To: <20121008201816.GB7698-fcEM2ccDkbL2nhBuCrrZHw@public.gmane.org> (Jonathan Nieder's message
 of "Mon, 8 Oct 2012 13:18:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 800C3A86-1190-11E2-9E34-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207275>

Thanks.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
