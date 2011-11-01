From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 21:43:41 +0100
Message-ID: <CABPQNSb07fRUCqPCX7JbfGW_55etZZtPyP=yuCKV9wJeNP-iQw@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2>
 <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org, 
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com, 
	Karsten Blees <blees@dcon.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncCOPdven-DxCntMH1BBoExbdzMg@googlegroups.com Tue Nov 01 21:44:54 2011
Return-path: <msysgit+bncCOPdven-DxCntMH1BBoExbdzMg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCntMH1BBoExbdzMg@googlegroups.com>)
	id 1RLLCX-0005GB-KU
	for gcvm-msysgit@m.gmane.org; Tue, 01 Nov 2011 21:44:53 +0100
Received: by qyc1 with SMTP id 1sf668182qyc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Nov 2011 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Epl6jJqlBwrTAqoEZAt0Mc9mb+MrDaFbcEnjV5q3X9M=;
        b=5/PtHn0NIEZfESqTM7YJ9BcmHSbBzg5u1pT0Lf5L6NaryxLrxZqoDymhVjGpJi5r8g
         9Mp6orhppLRT14wqqP25+hhYh8CIDAXIXTnzkvKvuiRgwK8E7AbKCMb4Tos+/7wvXe2n
         rzD41tr1JkPhOUNr6XH/R8JFyXKob2bT/oxGE=
Received: by 10.224.197.130 with SMTP id ek2mr426354qab.15.1320180263544;
        Tue, 01 Nov 2011 13:44:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.6.80 with SMTP id 16ls138006qay.7.gmail; Tue, 01 Nov 2011
 13:44:22 -0700 (PDT)
Received: by 10.224.192.10 with SMTP id do10mr350722qab.6.1320180262435;
        Tue, 01 Nov 2011 13:44:22 -0700 (PDT)
Received: by 10.224.192.10 with SMTP id do10mr350721qab.6.1320180262426;
        Tue, 01 Nov 2011 13:44:22 -0700 (PDT)
Received: from mail-qw0-f49.google.com (mail-qw0-f49.google.com [209.85.216.49])
        by gmr-mx.google.com with ESMTPS id j6si43942qct.1.2011.11.01.13.44.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 13:44:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.216.49 as permitted sender) client-ip=209.85.216.49;
Received: by qap15 with SMTP id 15so7288088qap.8
        for <msysgit@googlegroups.com>; Tue, 01 Nov 2011 13:44:22 -0700 (PDT)
Received: by 10.68.209.103 with SMTP id ml7mr1957697pbc.17.1320180262058; Tue,
 01 Nov 2011 13:44:22 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Tue, 1 Nov 2011 13:43:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.216.49 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184589>

On Tue, Nov 1, 2011 at 7:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Tue, 1 Nov 2011, Erik Faye-Lund wrote:
>> I've applied the patches to 'devel', verified that the result builds,
>> and pushed it out.
>
> I've applied your patches and made up commit messages. So far, I only
> tested with MSVCE 9.0 (AKA Express 2008) before running out of time.
> Please have a look at the commits (since I could build a git.exe with the
> correct version, I felt comfortable enough to push out to 'devel').

The commits look good to me. Thanks for following up on it :)

> Maybe if someone donates Jenkins resources, we could make an automatic
> branch in the future that has git.sln in it (similar to the 'html' branch
> in git.git).

CloudBees seems to have some kind of a free Jenkins service. Perhaps
it's sufficient?
http://www.cloudbees.com/dev-pricing.cb
