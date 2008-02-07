From: David Kastrup <dak-mXXj517/zsQ@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 15:29:49 +0100
Message-ID: <86tzkksuua.fsf@lola.quinscape.zz>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <86k5lguce2.fsf@lola.quinscape.zz> <8763x07thd.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 15:30:56 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.186])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN7m4-0007VF-Mh
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 15:30:50 +0100
Received: by ag-out-0910.google.com with SMTP id 32so5694729agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=enxInPL2boWU/ot6uvjEhyh0Q+8x9h5aU6POA3F1oU8=;
        b=rGQf6pv6PGWMdZDIKN3P5pZcydhB4L5wrWa2mMk7pJH3YIW6JzHTE/UvqvpEibJCMZiKjT5L0wZv9chUAqIZW6PIg4hE1+6CpqPctxH7hFZYSyHmslaSFfQx4n5efoFaxjWVPsfYXIP7BDRa2qNm3e57767aP2YE3hiSwXnWFws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=4uYGLZJD63osZMzfBE2Q++Ysjq1LQvYZ5E5vnkpmg4fPWwu0Jf2EE50s7Y9XK424i4FRxT9vbDK6UrsitWAdXmQ4wBvvCoOxhFYS0SWr9TPYlQXkRVjFq+bEuCL8KXNEmyM9khlPnv4vLTG9MRHEbfOATunwY5Pth8pAGBMQjso=
Received: by 10.143.28.7 with SMTP id f7mr212259wfj.22.1202394601479;
        Thu, 07 Feb 2008 06:30:01 -0800 (PST)
Received: by 10.107.134.19 with SMTP id l19gr1643prn;
	Thu, 07 Feb 2008 06:30:01 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr25065245pyi.7.1202394601146; Thu, 07 Feb 2008 06:30:01 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id v63si6655316pyh.2.2008.02.07.06.30.00; Thu, 07 Feb 2008 06:30:01 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1JN7lG-0005sz-Me for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 14:29:58 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 14:29:58 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 14:29:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:W9L9AG/lYpctiwUSMZ0R1rGrKrk=
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72949>


Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org> writes:

> British courts, for instance, have held that copying a program into
> RAM for the purposes of executing it is a right reserved under
> copyright law.  In the US, 17 USC 117(c) and (d) were added after a
> court held (in MAI Sys. Corp. v. Peak Computer) that a computer repair
> company violated copyright of software that automatically started on a
> computer it was asked to repair -- by simply allowing the computer to
> boot and execute that program automatically.
>
> As the GPL itself notes, you are not required to accept it, but
> nothing else grants you the right to perform actions reserved to
> copyright holders with respect to the work.

I think that most countries will grant some right to the purchaser of a
physical copy of copyrighted material.  For example, I doubt there are
countries where it is prohibited to read a book you have bought (via a
channel authorized by the copyright holder) when it contains no explicit
license granting you the right to read it.

-- 
David Kastrup
