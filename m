From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 08:38:13 +0800
Message-ID: <be6fef0d1003091638w63881d08lde80a6180908e84d@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: 3tPSWSwcJB4s6r8pDNOv1px0.r3117D7vx8v33v0tv63947.r31@groups.bounces.google.com Wed Mar 10 02:24:27 2010
Return-path: <3tPSWSwcJB4s6r8pDNOv1px0.r3117D7vx8v33v0tv63947.r31@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f188.google.com ([209.85.217.188])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3tPSWSwcJB4s6r8pDNOv1px0.r3117D7vx8v33v0tv63947.r31@groups.bounces.google.com>)
	id 1NpAev-0004Ke-D3
	for gcvm-msysgit@m.gmane.org; Wed, 10 Mar 2010 02:24:25 +0100
Received: by gxk4 with SMTP id 4sf12913872gxk.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Mar 2010 17:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type;
        bh=LJusjKwVP5Qn2yub/vHkfJ7YP/5Zs1W1dmgC47GyWR8=;
        b=tTEVYogl1yZNeqtYxTXz6EZTKrKxmc5J56LhsTMdHz/lWNmTLowltwkUBcdaZIV7RP
         1PWw+KotNAvldOTwA+MUEL7sgGQwOnyJYOTOYxgYOyTda9SOMKblxa9s8C/6VdNLtDyF
         +FDtrHeXLjFxxnSuzpoVsv0fk6lhPOTi38v+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type;
        b=J4ib6eReMwWl4PYuP1LYIyyYGpdQTat37znMgAgOFuQFgrMtpcWoDuvnhPdHfTGM/v
         mvUBPq9LMSiia0nWSN5ikvpze6mwgxNgCXKBWhRpifjfamfHHXPRlA+i8ccyXA7BvavO
         uNJKxA4XMdQDEtV+E78oiXio+psW8+n8IOUSE=
Received: by 10.150.173.42 with SMTP id v42mr45555ybe.44.1268184244531;
        Tue, 09 Mar 2010 17:24:04 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.151.88.32 with SMTP id q32ls260546ybl.6.p; Tue, 09 Mar 2010 
	17:24:03 -0800 (PST)
Received: by 10.150.47.41 with SMTP id u41mr34273ybu.18.1268184243719;
        Tue, 09 Mar 2010 17:24:03 -0800 (PST)
Received: by 10.231.172.83 with SMTP id k19mr50534ibz.29.1268181496325;
        Tue, 09 Mar 2010 16:38:16 -0800 (PST)
Received: by 10.231.172.83 with SMTP id k19mr50533ibz.29.1268181496294;
        Tue, 09 Mar 2010 16:38:16 -0800 (PST)
Received: from mail-iw0-f185.google.com (mail-iw0-f185.google.com [209.85.223.185])
        by gmr-mx.google.com with ESMTP id 19si695995iwn.14.2010.03.09.16.38.15;
        Tue, 09 Mar 2010 16:38:15 -0800 (PST)
Received-SPF: pass (google.com: domain of rctay89@gmail.com designates 209.85.223.185 as permitted sender) client-ip=209.85.223.185;
Received: by iwn15 with SMTP id 15so6935909iwn.7
        for <msysgit@googlegroups.com>; Tue, 09 Mar 2010 16:38:15 -0800 (PST)
Received: by 10.231.151.207 with SMTP id d15mr274287ibw.44.1268181493113; Tue, 
	09 Mar 2010 16:38:13 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of rctay89@gmail.com designates 209.85.223.185 as permitted sender) 
	smtp.mail=rctay89@gmail.com; dkim=pass (test mode) header.i=@gmail.com
X-Original-Sender: rctay89@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/1a323b5ee3684208
X-Message-Url: http://groups.google.com/group/msysgit/msg/dbcd8a988b53b8d
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>

Hi,

On Wed, Mar 10, 2010 at 2:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Git Release Notes (Git-1.7.0.2-preview20100309)
> Last update: 9 March 2010

I really appreciate you and msysgit's community's work, thanks.

-- 
Cheers,
Ray Chuan
