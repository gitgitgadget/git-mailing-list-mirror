From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: t9700-perl-git.sh is broken on some configurations
Date: Fri, 04 Mar 2016 11:58:24 +0100
Message-ID: <1457089104.2660.79.camel@kaarsemaker.net>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
	 <20160304085649.GA29752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:02:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abnV1-00037P-JG
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 12:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbcCDLCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 06:02:18 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32917 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbcCDK61 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 05:58:27 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so15190555wml.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=251zCFocvmvqbaHz4WMzaAaYcX6He+F+nAn+6tcPeso=;
        b=Q9dGXPQZT8QcHFi2vhcy+oRVmMomrqk9QBmpFoZEYQ6SNalQoxUnQJOTnjFoIbZk3z
         gQ3IXzdVycpJtTw41zn4m7m4STMXrgslGaxso16locwT1LmxRZVc2yuiDJrDqoz7bHkX
         a6xaUHQhtsRZUgoqPFCL7VZHaQcxWar5RL1HciWLoDZN9zXLz0225fyRCZP4Rr6vfqBO
         SnngFccrVB0CO1D42DsjKPQ9quo+3qpVUdqwNh+IYJTcQMofZ0QcbmOn69/uPJ5RtkJ3
         S+niS3bfhBmeawoj0wiKbPFvuYlrCLqyy7tZHePHk1Qjb0/JmO6RCmE+74bZNIm7c85l
         pi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=251zCFocvmvqbaHz4WMzaAaYcX6He+F+nAn+6tcPeso=;
        b=G6/FbSHbhMUZW9DubalHZfkrn8gY+/b0G+TidkB4/Uj3HAneYSinMQZ2sCIUgffFeN
         MT5NZ8xQ1IJm/QbSkJA5Rt2JWZyeYd7d7v6lACdEd5nPZUqRqMX5s2/wrvDhqxnUu9rN
         7SSxRU2vMgD6YkkW5EVWybCkJpYYJrmfLTxB20DrN869rUY547GEJMabzI4FwQpOtENe
         lkJ0cAukckkLoWcg9aHiqJa8vRe7Jgrxt7VG1FVOMcaZjM9XR37FiOhmBSLF1JlfbkfI
         pkrZf7yj+9p9qAYTfWWCqZqsNnnm4jgC+reotjz01Q6JJhS6nuFD3f6A6efpyjgyahXt
         vC6Q==
X-Gm-Message-State: AD7BkJLtwkPumi654f9WAl2hlO2GzBNpEaX2os1ogEYXzeM/gqKiDolbKO2IxEZRcLusOQ==
X-Received: by 10.194.121.34 with SMTP id lh2mr8200837wjb.145.1457089106369;
        Fri, 04 Mar 2016 02:58:26 -0800 (PST)
Received: from seahawk.local (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id m6sm2761673wje.21.2016.03.04.02.58.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2016 02:58:25 -0800 (PST)
In-Reply-To: <20160304085649.GA29752@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288245>

On vr, 2016-03-04 at 03:56 -0500, Jeff King wrote:
> ? Those are just guesses, but if we are tickling a bug in perl's parser,
> this might avoid them. I also wondered when "/r" appeared. It was in
> 5.14, so you're presumably good there. The "use" statement at the top of
> the script says "5.008", so perhaps we should be writing it out longhand
> anyway (that version is "only" 5 years old, so I suspect there are still
> systems around with 5.12 or older).

Knowing the system Christian is testing on, I think the problem is that
the tests are actually being run against perl 5.10, which RHEL 6 ships
as system perl. As that's still a supported OS, writing tests in a form
compatible with it would be a good thing :)

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
