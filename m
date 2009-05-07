From: Bernt Hansen <bernt@norang.ca>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Thu, 07 May 2009 18:22:35 -0400
Organization: Norang Consulting Inc
Message-ID: <87fxfgv9hw.fsf@gollum.intra.norang.ca>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302> <87ocu4vl8a.fsf@gollum.intra.norang.ca> <alpine.DEB.1.00.0905072332540.18521@pacific.mpi-cbg.de>
Reply-To: bernt@norang.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri May 08 00:22:54 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2BzQ-0002Oy-Ra
	for gcvm-msysgit@m.gmane.org; Fri, 08 May 2009 00:22:53 +0200
Received: by qyk7 with SMTP id 7so1630959qyk.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 May 2009 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :x-mail-handler:x-originating-ip:x-report-abuse-to:x-mho-user
         :received-spf:received:received:received:to:cc:subject:references
         :from:organization:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=/ziIbK40l7h9p3HIT/4MyBlGbGMFMqlXA0sOYPsKDug=;
        b=rf4V9qhXRNkq6VaidmKZYLEwO6sPPbq1GuT46YVO5RLi/KfJOgRTK1sJxPNeMgYp0j
         hHmoLsmspshHeC9DciUI0U44IoP5AnE3VvHKtbgS+dyro9BiD5fRFxsg1CII0/oOa4ql
         azce/qxyh783QaiConGUNbGmPdBUXTHcn2NI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-mail-handler:x-originating-ip:x-report-abuse-to:x-mho-user:to:cc
         :subject:references:from:organization:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=HVBONIgN/pjzxvteHW/LlKTcGM/1X2OqWT1ZDD9NK9SQh+Pg9nUPuvM6iSw87So62H
         n+0QDkFTuXUUzSfvs12jsli8jV4slbwUq/vmRS5tbumDSd0GePLpDgV0pu79KaNGVCsz
         6nyYqQe8hgm4Kp+VIHRsXHsN5k75qFPcMDETY=
Received: by 10.224.6.75 with SMTP id 11mr566033qay.15.1241734961866;
        Thu, 07 May 2009 15:22:41 -0700 (PDT)
Received: by 10.230.18.20 with SMTP id u20gr5100vba.0;
	Thu, 07 May 2009 15:22:41 -0700 (PDT)
X-Sender: bernt@norang.ca
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.120.13 with SMTP id b13mr84154bkr.28.1241734961122; Thu, 07 May 2009 15:22:41 -0700 (PDT)
Received: from mho-01-ewr.mailhop.org (mho-01-ewr.mailhop.org [204.13.248.71]) by gmr-mx.google.com with ESMTP id 13si72302fxm.4.2009.05.07.15.22.40; Thu, 07 May 2009 15:22:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of bernt@norang.ca designates 204.13.248.71 as permitted sender) client-ip=204.13.248.71;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of bernt@norang.ca designates 204.13.248.71 as permitted sender) smtp.mail=bernt@norang.ca
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca) by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.68) (envelope-from <bernt@norang.ca>) id 1M2BzE-000J8x-1G; Thu, 07 May 2009 22:22:40 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/SFjR80G40gI8YuzL6mfB1
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5]) by mail.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n47MMZ2N007117 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT); Thu, 7 May 2009 18:22:36 -0400
Received: from gollum.intra.norang.ca (localhost [127.0.0.1]) by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n47MMZKs014195; Thu, 7 May 2009 18:22:35 -0400
Received: (from bernt@localhost) by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n47MMZRb014194; Thu, 7 May 2009 18:22:35 -0400
In-Reply-To: <alpine.DEB.1.00.0905072332540.18521@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Thu\, 7 May 2009 23\:35\:31 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118530>


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thank you very much!.  It was a bug in my build process.  Fixed, pushed 
> and uploaded as Git-1.6.3-preview20090507-2.exe!  (The Portable Git is 
> unaffected of this bug.)

Thanks!  This new version fixes the problem :)

-Bernt
