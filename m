From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v3 5/8] imap-send: build imap-send on Windows
Date: Tue, 13 Oct 2009 22:16:14 +0200
Message-ID: <40aa078e0910131316s308f2bc5h8d679c59c0d5b762@mail.gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com> <1255461925-2244-6-git-send-email-kusmabite@gmail.com> <200910132157.41279.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 22:16:40 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnnR-0001NT-VY
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 22:16:38 +0200
Received: by qyk7 with SMTP id 7so10708644qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=w4dgJdOMk+jhu7W2OnPcUyel6HLF/CNhoV9ONg4ScKc=;
        b=PpdqTN19gqvs1a1MsW0Rui6iigIfFgKr7RL350d5YX8orZuk24a5ttRBN6UR4mLmtf
         lIXdSGP79Dq27XZLFBaI589chkObD36xPYmB+9j4ZE4xPqbGlRc02z9Wps/g/aADpOLp
         PZ8cUrtdT2Q8JWQrNk+c83V/jxLeeA8aBamXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=BkbmF2SX5eFGv9MoYzFvr85z+BhyMGDjzq7h/vyBFWuNYuw/13eXvS6SbEpIykhDhx
         ikCD85yCyPeyrjASjzBE9QBQ9mio2MZQflFGhf7y0MUg8KMayTLIoW0o83xRA3rHvHh/
         x935LMIRp2Ye2iW9jZMuM9mYrMhe9s0ni7WWI=
Received: by 10.229.114.215 with SMTP id f23mr369450qcq.37.1255464990449;
        Tue, 13 Oct 2009 13:16:30 -0700 (PDT)
Received: by 10.176.181.37 with SMTP id d37gr7406yqf.0;
	Tue, 13 Oct 2009 13:16:16 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.23.194 with SMTP id s2mr176226bkb.30.1255464975414; Tue, 13 Oct 2009 13:16:15 -0700 (PDT)
Received: by 10.204.23.194 with SMTP id s2mr176225bkb.30.1255464975394; Tue, 13 Oct 2009 13:16:15 -0700 (PDT)
Received: from mail-fx0-f228.google.com (mail-fx0-f228.google.com [209.85.220.228]) by gmr-mx.google.com with ESMTP id 16si308007fxm.2.2009.10.13.13.16.14; Tue, 13 Oct 2009 13:16:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.228 as permitted sender) client-ip=209.85.220.228;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.228 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f228.google.com with SMTP id 28so8876059fxm.42 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:reply-to:in-reply-to :references:date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=66ZDywMC+oBLk3DWDXJEGIkrpY3Ru6TYyr5V0p8zIQA=; b=fQIZA15Sb5S5Uf3vJetC7waHPHC8dm38lp75moyghRDPTtQM/k/C8npLglfGgM7v+S HSgC+546cjvy/yddESYQIDqOk7ZW6sFHqWCW1KgRu5SWtn3gCKp4ca9Wo+BOiy/mQm+d 6MTvM6IfwCIsn0wYRAVdG9SK4LzfJeIR6A3fU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:reply-to:in-reply-to:references:date:message-id :subject:from:to:cc:content-type:content-transfer-encoding; b=FsWC7qM4qGhKJzZJuhXSIDODk/osaUsq7kwZHlce9IcR+yRK6CIT4TGWIq4g6b7Sxl FXeNaTSKJfLlNMQ2WcfWufTKLSZUXFAajfLnA22mRTgq8hp/ofbTwmYwrJkfMG/00ig/ NZKMkaeET5Z3CK/sMaPcCQnp7TINkLLA5G/5E=
Received: by 10.204.160.85 with SMTP id m21mr6546363bkx.175.1255464974165;  Tue, 13 Oct 2009 13:16:14 -0700 (PDT)
In-Reply-To: <200910132157.41279.j6t@kdbg.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130199>


On Tue, Oct 13, 2009 at 9:57 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 13. Oktober 2009, Erik Faye-Lund wrote:
>> =A0PROGRAMS +=3D git-unpack-file$X
>> =A0PROGRAMS +=3D git-upload-pack$X
>> =A0PROGRAMS +=3D git-var$X
>> +PROGRAMS +=3D git-imap-send$X
>
> This list is sorted. Please keep it so.
>
> -- Hannes
>

Aha, I didn't notice! Thanks, I'll fix :)

--=20
Erik "kusma" Faye-Lund
