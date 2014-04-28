From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 12:40:06 -0700
Message-ID: <xmqqy4ypp7jd.fsf@gitster.dls.corp.google.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
	<1398670610456-7608792.post@n2.nabble.com>
	<CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
	<xmqqsioxqp9i.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSUYANxbjjbE4jTW4EeVwOYgBD=bXkSu=akiYC_CB7Ffw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com,  Marat Radchenko <marat@slonopotamus.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@gmail.com>,  Nick Hengeveld <nickh@reactrix.com>,  GIT Mailing-list <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: msysgit+bncBCG77UMM3EJRBHG57KNAKGQEA353QKI@googlegroups.com Mon Apr 28 21:40:15 2014
Return-path: <msysgit+bncBCG77UMM3EJRBHG57KNAKGQEA353QKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f63.google.com ([209.85.220.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBHG57KNAKGQEA353QKI@googlegroups.com>)
	id 1WerPS-0008Nw-31
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 21:40:14 +0200
Received: by mail-pa0-f63.google.com with SMTP id lf10sf1615858pab.18
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ixal6MS6Qchrak5MKUouzHIm3v3UoRCpFtLyiyCkFrQ=;
        b=kw/FezFfcWlCTXv9UWLkcOa06VvLKwJvb/MUEaquMI6esDLIQL3+PwoxriaVoP6B1a
         Ox3eNwK65aGjLbZafPvBRvhlZyTC1mDWFZt3/rRY3m7n2RMzJI5F3Kc7EcJfJyBLH6lw
         0jTHpo2qcNgko0WTDcg3S9+ekBikX/YTf2EF77r8xGjmUVfY+DQPgGgXneNajlOkey7l
         MSKbnrAWcoYNx/naHrdgKAVRld7JF4gfbOhTN5A1ALkF/Cf9FPInqnL5MBfYa0S/YeAW
         OGWQaqfMbigQ6Fw+Vueqc4vgI9rk1j6qKiesUyl1k/5MTKD84cSNv7JBTljgxWQ4inkZ
         g3vg==
X-Received: by 10.140.104.168 with SMTP id a37mr79034qgf.20.1398714012817;
        Mon, 28 Apr 2014 12:40:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.84.149 with SMTP id l21ls2489394qgd.81.gmail; Mon, 28 Apr
 2014 12:40:11 -0700 (PDT)
X-Received: by 10.236.92.15 with SMTP id i15mr12190789yhf.8.1398714011919;
        Mon, 28 Apr 2014 12:40:11 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id n7si1544615qcz.2.2014.04.28.12.40.11
        for <msysgit@googlegroups.com>;
        Mon, 28 Apr 2014 12:40:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B50D81F7F;
	Mon, 28 Apr 2014 15:40:11 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 610B481F7E;
	Mon, 28 Apr 2014 15:40:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F9D681F7B;
	Mon, 28 Apr 2014 15:40:09 -0400 (EDT)
In-Reply-To: <CAD0k6qSUYANxbjjbE4jTW4EeVwOYgBD=bXkSu=akiYC_CB7Ffw@mail.gmail.com>
	(via msysGit's message of "Mon, 28 Apr 2014 11:39:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8447BFA-CF0C-11E3-84AD-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247416>

"'Dave Borowitz <dborowitz@google.com>' via msysGit"
<msysgit@googlegroups.com> writes:

> I think I should probably re-roll the patch to default to the old
> behavior (blind -lcurl) if curl-config returns the empty string, which
> I believe is also the case when the binary is not found.

Thanks for a prompt response; as this may indicate a possible
regression on what is already in 2.0-rc1, I am tempted to say that
we should revert the merge in the meantime.

Unless such an update can be done in a fairly trivial way, that is.


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
