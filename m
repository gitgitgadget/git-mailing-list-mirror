From: "Marco Costalba" <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [ANNOUNCE] qgit-2.1 and qgit-1.5.8
Date: Mon, 31 Dec 2007 08:35:29 +0100
Message-ID: <e5bfff550712302335ie96e143g55c93e984fba6aaa@mail.gmail.com>
Reply-To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski-mXXj517/zsQ@public.gmane.org>
To: "Git Mailing List" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,  "Linux Kernel Development" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 31 08:35:57 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9FBj-0004k1-L6
	for gcvm-msysgit@m.gmane.org; Mon, 31 Dec 2007 08:35:56 +0100
Received: by wa-out-0708.google.com with SMTP id n36so198074wag.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 30 Dec 2007 23:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=2foTDxJp2It4k/YQPi8gZLT6YhTAC9sKr8Ci2JBy8ic=;
        b=dM/6K2fuYSEPhtV65BjHKLSxJTFL95Wlam7FiGDiBdFKnwV+CU20+8TI+Jr49SESndHtwBKVEZB1qUKuxTht7A7rKEVSNKZgF48fCLg6Dg1tSZWo5DkzrekhMOOw/MhllPRU9dpmjO0OEf+arbD1Fe9yjkx3UYnxB7uyZ3Qghdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=fYSH2Thc8tjtqC1IUx16EhUKxmYgGaocKgEl51A9XaQthUKNhExbb5DFCz+Sz1nbVW20DHV6SYFoTTpeEr5wLIOfit9Za6/3qVQyiKJW7cgmo1Bjmtct6BQAFA2VRKPZFvisBniRDbMHqK4Ido1XSZTlBEwMIlng8DlD70lGyCg=
Received: by 10.114.103.1 with SMTP id a1mr439260wac.18.1199086530907;
        Sun, 30 Dec 2007 23:35:30 -0800 (PST)
Received: by 10.106.159.13 with SMTP id h13gr1299pre;
	Sun, 30 Dec 2007 23:35:30 -0800 (PST)
X-Sender: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.106.1 with SMTP id e1mr7055957wac.28.1199086530614; Sun, 30 Dec 2007 23:35:30 -0800 (PST)
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191]) by mx.google.com with ESMTP id k36si1148401waf.0.2007.12.30.23.35.29; Sun, 30 Dec 2007 23:35:30 -0800 (PST)
Received-SPF: pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.191 as permitted sender) client-ip=209.85.198.191;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.191 as permitted sender) smtp.mail=mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0910.google.com with SMTP id c24so2909733rvf.47 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 30 Dec 2007 23:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition; bh=DGFWSckInT2H43OQmQcuk50ihikVvhLBMsIqsBq3MUM=; b=wyOVgvtkdtFP34yl/6nM2nHXJPGU+v/TYF9ZtK8eiyHe1hc46jkv/sNGVDD5kJTwlCD6qVubT0vBb8xXG7XlTxt5EUXhczML7z229i7tKFjlj+FpEIX9w9u5qJU5X2kMShsqyJhtcvyfPxYWJw6GDKtAouN8wxr72z87Q4Cnsu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition; b=evAbP4VG1uHopWGuE4H4hJnbe8n2JnOjaVHQO7vuYojGnc/XtTmsHyGAdo8plhfR54h61OvnbbBd/SEihlqMTSK+UptrfETr3PSdo09I2Q+iMFUbNOZxhTIpSSgLRs2PQ6Us9/UFBUbbhSBIH9FzTHiFiLsq3WWH0hJU7xfveII=
Received: by 10.140.249.20 with SMTP id w20mr6191882rvh.7.1199086529048; Sun, 30 Dec 2007 23:35:29 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 23:35:29 -0800 (PST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69394>


Hi all,

  new versions of Qt4 based qgit-2.1 and stable Qt3 based qgit-1.5.8
have been released.

Download tarballs from
http://sourceforge.net/project/showfiles.php?group_id=139897

Or directly from git repositories

git://git.kernel.org/pub/scm/qgit/qgit.git   (qgit-1.5.8)
git://git.kernel.org/pub/scm/qgit/qgit4.git  (qgit-2.1)


Stable qgit-1.5.8 has only maintenance fixes, not a lot indeed, it
happens to be already very stable.

New stuff is in qgit-2.1, you can find a detailed changelog at

http://git.kernel.org/?p=qgit/qgit.git;a=shortlog


After popular request, this time I have packaged qgit-2.1 in a nice
Windows installer (Inno Setup based) downloadable from the above
sourceforge link, so that our Window's friends can try qgit without
worrying about compilers, Qt libraries and other geeky things ;-)

Window installer will ask you to locate the msysgit directory. Indeed
msysgit is the only supported git distribution under Windows, because
Cygwin has some issues and is also muuuch slower.

So the only prerequisite is to have already installed msysgit
(http://code.google.com/p/msysgit/)


Happy new year 2008 !
Marco
