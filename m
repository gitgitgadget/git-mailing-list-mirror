From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: Using VC build git (split patch)
Date: Mon, 17 Aug 2009 20:22:19 +0200
Message-ID: <4A899FDB.8080308@gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 20:21:42 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md6ps-0001au-I7
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 20:21:36 +0200
Received: by yxe34 with SMTP id 34so5108679yxe.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:received:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=BmMgUaV91O1gJLMqWcpGzp3ZtbPk74eEJMcGmaf2PMA=;
        b=pvrxIdJh6OudsuBaiWzU6lAL00AhFNTGDaW2OT7sZHKt68dimxsmM8FdULzR5KQM4V
         2CyHH6El4aG2ywgrq/XB3zAEyZsG4znfkXIc38R9Mmd7SOTlF42ajqGUjXlL3ys9i3pS
         0TJYtWkgXjp6ot8GUtLMxIzYkwj5VYxtClqTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=yidCnU0JY2waB4PDx48mzd359raDpSiSKXu4iu3c/U5AtQjvM1ccR8hzFSB4U7ykiT
         G1cBymew0QxJbmH6ilp2BpsUvOBUUbacQnnTSz9m0O0jo2cOOLYkujHa6xCX1CkMFN0e
         BXlOvem0pC44yUQS9wQN93mKgTJzN/3PVl6j8=
Received: by 10.150.59.12 with SMTP id h12mr1224965yba.6.1250533289891;
        Mon, 17 Aug 2009 11:21:29 -0700 (PDT)
Received: by 10.176.94.14 with SMTP id r14gr6372yqb.0;
	Mon, 17 Aug 2009 11:21:24 -0700 (PDT)
X-Sender: marius@storm-olsen.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.35.16 with SMTP id i16mr12323ebi.8.1250533282576; Mon, 17 Aug 2009 11:21:22 -0700 (PDT)
Received: by 10.210.35.16 with SMTP id i16mr12322ebi.8.1250533282557; Mon, 17 Aug 2009 11:21:22 -0700 (PDT)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215]) by gmr-mx.google.com with ESMTP id 15si1108614ewy.0.2009.08.17.11.21.22; Mon, 17 Aug 2009 11:21:22 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.219.215 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) client-ip=209.85.219.215;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 209.85.219.215 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) smtp.mail=marius@storm-olsen.com
Received: by ewy11 with SMTP id 11so3347676ewy.35 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 11:21:22 -0700 (PDT)
Received: by 10.210.118.14 with SMTP id q14mr7371686ebc.31.1250533281919; Mon, 17 Aug 2009 11:21:21 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206]) by mx.google.com with ESMTPS id 28sm766425eyg.12.2009.08.17.11.21.19 (version=SSLv3 cipher=RC4-MD5); Mon, 17 Aug 2009 11:21:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126248>


Frank Li said the following on 17.08.2009 15:13:
 > Thanks Dscho for reviewing my patch patient.
 > I split my patch and read SumbittingPatchs.
 >
 > I try to use git format-patch -M --stdout origin/master | git
 > imap-send to send patch directly according to guide.
 > But imap-send has not ported to msysgit.

Hi Frank,

Could you please also update your repo at repo.or.cz, then it'll be 
easier if anyone wants to help you in the process of streamlining the 
patch series?

--
.marius
