From: "Schuberth, Sebastian" <sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Fri, 8 Feb 2008 10:22:17 +0100
Message-ID: <E6DFE65BB5ADFE44BE13CCC976124447D5BCC8@fue-email2.ad.mc.com>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802071157360.2896@woody.linux-foundation.org> <4C918ADB-6FF5-458E-AC81-5683850E1FE4@zib.de> <alpine.LSU.1.00.0802080143440.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "Linus Torvalds" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Junio C Hamano" <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Luciano Rocha" <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, "Git Mailing List" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "msysGit" <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "Johannes Schindelin" <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Feb 08 10:23:05 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.175])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPRo-0007qt-7R
	for gcvm-msysgit@m.gmane.org; Fri, 08 Feb 2008 10:23:04 +0100
Received: by py-out-1314.google.com with SMTP id p69so537697pyb.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 08 Feb 2008 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-mimeole:content-class:mime-version:content-type:content-transfer-encoding:subject:date:message-id:in-reply-to:thread-topic:thread-index:references:from:to:cc:x-originalarrivaltime:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=cYH6DIKolBa/oS5j2/itzG4iySTI3USa9twUEkcJFmw=;
        b=B4D2MnfU3GR32Obq4pbO/ZX3bB6sGZ+NGkPwrocyLI/pCn1ohVu53TMKBlavSOg4V5PUx7ppv979DnoTrG4kG9LNOvgzd0wwCHu+354puF9BDGx8B1xFt1C+xqW3lFeJRQZRwq30rDz542ooHGPyZLq8BXzX5Z9/IckbwQ/HmLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-mimeole:content-class:mime-version:content-type:content-transfer-encoding:subject:date:message-id:in-reply-to:thread-topic:thread-index:references:from:to:cc:x-originalarrivaltime:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=mKmbzYBbFb3cHtb/eDNRT6Ky2HapDLc2bL5d7aGTj09KJZgClRSDpfDjeweAqiI0YS26uJbO/S2HuWR8lnbFUqzd90OglIvIByJoGTHXpOU5+PhTQmc/xzDAUyace1+WCiUmufsNdFRi8hTKUBJliqI91R3GbGuotrmdDsB4xS0=
Received: by 10.140.82.38 with SMTP id f38mr450111rvb.3.1202462549153;
        Fri, 08 Feb 2008 01:22:29 -0800 (PST)
Received: by 10.106.78.1 with SMTP id a1gr1676prb;
	Fri, 08 Feb 2008 01:22:29 -0800 (PST)
X-Sender: sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr26666200pyk.0.1202462548792; Fri, 08 Feb 2008 01:22:28 -0800 (PST)
Received: from mc.com (iris-63.mc.com [63.96.239.141]) by mx.google.com with ESMTP id x46si8448449pyg.3.2008.02.08.01.22.28; Fri, 08 Feb 2008 01:22:28 -0800 (PST)
Received-SPF: neutral (google.com: 63.96.239.141 is neither permitted nor denied by best guess record for domain of sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org) client-ip=63.96.239.141;
Authentication-Results: mx.google.com; spf=neutral (google.com: 63.96.239.141 is neither permitted nor denied by best guess record for domain of sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org) smtp.mail=sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org
Received: from CHM-EMAIL1.ad.mc.com by mc.com (8.8.8+Sun/SMI-SVR4) id EAA14803; Fri, 8 Feb 2008 04:22:19 -0500 (EST)
Received: from fue-email2.ad.mc.com ([192.168.152.32]) by CHM-EMAIL1.ad.mc.com with Microsoft SMTPSVC(6.0.3790.1830); Fri, 8 Feb 2008 04:22:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LSU.1.00.0802080143440.11591-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
Thread-Topic: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Thread-Index: Achp9WE35Qp1b1p/RYSXFtD2a0W7jAAPZo7g
X-OriginalArrivalTime: 08 Feb 2008 09:22:19.0300 (UTC) FILETIME=[1A59DE40:01C86A34]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73056>


> > Sebastian, can we easily modify the license dialog with Inno Setup?=20
> > The license should be displayed and a single click should be=20
> > sufficient to "continue".
>=20
> It looks like "LicenseFile" is a special variable in=20
> InnoSetup, and it is not _that_ easy to change it to an "I am=20
> okay with it; I read it" text. =20

Actually, the modification was trivial, I'm now using "InfoBeforeFile"
instead of "LicenseFile". I've pushed Steffen the change.

--=20
Sebastian
