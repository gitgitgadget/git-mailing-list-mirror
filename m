From: Gregory Jefferis <jefferis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 07 Jan 2008 23:46:17 +0000
Message-ID: <C3A86A49.10AEF%jefferis@gmail.com>
References: <alpine.LFD.1.00.0801071457040.3148@woody.linux-foundation.org>
Reply-To: jefferis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 00:46:50 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from nz-out-0708.google.com ([64.233.162.246])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC1g9-00010T-Gy
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 00:46:49 +0100
Received: by nz-out-0708.google.com with SMTP id h28so10919756nzf.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 07 Jan 2008 15:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=HZio66uS3mYGx5TI9QVtvO2yJscPvxM6bdXrAlKxtHk=;
        b=dFkSJjSKNOUdhiwUB/I4Oemy/p1etY3HgPF7psMZpMVgtxTnvpbaH7ClHpmdbgWT1bc1svRZqC3dMsMc8COxSKkO3y42EpSKYQTtzbj2zbw3UKv+kA7uqilNpmP3E/UXiB52fldIszBaUibXtOV+epp59anmLCJnNiSzQXm5G6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=P5tq0SauQs2y8UwEKWkYE9f7q61OaVarOqUsyFjouNbm36OWCjQ100/T4jOHiVHNg0eXBimYpOjQbxRfmqxoehAMZte+qDGVgb14kAGPwDhKVLQLyA0o+MSBlrJkPGsXKCdkrpxvFcqVpdYQr1VP405Hnx7tTM++7g5KG7ZHxCg=
Received: by 10.140.201.1 with SMTP id y1mr745722rvf.26.1199749582435;
        Mon, 07 Jan 2008 15:46:22 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1313hsg;
	Mon, 07 Jan 2008 15:46:22 -0800 (PST)
X-Sender: jefferis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.131.9 with SMTP id e9mr12204276wad.5.1199749581563; Mon, 07 Jan 2008 15:46:21 -0800 (PST)
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185]) by mx.google.com with ESMTP id y6si28350125nzg.1.2008.01.07.15.46.20; Mon, 07 Jan 2008 15:46:21 -0800 (PST)
Received-SPF: pass (google.com: domain of jefferis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.128.185 as permitted sender) client-ip=209.85.128.185;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of jefferis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.128.185 as permitted sender) smtp.mail=jefferis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by fk-out-0910.google.com with SMTP id 22so9454562fkq.13 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 07 Jan 2008 15:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding; bh=vroCvhugcaAYAhDgh9l9IOp9LJwnebPD6Z7PnULd0+E=; b=HC5rukk3M9GzRYKNB6ywOxKH+epG8MTta+phtxdwpRMZ1tUZLV8r+wYUsWgNFz+V1YL9Rlj3TdJ1qv04gXYxn/o9zunsY47RIFHkfFQc5/5uRgZDLw6FD1YSDfdRQLIGsFYZgw6vzGS+ZXzurbyZ1V8JNi4oFYHoWMAVw4D1Elg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding; b=Zvdd5WZveqb6723KC8s/c6uKuqhbemM/MDN8bQLQb5V0xsFqEuGgPNkJep3UGjkBQDtnymjLtI2fPnDtnc/84HfY1cZBt+OdV/vAad0lF7WCLCKs55W2jI/qMVFSNvTalnc8L2Hy8W0x+kOg39B015qeyRCgxcDRANm2W55PTpo=
Received: by 10.82.152.16 with SMTP id z16mr793264bud.17.1199749580073; Mon, 07 Jan 2008 15:46:20 -0800 (PST)
Received: from ?10.2.2.59? ( [131.111.85.79]) by mx.google.com with ESMTPS id 7sm3146968nfv.35.2008.01.07.15.46.18 (version=TLSv1/SSLv3 cipher=OTHER); Mon, 07 Jan 2008 15:46:19 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchRh37PvUonJr16Edy3EAAUURoPUg==
In-Reply-To: <alpine.LFD.1.00.0801071457040.3148-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69828>


On 7/1/08 22:58, "Linus Torvalds" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> Well, one thng we could do is to add a new concept, namely
> 
> core.autocrlf = warn
> 
> and make *that* the default.
> 
> It would do the check, but not actually convert anything, just warn about
> it.
> 

I think this is the best option so far.  Since this doesn't exist I was just
writing a hook for myself which fails rather than warns when CRLFs are
detected.  Not modifying content by default is a good mantra.  But getting a
couple of CRLF files into the repository and then noticing n commits down
the line and having to run a filter-branch session is a pain.  So +1 for the
default being a warning (that includes appropriate instructions) when
committing a file that looks like text but has CRLF.  And having a "fail"
option might be nice while you(?)'re at it:

core.autocrlf = fail # refuse to commit text files containing CRLF

Greg. 

PS Of course none of this would have helped me with those old mac CR files
that got into another repository ...
