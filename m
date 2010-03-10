From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 08:48:01 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4B974EB1.4010001@atlas-elektronik.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "msysgit@googlegroups.com" <msysgit@googlegroups.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: 3eFWXSwAAB7AcioiWYjWeeWbUWhekfi.Sec@groups.bounces.google.com Wed Mar 10 09:17:17 2010
Return-path: <3eFWXSwAAB7AcioiWYjWeeWbUWhekfi.Sec@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f188.google.com ([209.85.217.188])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3eFWXSwAAB7AcioiWYjWeeWbUWhekfi.Sec@groups.bounces.google.com>)
	id 1NpH6T-0007Xd-Cr
	for gcvm-msysgit@m.gmane.org; Wed, 10 Mar 2010 09:17:17 +0100
Received: by gxk4 with SMTP id 4sf13508879gxk.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 10 Mar 2010 00:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:x-auditid:received:received
         :x-spam-checker-version:x-spam-level:x-spam-status:received
         :message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version
         :x-brightmail-tracker:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=HX0tKGsBbrDySWgcjKegahVEYPewPqJbtkmFf+f4U/I=;
        b=NKY7H5BEqT+YooLLPc9msO03nJHjLuSP0HQouXRvx6Nr+k3ej9IzXtt2vrgRKZK3iJ
         yZM07DSx7ytqRm 
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-auditid:x-spam-checker-version
         :x-spam-level:x-spam-status:message-id:date:from:organization
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:x-brightmail-tracker
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=KiMzV+R0j8ukaxRXsN2VnCSuYp52wW8W+D+V3bKtsxp0CPYiD0dAZ+nS3qK5i0Mnpd
         dkDjFl4wu7HCbbYxOKPmn7jID0JYyazAuuaksz1/1YiY7B/EtXwpRCOo3A+moyCOIwol
         EoVyH5mIVrxivNUXayrqlI4UoUKD9rcoU0fZM=
Received: by 10.90.107.19 with SMTP id f19mr96825agc.58.1268209017028;
        Wed, 10 Mar 2010 00:16:57 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.86.126.20 with SMTP id y20ls237321fgc.3.p; Wed, 10 Mar 2010 
	00:16:55 -0800 (PST)
Received: by 10.87.40.5 with SMTP id s5mr65408fgj.6.1268209014993;
        Wed, 10 Mar 2010 00:16:54 -0800 (PST)
Received: by 10.223.61.6 with SMTP id r6mr54534fah.9.1268207317655;
        Tue, 09 Mar 2010 23:48:37 -0800 (PST)
Received: by 10.223.61.6 with SMTP id r6mr54533fah.9.1268207317632;
        Tue, 09 Mar 2010 23:48:37 -0800 (PST)
Received: from mail96.atlas.de (lxsrv96.atlas.de [194.156.172.86])
        by gmr-mx.google.com with ESMTP id 11si84760fxm.10.2010.03.09.23.48.37;
        Tue, 09 Mar 2010 23:48:37 -0800 (PST)
Received-SPF: neutral (google.com: 194.156.172.86 is neither permitted nor denied by best guess record for domain of stefan.naewe@atlas-elektronik.com) client-ip=194.156.172.86;
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id ACF6C1389F
	for <msysgit@googlegroups.com>; Wed, 10 Mar 2010 08:48:36 +0100 (CET)
X-AuditID: 0ac86512-00000094000005bc-c2-4b974ed41697
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Mar 2010 08:48:36 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 257A92716A;
	Wed, 10 Mar 2010 08:48:36 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 11C4627169;
	Wed, 10 Mar 2010 08:48:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
X-Enigmail-Version: 1.0.1
X-Brightmail-Tracker: AAAAAA==
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	194.156.172.86 is neither permitted nor denied by best guess record for 
	domain of stefan.naewe@atlas-elektronik.com) smtp.mail=stefan.naewe@atlas-elektronik.com
X-Original-Sender: stefan.naewe@atlas-elektronik.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/1a323b5ee3684208
X-Message-Url: http://groups.google.com/group/msysgit/msg/713732d170a45ec8
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>

On 3/9/2010 7:24 PM, Johannes Schindelin wrote:
> Git Release Notes (Git-1.7.0.2-preview20100309)
> Last update: 9 March 2010

Thanks to all for the good work!

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Fife. n. Small shrill instrument that rhymes with wife.
