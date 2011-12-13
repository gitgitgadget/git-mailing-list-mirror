From: Eric Advincula <eric.advincula@gmail.com>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 14:22:12 -0700
Message-ID: <CA+e6NDTQNEJB6Y17ow+yuLp2Bc799wsyQdnS8immMDYdCEyCGA@mail.gmail.com>
References: <20111213201704.GA12072@sigill.intra.peff.net>
	<20111213202508.GA12187@sigill.intra.peff.net>
	<7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=f46d0444ef2d334cf104b3ffd8ea
Cc: Jeff King <peff@peff.net>, Stefan Naewe <stefan.naewe@gmail.com>, 
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCJTu2Lv0GxDulp_3BBoEHmspcQ@googlegroups.com Tue Dec 13 23:02:53 2011
Return-path: <msysgit+bncCJTu2Lv0GxDulp_3BBoEHmspcQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCJTu2Lv0GxDulp_3BBoEHmspcQ@googlegroups.com>)
	id 1RaaR2-0008MX-Mb
	for gcvm-msysgit@m.gmane.org; Tue, 13 Dec 2011 23:02:52 +0100
Received: by faai28 with SMTP id i28sf2210728faa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Dec 2011 14:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=onwuBfHrM/0mlxPHv/F0tQxeu/WUDHURkYDQkY9CoZQ=;
        b=3kGhw8FVqvojRwFgSMlRDoY/Uk2iIK8VlXZ79lmTykqg6ri2CVREr2o+lbuzi22qoT
         WLB4L4Xbs8Y6ezMX7vlqrtn7Xz/4S382C3rn0RRqa9HNuwaFquZECK/y6ykpATZOA4yu
         78+g2or5S1II1tij248DcYAaKY8X78kzd9z7g=
Received: by 10.180.7.138 with SMTP id j10mr118332wia.1.1323813742271;
        Tue, 13 Dec 2011 14:02:22 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.201.213 with SMTP id fb21ls1927572wbb.5.gmail; Tue, 13 Dec
 2011 14:02:21 -0800 (PST)
Received: by 10.180.103.10 with SMTP id fs10mr39854wib.5.1323813741295;
        Tue, 13 Dec 2011 14:02:21 -0800 (PST)
Received: by 10.216.144.67 with SMTP id m45mswej;
        Tue, 13 Dec 2011 13:22:12 -0800 (PST)
Received: by 10.14.124.207 with SMTP id x55mr180623eeh.8.1323811332326;
        Tue, 13 Dec 2011 13:22:12 -0800 (PST)
Received: by 10.14.124.207 with SMTP id x55mr180621eeh.8.1323811332300;
        Tue, 13 Dec 2011 13:22:12 -0800 (PST)
Received: from mail-fx0-f48.google.com (mail-fx0-f48.google.com [209.85.161.48])
        by gmr-mx.google.com with ESMTPS id 41si199951eee.2.2011.12.13.13.22.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 13:22:12 -0800 (PST)
Received-SPF: pass (google.com: domain of eric.advincula@gmail.com designates 209.85.161.48 as permitted sender) client-ip=209.85.161.48;
Received: by mail-fx0-f48.google.com with SMTP id q24so977587fan.35
        for <msysgit@googlegroups.com>; Tue, 13 Dec 2011 13:22:12 -0800 (PST)
Received: by 10.180.106.70 with SMTP id gs6mr343095wib.41.1323811332115; Tue,
 13 Dec 2011 13:22:12 -0800 (PST)
Received: by 10.216.197.74 with HTTP; Tue, 13 Dec 2011 13:22:12 -0800 (PST)
In-Reply-To: <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
X-Original-Sender: eric.advincula@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of eric.advincula@gmail.com designates 209.85.161.48 as permitted
 sender) smtp.mail=eric.advincula@gmail.com; dkim=pass (test mode) header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187066>

--f46d0444ef2d334cf104b3ffd8ea
Content-Type: text/plain; charset=ISO-8859-1

Is there an alternative to using git on windows?  I used windows, apache,
dav for git.
If there is a better solution please let me know.

Thanks
Eric

On Tue, Dec 13, 2011 at 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
>
> > Doing (3) is obviously the easiest thing. And given the complexity of
> > the other two solutions, I think it makes sense to revert 986bbc08
> > (i.e., apply this patch), ship a working v1.7.8.1, and then look at
> > doing one of the other two solutions for v1.7.9.
>
> Or just let the "dumb HTTP" die.
>
> I thought push over DAV has long been dead; is anybody using it for real?
>

--f46d0444ef2d334cf104b3ffd8ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Is there an alternative to using git on windows? =A0I used windows, apache,=
 dav for git.<div>If there is a better solution please let me know.</div><d=
iv><br></div><div>Thanks</div><div>Eric<br><br><div class=3D"gmail_quote">O=
n Tue, Dec 13, 2011 at 2:09 PM, Junio C Hamano <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gitster@pobox.com">gitster@pobox.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">Jeff King &lt;<a href=3D"m=
ailto:peff@peff.net">peff@peff.net</a>&gt; writes:<br>
<br>
&gt; Doing (3) is obviously the easiest thing. And given the complexity of<=
br>
&gt; the other two solutions, I think it makes sense to revert 986bbc08<br>
&gt; (i.e., apply this patch), ship a working v1.7.8.1, and then look at<br=
>
&gt; doing one of the other two solutions for v1.7.9.<br>
<br>
</div>Or just let the &quot;dumb HTTP&quot; die.<br>
<br>
I thought push over DAV has long been dead; is anybody using it for real?<b=
r>
</blockquote></div><br></div>

--f46d0444ef2d334cf104b3ffd8ea--
