From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] compat: Add another rudimentary poll() 
	emulation
Date: Sun, 30 May 2010 21:19:30 +0200
Message-ID: <201005302119.30340.j6t@kdbg.org>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org> <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com> <20100530003718.GA27024@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com,
 Jonathan Callen <abcd@gentoo.org>,
 git@vger.kernel.org,
 mduft@gentoo.org,
 Sverre Rabbelier <srabbelier@gmail.com>,
 Michael J Gruber <git@drmicha.warpmail.net>,
 msysGit <msysgit@googlegroups.com>,
 Marko Kreen <markokr@gmail.com>,
 Albert Dvornik <dvornik+git@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncCJOK-OFUEPL1iuAEGgTMuvPH@googlegroups.com Sun May 30 21:22:50 2010
connect(): No such file or directory
Return-path: <msysgit+bncCJOK-OFUEPL1iuAEGgTMuvPH@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCJOK-OFUEPL1iuAEGgTMuvPH@googlegroups.com>)
	id 1OIo5w-00055Y-Cw
	for gcvm-msysgit@m.gmane.org; Sun, 30 May 2010 21:22:48 +0200
Received: by wwb34 with SMTP id 34sf295047wwb.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 30 May 2010 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=usSuAWgptIYySco7sE6vSvXZRK1egbiKsjLg5Ci/iV8=;
        b=F7Nsl9/BcYKR0FbGKgiS3UDFfjlsg7RgSbmloqfjPtQOyl5jyQ6SCvLj95qWV9yyd2
         YUXfSnGuKEXYbpg6gaK/OfaDLcyzqUo1deWVA7NprOIKTWVqE6GCtUnyIRehAh36o/Xh
         stALL9NGcpJc+vhsPCMovVFW107DUymGX+axc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=Xv9EkoRPA3LjjBPNLVZl6gebGU8ZJWDey6JE+rJim4tk/usHozBwVkbmTHdINDpBHY
         ShYKMtDwMMOBivWiwQaJeh5W9zAt+qpJAxR5bDTK0jfrAAqhzUYfNrvhMluoI8jhdmuc
         mQ0DDUTAKVwG8Y0zIk2IlQ3EKfTjW4IBk2Xs8=
Received: by 10.223.6.91 with SMTP id 27mr101211fay.45.1275247346054;
        Sun, 30 May 2010 12:22:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.86.126.32 with SMTP id y32ls868501fgc.0.p; Sun, 30 May 2010 
	12:22:25 -0700 (PDT)
Received: by 10.87.38.12 with SMTP id q12mr338927fgj.8.1275247345150;
        Sun, 30 May 2010 12:22:25 -0700 (PDT)
Received: by 10.87.38.12 with SMTP id q12mr338926fgj.8.1275247345131;
        Sun, 30 May 2010 12:22:25 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 22si4942935fas.4.2010.05.30.12.22.25;
        Sun, 30 May 2010 12:22:25 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 825B7A7EB9;
	Sun, 30 May 2010 21:21:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6662519F758;
	Sun, 30 May 2010 21:19:30 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100530003718.GA27024@progeny.tock>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148012>

On Sonntag, 30. Mai 2010, Jonathan Nieder wrote:
> I would be interested to hear whether this works on msysgit and Interix.

It cannot work on msysgit because

- on Windows, select() works only for sockets, but we poll() on pipes, too;

- in our emulation layer, fds that are sockets must be unpacked with 
_get_osfhandle() before they can be passed to FD_SET() because (as Paolo has 
pointed out) FD_SET() must be populated with handles, not fds.

-- Hannes
