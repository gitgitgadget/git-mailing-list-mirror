From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Wed, 27 Jan 2010 18:54:11 -0800
Message-ID: <7v4om7ndm4.fsf@alter.siamese.dyndns.org>
References: <878wbln0oa.fsf@users.sourceforge.net>
 <20100128005142.GK5452@spearce.org>
 <alpine.DEB.1.00.1001280244430.4985@pacific.mpi-cbg.de>
 <20100128014205.GA8166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Pat Thoyts
 <patthoyts@users.sourceforge.net>,  git@vger.kernel.org,
 msysgit@googlegroups.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: 3ZPxgSwcJBw0tv656r421o1A.p1zz5B5tv6t11tyrt41725.p1z@groups.bounces.google.com Thu Jan 28 03:54:48 2010
Return-path: <3ZPxgSwcJBw0tv656r421o1A.p1zz5B5tv6t11tyrt41725.p1z@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f151.google.com ([209.85.221.151])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3ZPxgSwcJBw0tv656r421o1A.p1zz5B5tv6t11tyrt41725.p1z@groups.bounces.google.com>)
	id 1NaKWu-0008RS-GX
	for gcvm-msysgit@m.gmane.org; Thu, 28 Jan 2010 03:54:48 +0100
Received: by qyk15 with SMTP id 15sf140321qyk.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 27 Jan 2010 18:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:to:cc:subject
         :references:from:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=oF0TPo1/qCnjWDMV5HOz8YgbTmHDILDKLCvqTjCt5T0=;
        b=x/o9pEWREd5pnddgvD6Mp39UFk8lt/NXGBXr0nj9LeXyLctz1oUqGELQKQesrG/bV/
         leUfRtEV02cPHnfb9QCVKwK/uSH3BdXKXIpNcZxTq5eD1WtxDe3xQXvm9EwAwJlP8pvb
         /vNfDuXSx9EvV/kkT/1d3D1P07F/0tB3XjZr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:to:cc:subject:references:from:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type;
        b=XS6WkisrVby4rCL1A8HggEIaNSXvT56yd4ibOR/Orw5V8f2s34KJBTfcJ6ORDtftVG
         t2wqyNHjRYqAP8fgekVPyW9/590g7kVLsFp9UEcWaENENQdZ0B0wugyH6kLqjuAVVg6F
         iP10dtWsqQZySh2CjEBlOu2yVWIlEoL/f1Omo=
Received: by 10.224.43.212 with SMTP id x20mr88342qae.29.1264647268744;
        Wed, 27 Jan 2010 18:54:28 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.88.1 with SMTP id y1ls241171qal.3.p; Wed, 27 Jan 2010 
	18:54:25 -0800 (PST)
Received: by 10.224.125.15 with SMTP id w15mr834094qar.20.1264647265515;
        Wed, 27 Jan 2010 18:54:25 -0800 (PST)
Received: by 10.224.125.15 with SMTP id w15mr834093qar.20.1264647265487;
        Wed, 27 Jan 2010 18:54:25 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25])
        by gmr-mx.google.com with ESMTP id 18si73347qyk.13.2010.01.27.18.54.24;
        Wed, 27 Jan 2010 18:54:24 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E1294E7A;
	Wed, 27 Jan 2010 21:54:24 -0500 (EST)
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACAFB94E70;
	Wed, 27 Jan 2010 21:54:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE21994E6F; Wed, 27 Jan
 2010 21:54:12 -0500 (EST)
In-Reply-To: <20100128014205.GA8166@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 27 Jan 2010 17\:42\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DB25AFE-0BB8-11DF-9503-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) 
	smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
X-Original-Sender: gitster@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/54ce70325d0f927c
X-Message-Url: http://groups.google.com/group/msysgit/msg/fdbc11329d18bc59
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138220>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 27 Jan 2010, Shawn O. Pearce wrote:
>> > Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
>> > > 
>> > > This patch enables the use of themed Tk widgets with Tk 8.5 and above.
> ...
>> > Thanks.  I've been running with this pretty much all day today;
>> > it seems sane.  I'll probably push it shortly.
>> 
>> Thanks.  Can you notify me when you do so?  I will merge into 4msysgit.git 
>> directly then.
>
> Its already there.

Is that an insn for me to pull?
