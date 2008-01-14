From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: safecrlf not in 1.5.4
Date: Sun, 13 Jan 2008 23:30:51 -0800
Message-ID: <7vejcklv84.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <31687420-EB17-4651-AD6C-07213311ABDA@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,  Mark Levedahl <mlevedahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,  msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 14 08:31:36 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from nz-out-0708.google.com ([64.233.162.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJnD-0002nv-Rn
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jan 2008 08:31:36 +0100
Received: by nz-out-0708.google.com with SMTP id v22so3017634nzg.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 13 Jan 2008 23:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=XLFbHjhGmwKsL1qF6pStcUSLalp4h9rLFgAPEBRPL6k=;
        b=Y+bSTlXJZZ/SwZ3tXomq0W8I0dhyj7XtwvhU0D8ttSbxp/n7N5J5uAgE+3F+GjBB55dq2YZGFlg7wI6ZamzDHsGJiRe0O8+YzQdSCR6OqpaTgZ1FD1rZsUu5YsEpkFoPNWYj+tO+JkxqPyHxIEe6l12tX2WN0lDTEYNpgsYUNZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=u6IVxcW0ed+AVSaKHSU/45kzHXUClzcpS+ERM/A1WWcSvD0Z0w3DbrK8W80Laoa5yxQhaFC8bDC+clWrC5LSXeYsMgHpSa6NjD5sWFhelNSjZa88aKtNLk89YQfaPj5XLjhwkhXxrTCWuzL5mWzLFal7NIHyfXljsKBavYEs7KY=
Received: by 10.151.6.2 with SMTP id j2mr284396ybi.13.1200295867116;
        Sun, 13 Jan 2008 23:31:07 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1377hsg;
	Sun, 13 Jan 2008 23:31:07 -0800 (PST)
X-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.99.14 with SMTP id b14mr10055013pym.4.1200295866799; Sun, 13 Jan 2008 23:31:06 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com [208.72.237.25]) by mx.google.com with ESMTP id x46si3571362pyg.3.2008.01.13.23.31.06; Sun, 13 Jan 2008 23:31:06 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) smtp.mail=gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
Received: from a-sasl-quonix (localhost [127.0.0.1]) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1C5D2A02; Mon, 14 Jan 2008 02:31:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C9ED9239C; Mon, 14 Jan 2008 02:30:57 -0500 (EST)
In-Reply-To: <31687420-EB17-4651-AD6C-07213311ABDA-wjoc1KHpMeg@public.gmane.org> (Steffen Prohaska's message of "Mon, 14 Jan 2008 07:49:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70447>


Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

> Do you see a chance to have safecrlf in 1.5.4.1?

By definition of 'maint', 1.5.4.X are to fix bugs in the
features that are in 1.5.4, so the answer is no.

But we could end up having a short cycle for 1.5.5 if we agree
that the lack of crlf=safe is a severe bug that is worth fixing
post 1.5.4.

Currently I am not convinced that the lack of crlf=safe is a
severe and urgent bug worth "fixing" for 1.5.4.  I see it as a
new feature, a different variant of crlf behaviour we will be
introducing for audience who are not satisfied with existing the
crlf variants.
