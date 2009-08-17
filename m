From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Using VC build git (split patch)
Date: Mon, 17 Aug 2009 15:19:43 +0200
Message-ID: <40aa078e0908170619r3d325e0csee466446df474302@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 15:19:53 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md27t-0002ap-Iz
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 15:19:53 +0200
Received: by mail-qy0-f158.google.com with SMTP id 30so3755374qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=mrLGl24dw8aHip8zScB0HN8y+b1+O41Mixusm9DW9fs=;
        b=3Jh7zG7BOytMHFKRWzMy4ExsSTGEvxAguy4SutTnjUXjzt+lEfGTe9XvKMLqn7e0L4
         casq8eXOMsR2ZAx6taUWdgx3Q41HVlDut6sDE5CtfQYajABNxrYSXR4GgA8I6ZSgZVEB
         aH3giPIWez1n2mRGD66cHPleGKdRsataWJfzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=z6MjjioSb3pvghwGjNiLa9rT5+AIyJjzwy6oXvuS2MZun/bxiiu904n+VN2xkTHBUI
         5QFqmuRCuGkmxpzHPl6T5+aTm7Qq8/RLTONzvwXPVCPieTbVSyvAW0DFihCAa3uin40M
         SgcnXsOj4QX06oRhPTnTKAKputVaSf2m20xFo=
Received: by 10.220.78.31 with SMTP id i31mr711637vck.9.1250515187905;
        Mon, 17 Aug 2009 06:19:47 -0700 (PDT)
Received: by 10.230.85.148 with SMTP id o20gr6332vbl.0;
	Mon, 17 Aug 2009 06:19:45 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.78.101 with SMTP id j37mr560192vck.19.1250515184617; Mon, 17 Aug 2009 06:19:44 -0700 (PDT)
Received: by 10.220.78.101 with SMTP id j37mr560191vck.19.1250515184593; Mon, 17 Aug 2009 06:19:44 -0700 (PDT)
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148]) by gmr-mx.google.com with ESMTP id 21si308468vws.9.2009.08.17.06.19.43; Mon, 17 Aug 2009 06:19:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.92.148 as permitted sender) client-ip=74.125.92.148;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.92.148 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by qw-out-1920.google.com with SMTP id 5so805035qwc.8 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=L5X327xD74QnGJFN/7K+pgJanSXuv4sznpkSCDql49Y=; b=DzYzqNsv57wg9QSuCevuMySb5eHCUSH0cci7FOdn7XJB0bYI/1Y7U8mdXey+tpswii 69sK5OGc9lpOa+bOLkhXuM2b/yPrGwsVl+D0wnepJYUQ6coLdvI3o00gn5EJUT335bb5 Yqg40UTjFSnZK4sHvbAoCUCQpuSd2XOYpDQoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=XQSoY4s5MMQ+EfqRanEMOqf1L0Wgb5Pw+e63Ohuk4RgSwXIlkjAUQMH/1yNDjp2t85 d1+hGGUaBaOtIfVJgzG7fvAiKcLW9AOIsugrTl+h00UN0ueHG2q6Us1kpf+V94DPidsn zKIS5DExgJy7nerbmyrTtolnm3qy3aoTGVBCY=
Received: by 10.224.52.170 with SMTP id i42mr4145617qag.285.1250515183115;  Mon, 17 Aug 2009 06:19:43 -0700 (PDT)
In-Reply-To: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126178>


On Mon, Aug 17, 2009 at 3:13 PM, Frank Li<lznuaa@gmail.com> wrote:
> I try to use git format-patch -M --stdout origin/master | git
> imap-send to send patch directly according to guide.
> But imap-send has not ported to msysgit.

Then use send-email, which IS supported in msysgit.

While we're on that subject; I guess we should add some documentation
(a wiki page or something?) on how to use it, as some (simple) setup
on the client side is required for msmtp.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
