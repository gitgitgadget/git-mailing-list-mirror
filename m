From: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 11:02:44 -0500
Message-ID: <87sl0469gb.fsf@graviton.dyn.troilus.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <86k5lguce2.fsf@lola.quinscape.zz> <8763x07thd.fsf@graviton.dyn.troilus.org> <86tzkksuua.fsf@lola.quinscape.zz>
Reply-To: mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: David Kastrup <dak-mXXj517/zsQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 17:03:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9Dc-0000Hg-1l
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 17:03:20 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6476141wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=JqiMy/c9kwmdKiwPeowlfepq7BEyqLW5qrLc1Jz7XGc=;
        b=ZZQCxlxrhWDzUmkdpxtQg0PmNcgKdjp6eBF6esxwx3TmZ7h82miXueGPkibNxUu4a1sUXVpIkn+dCdIcDaVFh/XF9eQfiZQjusO8yHduloH4GqKzAcGi135sFyxbsI898An9HupZS7sNuaEf36U80CbgTziptT6ZEWBTHhdXMYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=IGtYSFKFcgTp1y9bQQf8XctHcyeo8YIKI46LD8tejRK0R+hH3bEJfs/8896lYqWmF1x2spk+P8ehw1RGbMUnpnV6qZTFXgCd0Gn3AvcMWW/5974H3wFgGBZFj8b069Ce971j+IifAneU2HDEtF/fByQjoDo5BogSqCPnIzr7jfo=
Received: by 10.114.156.1 with SMTP id d1mr811070wae.27.1202400167560;
        Thu, 07 Feb 2008 08:02:47 -0800 (PST)
Received: by 10.106.159.22 with SMTP id h22gr1646pre;
	Thu, 07 Feb 2008 08:02:47 -0800 (PST)
X-Sender: mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.14.4 with SMTP id r4mr25280205pyi.2.1202400167278; Thu, 07 Feb 2008 08:02:47 -0800 (PST)
Received: from sanosuke.troilus.org ([75.145.205.121]) by mx.google.com with ESMTP id a28si6811898pye.0.2008.02.07.08.02.44; Thu, 07 Feb 2008 08:02:47 -0800 (PST)
Received-SPF: neutral (google.com: 75.145.205.121 is neither permitted nor denied by best guess record for domain of mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org) client-ip=75.145.205.121;
Authentication-Results: mx.google.com; spf=neutral (google.com: 75.145.205.121 is neither permitted nor denied by best guess record for domain of mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org) smtp.mail=mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org
Received: by sanosuke.troilus.org (Postfix, from userid 1000) id 8697089C0F1; Thu,  7 Feb 2008 11:02:44 -0500 (EST)
In-Reply-To: <86tzkksuua.fsf-Gv3ZRPJT63HkqtzbHXq1RqVXKuFTiq87@public.gmane.org> (David Kastrup's message of "Thu\, 07 Feb 2008 15\:29\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72958>


David Kastrup writes:

> I think that most countries will grant some right to the purchaser of a
> physical copy of copyrighted material.  For example, I doubt there are
> countries where it is prohibited to read a book you have bought (via a
> channel authorized by the copyright holder) when it contains no explicit
> license granting you the right to read it.

I see two serious dis-analogies here:

How many users of msysgit purchase a physical copy of it?  (I suspect
this is a relevant difference in the US due to its commerce codes, and
maybe in other common law countries; it probably is not so important
in civil law countries, where exchange of consideration is not a
requirement to form a contract.)

Reading a literary work is typically not a reserved right, either;
while it seems good to treat executing a computer program in the same
way as reading a book, all copyright regimes that I know of give
consideration to the copy that is made to RAM for most computers.  (I
will ignore the implications for devices that have execute-in-place
non-volatile memory -- I am not a lawyer, and those devices are
probably too new to be addressed by courts yet.)

Michael Poole

[Also- The git list did not receive my previous mail and probably will
not receive this one either.  vger.kernel.org issues a bogus bounce,
shown in part below.  I apologize for hijacking the thread this way,
but mail to postmaster-at-vger bounces for the same reason.

Error in "rcvdfrom" envelope address:

	75.145.205-121-BusName-sterling.va.richmond.hfc.comcastbusiness.net!^Q
	^								    ^-illegal control character
	 \-Extraneous program text

.. where my mail host does not use that name for any reason; vger
seems to be doing a DNS PTR lookup, then mangling the response.]
