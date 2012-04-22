From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] contrib: add win32 credential-helper
Date: Sun, 22 Apr 2012 11:07:17 -0700
Message-ID: <20120422180716.GA27339@sigill.intra.peff.net>
References: <1334861122-3144-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncCN2hpKqZChDakdH8BBoEgirMGA@googlegroups.com Sun Apr 22 20:07:26 2012
Return-path: <msysgit+bncCN2hpKqZChDakdH8BBoEgirMGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChDakdH8BBoEgirMGA@googlegroups.com>)
	id 1SM1By-0006cH-Jk
	for gcvm-msysgit@m.gmane.org; Sun, 22 Apr 2012 20:07:22 +0200
Received: by mail-vb0-f58.google.com with SMTP id l1sf11400269vba.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 22 Apr 2012 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=y16JN3tRQ8NOYXDcgLRM2lKi0LFzqOLk8QZraunfUxk=;
        b=ah6raYsXLbsOLB3QZj4hJqahmgnd6DA7shEfn2utFqepX7W3HDDtIF7hpJhu1kGkdp
         OJ88JnsDQe810Gcefqop9SXqzfYq8TSLJO+OFJzZZdagg9OborkC6GBrxPlf7vRoEDSS
         pm0+mUN8FIfi6NXHd2SN0OTueALZxKirBDqck=
Received: by 10.50.154.130 with SMTP id vo2mr2265277igb.1.1335118042045;
        Sun, 22 Apr 2012 11:07:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.151.199 with SMTP id us7ls4412115igb.1.canary; Sun, 22 Apr
 2012 11:07:20 -0700 (PDT)
Received: by 10.50.183.167 with SMTP id en7mr3818379igc.3.1335118040888;
        Sun, 22 Apr 2012 11:07:20 -0700 (PDT)
Received: by 10.50.183.167 with SMTP id en7mr3818378igc.3.1335118040879;
        Sun, 22 Apr 2012 11:07:20 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id wf3si3486995igb.3.2012.04.22.11.07.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Apr 2012 11:07:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 30922 invoked by uid 107); 22 Apr 2012 18:07:31 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 22 Apr 2012 14:07:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Apr 2012 11:07:17 -0700
In-Reply-To: <1334861122-3144-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196085>

On Thu, Apr 19, 2012 at 08:45:22PM +0200, Erik Faye-Lund wrote:

> Here's an updated version of my Windows credential-helper.

Sorry, I've been traveling and haven't had a chance to look at this
in-depth yet. I'll do so next week. In the meantime, I wanted to point
out this similar project:

  https://github.com/anurse/git-credential-winstore

which somebody else pointed me to a few days ago. I don't know yet if
your approaches are the same, or if it would be worth combining efforts
or not.

-Peff

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
