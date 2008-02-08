From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Fri, 8 Feb 2008 12:14:02 +0100
Message-ID: <1ACC7F45-46D2-4CBE-B3F7-61B67376006B@zib.de>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802071157360.2896@woody.linux-foundation.org> <4C918ADB-6FF5-458E-AC81-5683850E1FE4@zib.de> <alpine.LSU.1.00.0802080143440.11591@racer.site> <E6DFE65BB5ADFE44BE13CCC976124447D5BCC8@fue-email2.ad.mc.com>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, "Linus Torvalds" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Junio C Hamano" <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Luciano Rocha" <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, "Git Mailing List" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "msysGit" <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "Schuberth, Sebastian" <sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Feb 08 12:13:51 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRAw-0001t2-5f
	for gcvm-msysgit@m.gmane.org; Fri, 08 Feb 2008 12:13:46 +0100
Received: by wa-out-0708.google.com with SMTP id n36so7305599wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 08 Feb 2008 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=uKv+FBxexh+MZhRVYuRXR09C/kSjMR7u4YuSKsQY5mg=;
        b=zN4szAFHn6Wymwhnm5GhcGI423CDD/27Fg2dtDNpVMP1PlibJ/Pkbhzzr0cElAauzYyQvq9GSjLZcLmvzcNm+aGvETuIKJk/4TVZQcdzbrBmo372L4jNhdsLC0SQKQYSgt2aiP7ULu/nw0yt5HNOcJPIHRQT/cpnuBp5bTQFJ6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=VLrjGp5dUzM0f9tKgXZyWPdptmk73K5J+16Bru8vjGYFajWDq2/lI8UcHBYOCgm1tGq78yuzKuq3m505ECclebjmZtYgWIYp+Lp9C4y385cXfrR6uAohN+M/A0hWcZvPhGMmvmNTn1mh6eiWDUK3+BBySzPKbGaKQ5t0ULh6Xr0=
Received: by 10.143.13.6 with SMTP id q6mr259785wfi.25.1202469194046;
        Fri, 08 Feb 2008 03:13:14 -0800 (PST)
Received: by 10.106.159.22 with SMTP id h22gr1677pre;
	Fri, 08 Feb 2008 03:13:14 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr26809280pym.3.1202469193710; Fri, 08 Feb 2008 03:13:13 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si8617405pyg.1.2008.02.08.03.13.13; Fri, 08 Feb 2008 03:13:13 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m18BD7Ox014951; Fri, 8 Feb 2008 12:13:07 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m18BD6sl015949 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 8 Feb 2008 12:13:06 +0100 (MET)
In-Reply-To: <E6DFE65BB5ADFE44BE13CCC976124447D5BCC8-xoGCv1uRt2M6PgvdBIHKsVaTQe2KTcn/@public.gmane.org>
X-Mailer: Apple Mail (2.753)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73073>



On Feb 8, 2008, at 10:22 AM, Schuberth, Sebastian wrote:

>
>>> Sebastian, can we easily modify the license dialog with Inno Setup?
>>> The license should be displayed and a single click should be
>>> sufficient to "continue".
>>
>> It looks like "LicenseFile" is a special variable in
>> InnoSetup, and it is not _that_ easy to change it to an "I am
>> okay with it; I read it" text.
>
> Actually, the modification was trivial, I'm now using "InfoBeforeFile"
> instead of "LicenseFile". I've pushed Steffen the change.

I pushed the commit to msysgit.git onto branch work/innosetup:

http://repo.or.cz/w/msysgit.git?a=commitdiff;h=f66b8578722

I'll test it later and will include it in the next release if
nobody raises further objections.

	Steffen
