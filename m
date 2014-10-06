From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Mon, 6 Oct 2014 09:17:07 +0400
Message-ID: <20141006051707.GA23305@seldon>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	marat@slonopotamus.org
To: gitster@pobox.com
X-From: msysgit+bncBCE7TAPITACRBWOLZCQQKGQEZMDCZUY@googlegroups.com Mon Oct 06 07:17:17 2014
Return-path: <msysgit+bncBCE7TAPITACRBWOLZCQQKGQEZMDCZUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f64.google.com ([74.125.83.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBWOLZCQQKGQEZMDCZUY@googlegroups.com>)
	id 1Xb0fa-0007FC-7z
	for gcvm-msysgit@m.gmane.org; Mon, 06 Oct 2014 07:17:14 +0200
Received: by mail-ee0-f64.google.com with SMTP id d49sf113802eek.19
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Oct 2014 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=dQZq01cPw9CGGnMH0DHcq/W9lrq2g5CwAZ1MvZ9xN7Y=;
        b=AurqpAlefQuLNb41GG3cfEDzIfRJazoqQAhr6IO/cepxQJkybLapjKfOWCwgorPZUa
         YdZIkh10rpSvQSv+hgbVMv3ylTs3w1pUfHpxCXdeOcHfUjabfVwYeaLqoG+aWbu6kVG2
         XWfi84/GS8tJPgPWrnFB+i30LToreQ667Nqf+KN0ZJ9uifL23d8/rO4g5uyXkHDJlwUy
         l6szzlbY2lwLO728yZDSPYw/m551CiR3CqeZjRq64vHV/NFCSpTDuaTjcw510bwIvZbP
         Cu2cGX7WISRzgr7ZBpxIl3RPsodxYozH9qSA562cjm429Ohqoj3oC2axFzpE7GFYGecW
         kuxg==
X-Received: by 10.180.126.103 with SMTP id mx7mr37497wib.10.1412572633967;
        Sun, 05 Oct 2014 22:17:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.97.2 with SMTP id dw2ls178250wib.29.canary; Sun, 05 Oct
 2014 22:17:13 -0700 (PDT)
X-Received: by 10.180.106.197 with SMTP id gw5mr2149153wib.1.1412572633026;
        Sun, 05 Oct 2014 22:17:13 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id go4si470382wib.3.2014.10.05.22.17.12
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Oct 2014 22:17:12 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Xb0fT-00064k-LX; Mon, 06 Oct 2014 09:17:08 +0400
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257908>

On Tue, Sep 30, 2014 at 11:02:29AM +0400, Marat Radchenko wrote:
> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).

Junio, ping?

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
