From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 09/11] Add MSVC porting header files.
Date: Tue, 18 Aug 2009 10:15:51 +0800
Message-ID: <1976ea660908171915v62fb6c40j17f750cac9836433@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 04:16:03 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdEEz-0004Dy-SL
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 04:16:02 +0200
Received: by qyk30 with SMTP id 30so4291055qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=nD1jq9ws9BCwmScds+NOw3349959I59wyVmf7Pgga78=;
        b=hU3TjZDYDNHBG4Wvi7fDeBXUHYVv3Z4HtFy58v742L6+HBsJtH8rHp2HFSI49wGvD0
         SgwfkIm3SN0N986uHuabijr1ZnHsvaJ/E2mlU7Ydr2QWw/nArfH4n4geuGhC8sVrp12c
         zCXQp0vQvrTTh69894v3XX7vETIsRLFDzZCfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=qYY33sjgfUZ6qKVR+qAJHkM0/JJPtXKGfizo+20UGcCEn3xwIfm4pmrFO8iL2Ae5x3
         4O3WlGQT2VjHeahT7TmrIf9frwS7Kb7YTTPDpSLJO53ge2DqARPfPQOuo5AhRl9a7+Uq
         Z8GM8r49cfkt2+b4gbfkJurdRW6DBvHDXQkDM=
Received: by 10.220.83.102 with SMTP id e38mr886117vcl.10.1250561755049;
        Mon, 17 Aug 2009 19:15:55 -0700 (PDT)
Received: by 10.230.121.93 with SMTP id g29gr6437vbr.0;
	Mon, 17 Aug 2009 19:15:54 -0700 (PDT)
X-Sender: lznuaa@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.81.195 with SMTP id y3mr825685vck.5.1250561752962; Mon, 17 Aug 2009 19:15:52 -0700 (PDT)
Received: by 10.220.81.195 with SMTP id y3mr825684vck.5.1250561752625; Mon, 17 Aug 2009 19:15:52 -0700 (PDT)
Received: from mail-qy0-f198.google.com (mail-qy0-f198.google.com [209.85.221.198]) by gmr-mx.google.com with ESMTP id 21si364581vws.1.2009.08.17.19.15.51; Mon, 17 Aug 2009 19:15:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of lznuaa@gmail.com designates 209.85.221.198 as permitted sender) client-ip=209.85.221.198;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lznuaa@gmail.com designates 209.85.221.198 as permitted sender) smtp.mail=lznuaa@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-qy0-f198.google.com with SMTP id 36so2747867qyk.12 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 19:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=wvzUeIjR0PQnob0AGVV7BqeTQNhapAo317H/dsJ+SQ0=; b=N5p1C+y/i40jn3inriqCv1gYHyiAdX9Qj/bDOLTMqhHM+jF3vK+NXWIo2lqB0sv4uM CLkwylqGndE+vf2rGQvIA5iKLiO/714plHvZK4WbRub68vF7rV6Z5Cv8Rbf5BsPyuHm7 gEozQoza2DmSWl70HNg+v6liE9P7auHqe+NL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=syfnUp5EYRKPWS3zZ+SSDVLiZhXNFwdI4hfR1dxungk0aYBNcAPRbcil0FV6LsbGip wDezSPojltmyneglfJPpzziFQ36pYeigqPCDFvY/3JAt71ta+EhrJPsKVPvnwLJWxQCc FHDlBW6w2QVAeLpCadi9PlAeXmAM/okxArRZY=
Received: by 10.224.17.76 with SMTP id r12mr4906452qaa.133.1250561751235; Mon,  17 Aug 2009 19:15:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126340>


>> Add unix head file, dirent.h, unistd.h =A0and time.h
>
> These are copied from somewhere. =A0From where? =A0What is the license?

It comes from msys,  which used to build msysgit.

>> Add MSVC special porting head file msvc.h and msvc.c.
>
> This is added by you. =A0Logically, that should be a separate patch.

Okay I will split.

>> +#define NO_MEMMEM
>> +#define NO_C99_FORMAT
>> +#define NO_STRTOUMAX
>> +#define NO_MKDTEMP
>> +#define NO_MKSTEMPS
>> +
>> +#define RUNTIME_PREFIX
>> +#define NO_ST_BLOCKS_IN_STRUCT_STAT
>> +#define NO_NSEC
>> +#define USE_WIN32_MMAP
>> +#define USE_NED_ALLOCATOR
>> +
>> +#define NO_REGEX
>> +
>> +#define NO_SYS_SELECT_H
>> +#define NO_PTHEADS
>> +#define HAVE_STRING_H 1
>> +#define STDC_HEADERS
>> +#define NO_ICONV
>
> These would normally be defined in the Makefile. =A0You might want to sta=
te
> that in a comment.
>
> Or maybe move the definitions (along with vsnprintf) to the .vcproj file,
> which is the logical pendant of the Makefile?

I really want to in .vcproj.  but the same context needs to copy
DEBUG\RELEASE 32\64bit, libgit.vcproj and git.vcproj. 8 place needs
copy.  To avoid copy in vcproj file, I move it hear.
