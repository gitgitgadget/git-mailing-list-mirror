From: "Marco Costalba" <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC] Distributing Windows binary package compiled with non
 gpl code
Date: Thu, 27 Dec 2007 19:32:09 +0100
Message-ID: <e5bfff550712271032q25d135e7y47d68337e937d401@mail.gmail.com>
Reply-To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Dec 27 19:32:39 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7xX2-0003qy-H3
	for gcvm-msysgit@m.gmane.org; Thu, 27 Dec 2007 19:32:36 +0100
Received: by ug-out-1516.google.com with SMTP id 1so944062uga.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Dec 2007 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=KpaYqrNJ07uHEYYklO6hE8j3dJ5YHBTtYkBvKSPzgPk=;
        b=KnAoJd/cmcCRUvtcNxSQzlQWDcdaZF8DS9evY2ATwta7caZoHJ4pnGBHANw+/zA1im7xpi1Btnk63J2Lhv9dKSQz/VOC/HKpgucMVcilJJCzG2ZYSxN1+mEHMw5pQ71Zmv7OrzkTXR5eVjGP9AR2LMC09abbVXSl9JmuQW+tk4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=3nByX7QBDEMNejleqairlKH+oXZl7bdfyxuimAwLN78rQx1GUZuIfAa1WQhEVXBXvZN9eLboaP64MzMHnYZnY3LQHy3u/hRMYKCLK/j0McXZ9z1PrJEmEpaD015kKiPQQb3LXMLLl9/22Z1FPRkCGsRuoVeQThKaLEqFUzfzXuM=
Received: by 10.151.6.2 with SMTP id j2mr130826ybi.23.1198780332056;
        Thu, 27 Dec 2007 10:32:12 -0800 (PST)
Received: by 10.107.114.37 with SMTP id r37gr1286prm;
	Thu, 27 Dec 2007 10:32:11 -0800 (PST)
X-Sender: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.161.11 with SMTP id j11mr4309035wae.29.1198780330394; Thu, 27 Dec 2007 10:32:10 -0800 (PST)
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184]) by mx.google.com with ESMTP id k36si1615330waf.0.2007.12.27.10.32.09; Thu, 27 Dec 2007 10:32:10 -0800 (PST)
Received-SPF: pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.184 as permitted sender) client-ip=209.85.198.184;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.184 as permitted sender) smtp.mail=mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0910.google.com with SMTP id l15so2163953rvb.20 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 27 Dec 2007 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition; bh=ljG6NvyzLXgElTrcKuCN14q9XQrEcHCj2BogJVELpf0=; b=OZr0AffUlBl9wG1Oh/6nzRDTBeGE9AGNfh6ZbauyPimd9v4JdsM6Jy4wUje+XQPxxIgObIZv+NHbeecSjqRx4P904VOTgjhVWT1GadBEulrkpTb5VjDjAiwt0zKqx+TXRyJ9JQfajvd243LyKr9gPirnK2S/YzaZ5/7pA7ZyY00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition; b=aZ0TS7NyYKnoUaeCoBN8ohyR5ieuDWphv989HXAdiTcLbiCfhgpeqj7jBxGWS5hoV2Ry3xwriQ8BilbvzKx3EHOcm4+YMsEHjFjb2syKy0F4QpCF263l7fgoor2ytDNe2HWCRCxx3a9OQb9dcdBYpfA0ZNIEtOYGEfA274vyCSE=
Received: by 10.140.136.6 with SMTP id j6mr4219619rvd.199.1198780329887; Thu, 27 Dec 2007 10:32:09 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 27 Dec 2007 10:32:09 -0800 (PST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69264>


It seems I have finally worked out a binary installation of qgit under Windows:

http://digilander.libero.it/mcostalba/qgit2.1rc1_win.exe


It seems to work with msysgit distribution of git. It DOES NOT work as
expected with Cygwin git that IMHO is very broken for qgit. I ended up
giving the blame to mingw, but after testing the MSVC compiled qgit
both with msysgit and cygwin git I have to say that the problem
*probably* is not in mingw but in cygwin.

Anyhow the MSVC 2008 compiled qgit seems stable and works as
advertised. Now that's the question:

Packaged together with qgit.exe there are the necessary Micorsoft
Visual C dll's. Is this a problem for someone?

I could try to compile again everything with mingw and test if under
msysgit the artifacts that appear with cygwin are fixed, if this
succeed I could prepare a binary package built with mingw and
distribute this instead, but would be this necessary?


qgit is GPL and I for sure want to be stick to GPL, so I don't know if
this can be an issue.


Thanks for help me in clarifing this point

Marco


P.S: Just to be fair I have to say that developing under Windows with
MSVC is much easier, because the debugging tools available with MSVC
2008 are very advanced and powerful, nothing similar exists _for
Window_ in the GPL camp. Indeed MSVC (together with SQL Server) are
(the only) two good products from MS, so good that even do not seem
produced by Microsoft !
