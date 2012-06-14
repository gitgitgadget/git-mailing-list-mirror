From: lei yang <yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: how to get the formated patches from the merge id
Date: Fri, 15 Jun 2012 00:25:12 +0800
Message-ID: <CAHsH0E98t7EcvXM0zSjMGHcd5u4_Lp6B7q9KAhcE0eyo-tXnWw@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: git-users+bncCJHCj86PEhDooOj-BBoEmnDTGg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Jun 14 18:25:18 2012
Return-path: <git-users+bncCJHCj86PEhDooOj-BBoEmnDTGg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncCJHCj86PEhDooOj-BBoEmnDTGg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SfCrB-0006FY-GZ
	for gcggu-git-users@m.gmane.org; Thu, 14 Jun 2012 18:25:13 +0200
Received: by vbbez10 with SMTP id ez10sf1735986vbb.3
        for <gcggu-git-users@m.gmane.org>; Thu, 14 Jun 2012 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:date:message-id:subject:from
         :to:x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=DXiDFtAAxAfNsgveBbhBPPp12sdZpHUcV6fhvk9fHAc=;
        b=KLcbzVz+VLoK2nDT5yvkBgnT+0Q/KGiqqNXyqAUUWHRRrnYtuEKMboVKFJxKS+YGX1
         BY6Vbt+i/NpBr16BfOnW3RxuTOvqqigWgFQtrsD04/DSwPk/OTpDM5dUCm8zL0Pjtfdg
         Unrz38hxEx7Ghb6dpOgqy95lJScfBut0q0iqI=
Received: by 10.52.23.65 with SMTP id k1mr192465vdf.7.1339691112977;
        Thu, 14 Jun 2012 09:25:12 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.220.219.79 with SMTP id ht15ls320528vcb.3.gmail; Thu, 14 Jun
 2012 09:25:12 -0700 (PDT)
Received: by 10.52.179.69 with SMTP id de5mr1306687vdc.7.1339691112263;
        Thu, 14 Jun 2012 09:25:12 -0700 (PDT)
Received: by 10.52.179.69 with SMTP id de5mr1306685vdc.7.1339691112255;
        Thu, 14 Jun 2012 09:25:12 -0700 (PDT)
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com [209.85.220.174])
        by gmr-mx.google.com with ESMTPS id u6si1711882vdi.1.2012.06.14.09.25.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 09:25:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.220.174 as permitted sender) client-ip=209.85.220.174;
Received: by vcbf11 with SMTP id f11so1435318vcb.33
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 14 Jun 2012 09:25:12 -0700 (PDT)
Received: by 10.52.100.4 with SMTP id eu4mr1154255vdb.66.1339691112124; Thu,
 14 Jun 2012 09:25:12 -0700 (PDT)
Received: by 10.52.97.35 with HTTP; Thu, 14 Jun 2012 09:25:12 -0700 (PDT)
X-Original-Sender: yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.220.174 as permitted
 sender) smtp.mail=yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200016>

Hello list:

eg:

commit 0e93b4b304ae052ba1bc73f6d34a68556fe93429
Merge: b724cc1 51bfd29

how can I from 0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get the
formated patch ?
(I know we can do git format-patch b724cc1..51bfd29, but how to from
0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get?)

Lei

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
