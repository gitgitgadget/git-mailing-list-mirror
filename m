From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Tue, 08 Sep 2009 05:57:13 -0700 (PDT)
Message-ID: <m3ocplvbmj.fsf@localhost.localdomain>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org> <0016e6470f36315b8a0472bc75a8@google.com> <20090904212956.f02b0c60.rctay89@gmail.com> <7v8wgrbb9e.fsf@alter.siamese.dyndns.org> <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com> <7vocpn44dg.fsf@alter.siamese.dyndns.org> <20090907172751.6cf38640.rctay89@gmail.com> <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com, Tom Preston-Werner <tom@mojombo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 08 14:57:38 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f138.google.com ([209.85.210.138])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml0GN-000621-M7
	for gcvm-msysgit@m.gmane.org; Tue, 08 Sep 2009 14:57:35 +0200
Received: by yxe2 with SMTP id 2so9054388yxe.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Sep 2009 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=vzMFTlBCFjGFoh39myIU7jF1obAJMswbjB5e/syJy78=;
        b=2Gw4pbnNmkQswxACvxmELLKZ7GpijgX0YDlXz49riAcIKTvVSmcaVVZ5jhEFRxFW2w
         FKbAOH1fdI1coUsZkevOnMETQRZ3V91tgSC+YW4ahcFiAy1LrXQYUQajjJTTTeyBG+cv
         1VosfITuOEs05VbcEouodiAMk8jhpK04nTN6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:x-authentication-warning:to:cc
         :subject:references:from:date:in-reply-to:message-id:lines
         :user-agent:mime-version:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=F8gmsrhrTg7ll7vd1GnJYxjs2b0ShT3dLIrRi/epRqbyOuGWgKywFCip2seUWSGIsb
         yoBAkZooj4cbYsbPW4pTI25P7kpDiQ1lfMKNz2vtfjPovH5WG8ZPeI2CdD4JeN+/gC46
         AX+2NBUHt7yXyQdqiQyY+Se0Rpj3D7Jh83MMM=
Received: by 10.150.130.5 with SMTP id c5mr18879ybd.19.1252414648687;
        Tue, 08 Sep 2009 05:57:28 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr6871yqi.0;
	Tue, 08 Sep 2009 05:57:18 -0700 (PDT)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.64.34 with SMTP id r34mr316473muk.6.1252414636764; Tue, 08 Sep 2009 05:57:16 -0700 (PDT)
Received: by 10.103.64.34 with SMTP id r34mr316472muk.6.1252414636729; Tue, 08 Sep 2009 05:57:16 -0700 (PDT)
Received: from mail-fx0-f219.google.com (mail-fx0-f219.google.com [209.85.220.219]) by gmr-mx.google.com with ESMTP id 15si589910fxm.1.2009.09.08.05.57.15; Tue, 08 Sep 2009 05:57:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 209.85.220.219 as permitted sender) client-ip=209.85.220.219;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 209.85.220.219 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fxm19 with SMTP id 19so2679410fxm.2 for <msysgit@googlegroups.com>; Tue, 08 Sep 2009 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:received:received :x-authentication-warning:to:cc:subject:references:from:date :in-reply-to:message-id:lines:user-agent:mime-version:content-type; bh=oTsGVw2VsSeTsNVV3WRz3x7VqdlNPuPlLH/qjVoTigo=; b=GWhoAsNIIlp12heilXByKtgNEstQR7b63RvOEf6SB/0v/Jx+VWMoggfVFKK0gdoqKH GRhD2Bui6b3qc0670saQ/ycjk1V5eQw5ADtrimT6u+P4O5mWQYfynOtwlU1qGE3loYD7 3ck7kymsIZVXxzg2G0Q4peiM6ZJxmun0Hfl6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=x-authentication-warning:to:cc:subject:references:from:date :in-reply-to:message-id:lines:user-agent:mime-version:content-type; b=I13xWcUpziNBdBtA8wLhB4IsP3QTVaUOE1qpDvug3pZKm8EKYHOfx/wHqpLReXwV5t CKk8a2ZeOWZj6vAazwzosFELZPKU9HInH1pLReil1kJb8n+KyO2ASocaKOzb+Mt6OYrM QGZNyg2Y+H6UgQbAzbPZ73zr99nmBhLX3xGQ4=
Received: by 10.204.23.11 with SMTP id p11mr13158649bkb.29.1252414634862; Tue, 08 Sep 2009 05:57:14 -0700 (PDT)
Received: from localhost.localdomain (abwp75.neoplus.adsl.tpnet.pl [83.8.239.75]) by mx.google.com with ESMTPS id b17sm8501737fka.24.2009.09.08.05.57.13 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 08 Sep 2009 05:57:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n88CuVqM015390; Tue, 8 Sep 2009 14:56:37 +0200
Received: (from jnareb@localhost) by localhost.localdomain (8.13.4/8.13.4/Submit) id n88Cu5Wo015385; Tue, 8 Sep 2009 14:56:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128002>


Junio C Hamano <gitster@pobox.com> writes:
> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> > Just to clarify: the "check" of CURLE_OK in http-walker.c::fetch_index()
> > in v1.6.3 is fundamentally different from the check we have in 48188c2
> > (http-walker: verify remote packs, 2009-06-06).
> >
> > The first "check" is a full-blooded GET request, and we do get back
> > actual data (in this case, the pack index file). The second check isn't
> > a GET request, just an inconsequential HEAD request; we don't get back
> > any real data.
> 
> Yeah, I realized after I wrote the message you are responding to and ran
> some experiments with github repository myself to see for some of their
> URLs HEAD gives 500 when GET gives the contents just fine.
> 
>   Tom, sorry to have given a confusing list of issues in my earlier message.
>   Please disregard it.  The only funny your HTTP server folks may want to
>   look into is that GET request to fetch the following URL gives the
>   contents just fine, but HEAD request to it results in an Internal Server
>   Error.
> 
>   http://github.com/tekkub/addontemplate.git/objects/pack/pack-382c25c935b744e909c749532578112d72a4aff9.pack
> 
>   Sorry about the confusion.

[...]

> On the other hand, if a HEAD request to a URL results in an unauthorized,
> what plausible excuse the server operator could give for allowing a GET
> request to the same URL?  If we are going to keep the check if *.pack that
> corresponds to the *.idx will be available, shouldn't we trust whatever
> check we perform?

500 Internal Server Error doesn't look right (well, it can indicate
bug in server code), but would git respond to correct error code other
than 404 Not Found, like 405 Method Not Allowed, or 501 Not Implemented?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
