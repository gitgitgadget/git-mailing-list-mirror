From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v4 7/8] mingw: enable OpenSSL
Date: Wed, 21 Oct 2009 14:43:30 +0200
Message-ID: <40aa078e0910210543t2dcc2af6ie16eb0e49895788f@mail.gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-7-git-send-email-kusmabite@gmail.com> <1255966929-1280-8-git-send-email-kusmabite@gmail.com> <200910192020.44890.j6t@kdbg.org> <4ADEFB6D.9050501@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org,  Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 14:48:25 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0aXc-0008Rd-A6
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 14:43:48 +0200
Received: by yxe1 with SMTP id 1so5359555yxe.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=1q/ALJZ+/ZpT6wSucvu+OwFvPUiUaXa9Qu8C4WbTmuQ=;
        b=yOETHaL+LZyk5O5f8bqtoY+8HptG+S8p0IyW419Klpj9kPsOvyeyV9BG+EtgpboVjb
         WzN1x8RymTeWRVo9TrG58f7fCZ2gQzX66pqAym/FMmcHd5d5Jx3hNQ9sQmvZQTNdlfUy
         RCi+MMh5I6PTCu0/1h/uv0PM8IwuBkfEEL5Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=nF0y7A2LxO5acpBq6sWLX0GppQ56dTR8/bvgPbFIl761NrFP7gF1Hn80kpgKc+gH5I
         2sAAkxAV9L+HOUDxsqLj4ubVYQ44qQZq/vfQjrbfuMw73+XHVn+kMN8hX6L2VmTFrzQm
         LGfhhG0M5iLdqTF8voatWh6J9IfEfjBSzpSu8=
Received: by 10.151.95.1 with SMTP id x1mr843025ybl.36.1256129019659;
        Wed, 21 Oct 2009 05:43:39 -0700 (PDT)
Received: by 10.177.52.5 with SMTP id e5gr7472yqk.0;
	Wed, 21 Oct 2009 05:43:33 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.35.141 with SMTP id p13mr249657bkd.21.1256129012375; Wed, 21 Oct 2009 05:43:32 -0700 (PDT)
Received: by 10.204.35.141 with SMTP id p13mr249656bkd.21.1256129012303; Wed, 21 Oct 2009 05:43:32 -0700 (PDT)
Received: from mail-fx0-f224.google.com (mail-fx0-f224.google.com [209.85.220.224]) by gmr-mx.google.com with ESMTP id 15si16446fxm.1.2009.10.21.05.43.31; Wed, 21 Oct 2009 05:43:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.224 as permitted sender) client-ip=209.85.220.224;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.224 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f224.google.com with SMTP id 24so8582326fxm.11 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:reply-to:in-reply-to :references:date:message-id:subject:from:to:cc:content-type; bh=r0aIdtqYHz4B8BDxnJj87d1Bqevlpl5qT/+5//XCNhw=; b=dodzV3VMaXrLDST5BqBF0dYaN56sDAppqcDzzljeGlRF1JqScH89N49mkDCBbxudXE JJMJIrMBdz+XR9ijp38YKZGhA0SSIr/fgihz97za0D8kllh5EY2hnWwcW29S2b+fwDqJ jPb9V0BT+C7gyyy/yQrpkLi7P35jpY3+CVDoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:reply-to:in-reply-to:references:date:message-id :subject:from:to:cc:content-type; b=redJMwhqWJtRlyIOaSp+Ew2lnFHzYQDpZY1twa+9KgncqbRlXnvIT/NARGL0cqH5Tx V+GeIPTdx6j1SQ7FM/TBNAQXixyMyrEUiJ3aESNAYrfpWf9N2XPu9+lC2lA1LosYK/Br grQZTDStNAaw9x1YySXSHk6iQfpBb7xa1stKs=
Received: by 10.204.3.19 with SMTP id 19mr7740435bkl.151.1256129010800; Wed,  21 Oct 2009 05:43:30 -0700 (PDT)
In-Reply-To: <4ADEFB6D.9050501@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130911>


On Wed, Oct 21, 2009 at 2:15 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I seem to have ack'ed this one too early. After testing in my environment,
> I get:
>
> imap-send.o: In function `ssl_socket_perror':
> D:\Src\mingw-git/imap-send.c:241: undefined reference to `ERR_get_error'
> D:\Src\mingw-git/imap-send.c:241: undefined reference to `ERR_error_string'
>
> I need this patch in addition, and perhaps something similar is also
> needed with MSVC:

Ah, yes - thanks for that one. I traced it a bit, and I found that it
works for me without your patch because I'm using OpenSSL's sha1, so
$(LIB_4_CRYPTO) is already included. Your fix is of course correct.
I'll squash it in and resend.

-- 
Erik "kusma" Faye-Lund
