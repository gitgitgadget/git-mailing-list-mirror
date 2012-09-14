From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 13:44:39 -0400
Message-ID: <20120914174439.GA16657@sigill.intra.peff.net>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBDO2ZWBAKGQE5OXDFQA@googlegroups.com Fri Sep 14 19:44:51 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBDO2ZWBAKGQE5OXDFQA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f186.google.com ([209.85.161.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBDO2ZWBAKGQE5OXDFQA@googlegroups.com>)
	id 1TCZwh-00082Z-7z
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:44:51 +0200
Received: by ggnr1 with SMTP id r1sf3338598ggn.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=YJmpqnzzppwNIABldbImrSgfTlmygEXzoEUHsrkrayI=;
        b=t/1rpbujHlyhK988YT75tyi1D05M/EpIc4QTKNNDUTTyZvlk8UEohldl15+z/6HlB9
         j4GjzsVJPGFGi4CkPjeQl3NafZT4xbUONhSLt70Z6htb7j9MlaRYLgjZStXR4d3uAkDc
         0wPvIiew28NoR8jL6Mj0M8zn4eWj70uK75+c0LHKpRzZ7F9zDq5rlwiSLd7nposGi17k
         U+SpcFEMrzryFI0x89uTru++pkgko4gDjnSummHOMpXSoury6ZY+o7M8P3xenLc2Vd8s
         A1DfoSn89K1Ik9BfWFDGfWYGAwwdPesnXTupHoSOS0IHZ1i6k8AoO3ybfoNvqP6xeUVZ
       
Received: by 10.50.13.230 with SMTP id k6mr1737477igc.0.1347644685521;
        Fri, 14 Sep 2012 10:44:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.160.202 with SMTP id xm10ls273290igb.3.gmail; Fri, 14 Sep
 2012 10:44:44 -0700 (PDT)
Received: by 10.42.167.196 with SMTP id t4mr1380014icy.27.1347644684853;
        Fri, 14 Sep 2012 10:44:44 -0700 (PDT)
Received: by 10.42.167.196 with SMTP id t4mr1380013icy.27.1347644684843;
        Fri, 14 Sep 2012 10:44:44 -0700 (PDT)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id vb5si622048igb.0.2012.09.14.10.44.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 10:44:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 16465 invoked by uid 107); 14 Sep 2012 17:45:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Sep 2012 13:45:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Sep 2012 13:44:39 -0400
In-Reply-To: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205516>

On Fri, Sep 14, 2012 at 06:41:45PM +0200, Erik Faye-Lund wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78c4286..7d1b34b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
>  # This test checks if command xyzzy does the right thing...
>  # '
>  # . ./test-lib.sh
> +
> +if ! which tput > /dev/null ; then

Testing the return value of "which" is not portable (I know, it's
insane; SunOS is the common offender). Use "type" instead.

-Peff

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
