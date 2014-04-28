From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 11:31:53 -0700
Message-ID: <xmqqsioxqp9i.fsf@gitster.dls.corp.google.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
	<1398670610456-7608792.post@n2.nabble.com>
	<CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@gmail.com>,  Nick Hengeveld <nickh@reactrix.com>,  GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com, Dave Borowitz <dborowitz@google.com>
X-From: msysgit+bncBCG77UMM3EJRBHN57KNAKGQEOY4LZ3Q@googlegroups.com Mon Apr 28 20:32:07 2014
Return-path: <msysgit+bncBCG77UMM3EJRBHN57KNAKGQEOY4LZ3Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f64.google.com ([209.85.216.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBHN57KNAKGQEOY4LZ3Q@googlegroups.com>)
	id 1WeqLP-0002jG-0p
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 20:31:59 +0200
Received: by mail-qa0-f64.google.com with SMTP id cm18sf1671482qab.19
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ZblUHXx2ArnKb+JeEEcfInZdnsu/MSw2szmr5EexPBc=;
        b=X051xjzqmP8+Ou9IcpNyl1hgCPJNqhW/nHq/2fMOp7PQZ6i7hKgAgqQAvzE1ya08nZ
         I+rSH17xo/eTW3kUS/RA6urwa5BCFzMdgAOEGCb384At4FTdlNmTrraD7K/vRKoW2fZl
         aMiRC9ihY5TvGCtj+vpOAsi6ZsxJ/yY+LnyIZgT6qklWnE67npuQSWomcwMspYx9NAhl
         Q0s2uVgGJiGI+SoFijoNu7lkHDN46yujOBocLBz9Z6Aw5Es5S0CtdnDNi+JfuFg50o+7
         rG1EVCmOuVooiXHn+pmaBSffDNxfUHub+a1Hu1NJXoGALR3XLkqd4UWgir7eKWVjuAHu
         VKgA==
X-Received: by 10.140.94.169 with SMTP id g38mr75012qge.13.1398709918248;
        Mon, 28 Apr 2014 11:31:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.31.52 with SMTP id e49ls2752092qge.19.gmail; Mon, 28 Apr
 2014 11:31:57 -0700 (PDT)
X-Received: by 10.236.117.80 with SMTP id i56mr11162238yhh.48.1398709917617;
        Mon, 28 Apr 2014 11:31:57 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id p5si6282697qcq.3.2014.04.28.11.31.57
        for <msysgit@googlegroups.com>;
        Mon, 28 Apr 2014 11:31:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DDED81953;
	Mon, 28 Apr 2014 14:31:57 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0618C81950;
	Mon, 28 Apr 2014 14:31:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1F658194D;
	Mon, 28 Apr 2014 14:31:54 -0400 (EDT)
In-Reply-To: <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Mon, 28 Apr 2014 10:48:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FB1466E-CF03-11E3-A25F-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247383>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> We're using Curl 7.30.0 in msysGit (and thus also Git for Windows), so
> we should be able to include it. However, we do not have curl-config
> installed.

Hmmm, between 2.0-rc0 and 2.0-rc1 there is 61a64fff (Makefile: use
curl-config to determine curl flags, 2014-04-15) merged already,
which makes this assumption and a claim based on that assumption:

    curl-config should always be installed alongside a curl
    distribution, and its purpose is to provide flags for building
    against libcurl, so use it instead of guessing flags and
    dependent libraries.

which may make things worse for you guys, unless you are explicitly
setting CURLDIR and other Makefile variables.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
