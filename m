From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 23:32:56 +0100
Message-ID: <CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
	<7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1110311908240.1930@bonsai2>
	<CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
	<alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=bcaec54858cad9669804b0b3ef34
Cc: ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com, 
	Karsten Blees <blees@dcon.de>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncCKSyzO6oChD058H1BBoEcNP9Cg@googlegroups.com Tue Nov 01 23:35:00 2011
Return-path: <msysgit+bncCKSyzO6oChD058H1BBoEcNP9Cg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qw0-f58.google.com ([209.85.216.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCKSyzO6oChD058H1BBoEcNP9Cg@googlegroups.com>)
	id 1RLMv4-0000VX-L2
	for gcvm-msysgit@m.gmane.org; Tue, 01 Nov 2011 23:34:58 +0100
Received: by qabg27 with SMTP id g27sf777222qab.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Nov 2011 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=TthN5WPsdbi0KdjHllxU7QCMXIlCk5pU0YThY7WbYi0=;
        b=H3uHeXZ0Juyp9TtzRp/emaUj8eolQmFo4HhTcxlHfV8sIR096npOxxg82DFpAP8auN
         jvEYZ9EX4vHumgnwsg4rFVZRj7nBcmx1Xby4qT+C3iwkR6LR/PZJOaA/NwZdEXtuXlpj
         YGBUvD/N8t0JhpPV/0GUCoHfDAP/V4O1qjLVs=
Received: by 10.224.52.81 with SMTP id h17mr470127qag.0.1320186868427;
        Tue, 01 Nov 2011 15:34:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.209.134 with SMTP id gg6ls324745qab.2.gmail; Tue, 01 Nov
 2011 15:34:27 -0700 (PDT)
Received: by 10.224.111.129 with SMTP id s1mr481117qap.3.1320186867886;
        Tue, 01 Nov 2011 15:34:27 -0700 (PDT)
Received: by 10.224.137.13 with SMTP id u13msqat;
        Tue, 1 Nov 2011 15:32:56 -0700 (PDT)
Received: by 10.52.64.173 with SMTP id p13mr2068557vds.0.1320186776771;
        Tue, 01 Nov 2011 15:32:56 -0700 (PDT)
Received: by 10.52.64.173 with SMTP id p13mr2068556vds.0.1320186776763;
        Tue, 01 Nov 2011 15:32:56 -0700 (PDT)
Received: from mail-vw0-f44.google.com (mail-vw0-f44.google.com [209.85.212.44])
        by gmr-mx.google.com with ESMTPS id cn4si197262vdb.3.2011.11.01.15.32.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 15:32:56 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.212.44 is neither permitted nor denied by best guess record for domain of vfr@lyx.org) client-ip=209.85.212.44;
Received: by mail-vw0-f44.google.com with SMTP id 5so9334726vws.17
        for <msysgit@googlegroups.com>; Tue, 01 Nov 2011 15:32:56 -0700 (PDT)
Received: by 10.52.186.230 with SMTP id fn6mr1608218vdc.76.1320186776479; Tue,
 01 Nov 2011 15:32:56 -0700 (PDT)
Received: by 10.220.189.68 with HTTP; Tue, 1 Nov 2011 15:32:56 -0700 (PDT)
Received: by 10.220.189.68 with HTTP; Tue, 1 Nov 2011 15:32:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
X-Original-Sender: vfr@lyx.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 209.85.212.44 is neither permitted nor denied by best guess record for domain
 of vfr@lyx.org) smtp.mail=vfr@lyx.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184601>

--bcaec54858cad9669804b0b3ef34
Content-Type: text/plain; charset=ISO-8859-1

> Maybe if someone donates Jenkins resources, we could make an automatic
> branch in the future that has git.sln in it (similar to the 'html' branch
> in git.git).
>

As long as this means to just run a not so complicated perl script, this
Could even be done in a commit hook.

Just another question. How does the (msys)git community feel about adding
CMake support ? I can probably do that quite easily.

Vincent

--bcaec54858cad9669804b0b3ef34
Content-Type: text/html; charset=ISO-8859-1

<p><br>
&gt; Maybe if someone donates Jenkins resources, we could make an automatic<br>
&gt; branch in the future that has git.sln in it (similar to the &#39;html&#39; branch<br>
&gt; in git.git).<br>
&gt;</p>
<p>As long as this means to just run a not so complicated perl script, this Could even be done in a commit hook.</p>
<p>Just another question. How does the (msys)git community feel about adding CMake support ? I can probably do that quite easily.</p>
<p>Vincent<br>
</p>

--bcaec54858cad9669804b0b3ef34--
