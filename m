From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Git for Windows RFC: Code of Conduct
Date: Sun, 21 Jun 2015 17:53:36 +0200
Organization: gmx
Message-ID: <dbf4ae09e97a8075574fe599a2262f69@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBBF4TOWAKGQEQ3LW6LY@googlegroups.com Sun Jun 21 17:53:42 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBBF4TOWAKGQEQ3LW6LY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBBF4TOWAKGQEQ3LW6LY@googlegroups.com>)
	id 1Z6hYz-00084E-Vw
	for gcvm-msysgit@m.gmane.org; Sun, 21 Jun 2015 17:53:42 +0200
Received: by wggz12 with SMTP id z12sf41959260wgg.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 21 Jun 2015 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:subject:organization
         :message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=irrXQqcIBlIj5s8nZXEznhUZWThTCgjwcTcQp2WgSBE=;
        b=RQpLqd8N5z/1i6z9+V2EYuXgLtSbdUDr1aLGlmsBjw8YZL55m9U++4dD3ht3yvq20F
         W6pZl9ba4iVwL4ph2UvWSPsOrohYzUUAXyBJMti19AOA9ImFiYiOjWqRuHRpNtsI1epk
         Da1Gxii3M4la3rFvU0crOlg4C+acov2Rpc3U/MInBpNePSt1PKRTcNtd//nt+Vzlj15v
         Hij3gvzL9h8xzneRRb8g6p7iLQb5RyXQ0U6hrM6pNP9LFKn9OaXpYuVY1OkkNqO/Mwsa
         PzdpYhUjjylV/F2HBdL2JTjjSxLaqh7hvJkXVoxwNTe0+yndjbgEmiMh0BNGDETAxAdQ
         Yu+Q==
X-Received: by 10.152.203.165 with SMTP id kr5mr92386lac.14.1434902021249;
        Sun, 21 Jun 2015 08:53:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.232 with SMTP id r8ls56910lal.55.gmail; Sun, 21 Jun
 2015 08:53:39 -0700 (PDT)
X-Received: by 10.112.84.104 with SMTP id x8mr24203038lby.23.1434902019972;
        Sun, 21 Jun 2015 08:53:39 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id gt9si649328wib.2.2015.06.21.08.53.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2015 08:53:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MFMIO-1ZIoWi3VWG-00EMBp; Sun, 21 Jun 2015 17:53:36
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:pSu7YB4WfGnX1xr49CCmooRl0nBTsYO8HfDo/AhPXiDB6bOjzPb
 zTZOK+TVTuB1XWUN9yVGpERwA8LGQOQjXxly+ZEuprmjn5vpUHYo2y3dMIDKFgLRFEMRXOC
 J0qmFMkbGpBcXb/3yCt1DGkkgYgaFoqLjiiPoVsPDx857haVQ9QrIguwZkV7YGdWFOmeyuE
 5Xw9qy2czS5vpzEi357LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vg6RdPkDPIQ=:wr5hLbZK3cIrlGn6K4M/Sd
 DbJAA1To75L/SIEUocnmwGeYUJ5w+xsK1u+CX0YboLiBiCgNQUUq34kSmJp99C8bu/4oqHaX1
 vP7prRgJe/Cy+ddpsMAyl4t9yymClahr3Rb6haVZHLg/0pcBqhrm1Qn7KL8lQfIaPaJ5CJA21
 /iuqlbUCwbkjanUMAXGoDNlCqOyBiduLH+v/WW/Uk/RvWPmLWxRnuG2M9mVNownlp/tj+uajk
 TIvJyi0pR4MgWqYBE9IcZh7L3PMEDf5vOi72ubsbRbEZoehAIdBHrdRXec+5WR74J8ZxyvZNa
 dkjH9FMK2j3oiGcDJJC5LiXaH2asfqHq8KkGFE/u2b6DequBJLc7Lh2mULkDs87ZoXnRJGH0p
 FailPjVm61ykjWNs9904knDEu8kAi6IzkjWTo5lNsbl5p6+tBblksaYLkRnMsgHN1qcercGMQ
 e4JBNUVDajdhYDTrNA6Dx//kn2Z3aqVPlv0in/K9ofDkG09TAws8eq+h2auRVJCWsrj1ClTPP
 YVR2XNGZSj9LfBPDCJSAcYZbysyEGxi7NnbEnqOY3RMMQ5ueMxc+qc0x6DXUMgOPykOHF3bQh
 7Wn6qGTnP7zlhPt/DXvNjKSLQvcuw7rTjNLCoDRxdEi8FGT+w2hzrtTztsmtShYqvghPgkGeh
 POQDEULVyAgaMrWALPy7oA9EZ0fePYkbaeZQi5IlCseYsOs4WLfUgW5/6MTpMR8d4WgM=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272270>

Dear Git contributors & users,

in this time and age, it appears to be a good idea for Open Source Software projects to have a document describing their code of conduct. Git for Windows is no exception, so I opened a ticket:

    https://github.com/git-for-windows/git/issues/200

In my opinion it is very important to have such a document, and equally important that it is not imposed by a BDFL or anybody else. Instead, it should document what the contributors and active users of the project can agree on.

Therefore I would like to encourage everybody involved in Git for Windows in one way or another to head over to that ticket and offer their constructive input there.

Thank you,
Johannes

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
