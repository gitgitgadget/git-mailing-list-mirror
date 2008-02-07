From: David Kastrup <dak-mXXj517/zsQ@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 17:13:53 +0100
Message-ID: <86abmcsq0u.fsf@lola.quinscape.zz>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <86k5lguce2.fsf@lola.quinscape.zz> <8763x07thd.fsf@graviton.dyn.troilus.org> <86tzkksuua.fsf@lola.quinscape.zz> <87sl0469gb.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 17:15:10 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.191])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9Oo-0004mj-Rw
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 17:14:55 +0100
Received: by ag-out-0910.google.com with SMTP id 32so5865406agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=40moLy6shqrdroAvUH+jy1MRb76L3/AYiSkhSn+b3Ck=;
        b=o6qxAWb5LKMV6pfZK+dxHcmWfxzzsrPx8J4HQCaEKr9YH7PLtDVePy77dRChpcvqGErYHlxcYETrskLAsVxPAGTzKW95nlinvSXbbXcrsvXan6MrXyUYk84Nz+CoUjLzh+gJ5mmenMlJAk5g1dSILxmUaAowNvXFGnSOmfhP9Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=Px6cbuifq95OuWdlZCnB4UT/P6l1WBmsDDh4gi02HhGcW18pfN8tSj46BM++TOINl0drRig10cXWoSjIarGxpuJJJ3K+Ov9PiDNOHFNXxiOm+LAy/09qM/J8NLNqJTZvfsV904RaXlFjqXkNoxn6LaBHhkbFSZIS/4Vzt2gGyqo=
Received: by 10.115.106.7 with SMTP id i7mr811793wam.19.1202400856576;
        Thu, 07 Feb 2008 08:14:16 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1647pro;
	Thu, 07 Feb 2008 08:14:16 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr25241514pyi.7.1202400856386; Thu, 07 Feb 2008 08:14:16 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id x46si6841928pyg.3.2008.02.07.08.14.15; Thu, 07 Feb 2008 08:14:16 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1JN9O5-0002ID-IF for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 16:14:09 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 16:14:09 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 16:14:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:sL99PEG5vvYNq8xYqe28QQeb5Ig=
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72962>


Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org> writes:

> David Kastrup writes:
>
>> I think that most countries will grant some right to the purchaser of
>> a physical copy of copyrighted material.  For example, I doubt there
>> are countries where it is prohibited to read a book you have bought
>> (via a channel authorized by the copyright holder) when it contains
>> no explicit license granting you the right to read it.
>
> I see two serious dis-analogies here:
>
> How many users of msysgit purchase a physical copy of it?

"Acquire an authorized copy" is the relevant phrase here.  And that will
be the case for pretty much every user.

> 	75.145.205-121-BusName-sterling.va.richmond.hfc.comcastbusiness.net!^Q
> 	^								    ^-illegal control character
> 	 \-Extraneous program text
>
> .. where my mail host does not use that name for any reason; vger
> seems to be doing a DNS PTR lookup, then mangling the response.]

It may be that your version of Emacs is injecting C-d characters after
column 255 in a line.

-- 
David Kastrup
