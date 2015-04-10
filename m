From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Sneak peek of the upcoming Git for Windows 2.x
Date: Fri, 10 Apr 2015 13:43:21 +0200
Organization: gmx
Message-ID: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncBCZPH74Q5YNRBYHOT2UQKGQEC35476Q@googlegroups.com Fri Apr 10 13:43:30 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBYHOT2UQKGQEC35476Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBYHOT2UQKGQEC35476Q@googlegroups.com>)
	id 1YgXLN-0004Gh-8C
	for gcvm-msysgit@m.gmane.org; Fri, 10 Apr 2015 13:43:29 +0200
Received: by lbiv13 with SMTP id v13sf3661126lbi.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Apr 2015 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to
         :subject:organization:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=1iSQEc4IlwzZld/cTgij7iwucmrtd0KNUthgJfm5s4o=;
        b=jOoZoFFk9X7dbw1IXwo2o+/1fWBchVgqWkOtycO9BOsdF8PXjzhe1QSVbsOxWO6YVu
         /SYZurMDh93RPo5KlM8EAPoG50G6FqghWWhQvuhi/3S2q+cTHmwm2OcxYQvkx+4UXIq5
         cSEV7goquduFpXserYFy2ZCYkJSef9qbk/DK7p326d2M6fLoV9+MVr98+can8aDO8ZP3
         PjQQs3g9UzgckxJXiHCDze6ofqjw+2Gob+SoGnPg9uN3L4PgePJULXP0SWOr9aAjaYj0
         buEFjsmVT2j5881nzXjew2Eg/zaTdrKz+opqg1fFIADQgPPnSs1qFFiVwNM+sJllMFLC
         g8FQ==
X-Received: by 10.152.229.133 with SMTP id sq5mr12246lac.24.1428666208862;
        Fri, 10 Apr 2015 04:43:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.172 with SMTP id p12ls446813lal.40.gmail; Fri, 10 Apr
 2015 04:43:26 -0700 (PDT)
X-Received: by 10.152.206.36 with SMTP id ll4mr246740lac.6.1428666206055;
        Fri, 10 Apr 2015 04:43:26 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id ec7si99355wib.3.2015.04.10.04.43.25
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2015 04:43:26 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LbuCq-1Z5exi3svM-00jFrG; Fri, 10 Apr 2015 13:43:22
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Tm1Y/hjlXxCQGN75JwMQ1GKGLBiGk4YihXHR8vhmtbawK7GZhd0
 yJcJD5QL4DbFL+j4/eW5/uQiYUFuQcPTa5sSjKSgi1B1i2fi886st6EiCXK+1FpgU1hT7JS
 5Pkj6pA18CxuyNahqiQbG4S4lTO7FHl+B8cD3L86OIxjG7226wLKthl1jmyIoybnV0ZHKo2
 U8pQTBFzow8NwsHkHOXdg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267010>

Dear all,

during the really exciting Git Merge conference, the Git for Windows develo=
pers had the opportunity to meet and we managed to whip out a *really* earl=
y beta of the upcoming Git for Windows 2.x series.

Please keep in mind that we not only changed our entire development environ=
ment, but that this change also affects end user installations quite a bit:=
 as parts of Git are still written in shell and Perl, we have to ship a she=
ll and Perl interpreter, too, which are naturally plucked from the developm=
ent environment.

Of course that implies that there are probably still quite a couple of roug=
h edges. Nevertheless, if you want to have a *really* early glimpse at the =
upcoming major release, feel free to give it a spin: https://git-for-window=
s.github.io/#download

Enjoy,
Johannes

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
