From: "Alexander Gladysh" <agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Fri, 5 Sep 2008 23:27:19 +0400
Message-ID: <c6c947f60809051227o6a3890c9m1767921a6bb9a804@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com> <20080904143723.GB23708@spearce.org> <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com> <20080905045327.GA31166@spearce.org>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
X-From: grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Sep 05 21:28:38 2008
Return-path: <grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbgyr-0002Na-6Z
	for gcggu-git-users@m.gmane.org; Fri, 05 Sep 2008 21:28:29 +0200
Received: by yx-out-2122.google.com with SMTP id 22so408851yxm.63
        for <gcggu-git-users@m.gmane.org>; Fri, 05 Sep 2008 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=PMdaD+3VSHpXIfXxnEStCRrt3eV73uwYYVTimLNb4y8=;
        b=0E6ktzOEVJwEyqjkMiIma+Azi1zBxIB1vDYca/bfrXZrYoup4DWrrn3RjhJCafnTC5
         uZAEkcOqrCkfSJi6J9Eso8eo6PO3uifz96lufe5QOr7dbpH9/mfDuAMi2A7XBlBruneC
         mU7HEz5YYLLVaO6U6yVh0Gsb4+eiROGE8/QoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:references:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=CBJK+oLPLQyXYuUdWqWHciXvK5r37g7jaaeTKzyak5hb8Tv5I8zd5WV5b4qrJyOv6Q
         HWI8jP5TsJsqKN/XKG3kJLe6XtZ98IHghZbAH7VX4wozIg2/uvV0BznsdVVl40XX95uy
         FhDQ5zCi89CiV0Y1P0XWCuKUz6DUF2fFn41+0=
Received: by 10.114.199.1 with SMTP id w1mr318530waf.6.1220642841008;
        Fri, 05 Sep 2008 12:27:21 -0700 (PDT)
Received: by 10.106.151.34 with SMTP id y34gr144prd.0;
	Fri, 05 Sep 2008 12:27:20 -0700 (PDT)
X-Sender: agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.111.6 with SMTP id j6mr7292225wac.29.1220642840530; Fri, 05 Sep 2008 12:27:20 -0700 (PDT)
Received: from wa-out-1112.google.com ([172.21.189.38]) by mx.google.com with ESMTP id k32si456206wah.1.2008.09.05.12.27.19; Fri, 05 Sep 2008 12:27:20 -0700 (PDT)
Received-SPF: neutral (google.com: 172.21.189.38 is neither permitted nor denied by domain of agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) client-ip=172.21.189.38;
Authentication-Results: mx.google.com; spf=neutral (google.com: 172.21.189.38 is neither permitted nor denied by domain of agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) smtp.mail=agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by wa-out-1112.google.com with SMTP id m38so451832waf.14 for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 05 Sep 2008 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=pRU3g+r1gTWldafcFvGJrbVx82h1kxUjgHVo9j7eFUM=; b=A3DiXd7SfAx0epux58SU708hkWSPHg91zq4FyKNOxzdsGztwAmlUEeSlV2OyeGuiAH CHnyYWpoA39l382MMURJ6q4IVJHL2lskNZy/bm/fNf58U9INnBTUIXCVYGBYonMpN2gx vz1r2j7qVzN0wx2uTuh+2eCtvnEMLEsA4CZIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=j69f6gsfYmeneyHxJ3cFr8vHjfWHLEMh8K9whA++Ug2lgNsYW9/27JAHEtVGcXYcQg SlM+nFd+h+tVFDoBcFRZqhhfz9CkPy9GY4gEkpqtgv6c5ynn9x9d354444vK5S95QqfZ zkJcqQQLMNsb8TdEKCoAQw9cIJJirjs9TqUrQ=
Received: by 10.115.46.9 with SMTP id y9mr8318634waj.23.1220642839299; Fri, 05 Sep 2008 12:27:19 -0700 (PDT)
Received: by 10.115.95.8 with HTTP; Fri, 5 Sep 2008 12:27:19 -0700 (PDT)
In-Reply-To: <20080905045327.GA31166-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact git-users+owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <git-users.googlegroups.com>
List-Post: <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/git-users/subscribe>,
	<mailto:git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-BeenThere-Env: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95034>


> So that was an awesome reproduction case.  I have committed the
> following fix and will push it out in a few minutes:

<...>

Thank you! The fix helped indeed. I can commit on hunk level again! :-)

Alexander.
