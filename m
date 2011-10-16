From: Dave Abrahams <dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org>
Subject: Higher-level change review?
Date: Sun, 16 Oct 2011 10:31:51 -0400
Message-ID: <m27h450zzc.fsf@pluto.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, magit <magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: magit+bncCJa5_IbRBBDZ1ev0BBoEVw5ZmA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Oct 16 16:31:56 2011
Return-path: <magit+bncCJa5_IbRBBDZ1ev0BBoEVw5ZmA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCJa5_IbRBBDZ1ev0BBoEVw5ZmA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1RFRkq-00013s-FJ
	for gcvgm-magit-3@m.gmane.org; Sun, 16 Oct 2011 16:31:56 +0200
Received: by qyk35 with SMTP id 35sf1632428qyk.3
        for <gcvgm-magit-3@m.gmane.org>; Sun, 16 Oct 2011 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:message-id:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=x84yIoeZPVht3zQxV7NIC/yKT1jxrQm/aoCuVUiGQgI=;
        b=p2ed7M3qadZOg6+uxc224cVVzErLlnJ0ur9ioEBxerdUzb/5YbiyZWx2JcyDYJwMI3
         VB4v9g/Ogh5cI/4izoc2zLFx8UZ8ATq0HIIZy+DT/iFVHxT3NmV4z4fPeNuV3dK116tr
         BVCzKnRrwCwA+521TDkyl2KUD0jT1q08n0/AQ=
Received: by 10.229.73.130 with SMTP id q2mr613835qcj.14.1318775513725;
        Sun, 16 Oct 2011 07:31:53 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.224.199.7 with SMTP id eq7ls9682289qab.3.gmail; Sun, 16 Oct
 2011 07:31:53 -0700 (PDT)
Received: by 10.224.33.205 with SMTP id i13mr10105760qad.5.1318775513117;
        Sun, 16 Oct 2011 07:31:53 -0700 (PDT)
Received: by 10.224.33.205 with SMTP id i13mr10105759qad.5.1318775513110;
        Sun, 16 Oct 2011 07:31:53 -0700 (PDT)
Received: from mail-vx0-f173.google.com (mail-vx0-f173.google.com [209.85.220.173])
        by gmr-mx.google.com with ESMTPS id j6si5639782qct.1.2011.10.16.07.31.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 07:31:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org designates 209.85.220.173 as permitted sender) client-ip=209.85.220.173;
Received: by vcbfl17 with SMTP id fl17so2819234vcb.18
        for <magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 16 Oct 2011 07:31:52 -0700 (PDT)
Received: by 10.52.21.67 with SMTP id t3mr16005013vde.104.1318775512804;
        Sun, 16 Oct 2011 07:31:52 -0700 (PDT)
Received: from pluto.luannocracy.com (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com. [207.172.223.249])
        by mx.google.com with ESMTPS id r5sm1585791vdw.2.2011.10.16.07.31.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 07:31:52 -0700 (PDT)
Received: by pluto.luannocracy.com (Postfix, from userid 501)
	id 4953F1116CC7; Sun, 16 Oct 2011 10:31:51 -0400 (EDT)
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.3 (darwin)
X-Original-Sender: dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org designates 209.85.220.173 as permitted sender) smtp.mail=dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183712>


I've been working on a fairly large Org outline and also merging
upstream code changes in a project that does a lot of refactoring, and
I've discovered that Git's diff format is poorly-suited to reviewing the
kinds of structural modifications I often deal with, where indentation
changes and large parts of documents are reorganized.  Are there better
ways to review, stage, etc. this kind of change than by using
straight-ahead diffs?  And, for the magit list, has anyone integrated
an improved review capability with magit?

Hints most appreciated,

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
