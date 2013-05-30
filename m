From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: t0008-ignores failure (was: Git for Windows 1.8.3)
Date: Thu, 30 May 2013 16:45:58 +0100
Message-ID: <CABNJ2GKPvbYFgqGL-g3Pnp7OghpoSfeuPEF0vNHixhQFkY+Uow@mail.gmail.com>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com>
	<51A6A7B7.4010802@gmail.com>
	<alpine.DEB.1.00.1305301713400.650@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>, msysGit <msysgit@googlegroups.com>, 
	Sebastian Schuberth <sschuberth@gmail.com>, Git List <git@vger.kernel.org>, 
	Adam Spiers <git@adamspiers.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDRPLLPZ44IBBNXITWGQKGQE6GC53XA@googlegroups.com Thu May 30 17:46:02 2013
Return-path: <msysgit+bncBDRPLLPZ44IBBNXITWGQKGQE6GC53XA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f59.google.com ([209.85.212.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDRPLLPZ44IBBNXITWGQKGQE6GC53XA@googlegroups.com>)
	id 1Ui539-0006UF-Qq
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 17:46:00 +0200
Received: by mail-vb0-f59.google.com with SMTP id p14sf133955vbm.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 May 2013 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=B/vaGz4A+JAM4Vb6V6mH3+H/rgOoG2wfKp6FFtgHSns=;
        b=f7E36UUivKFxSYdp+Lp+i8vwd19ZDnE5TnfQVZxcuwXMk7fCwumZcJUxMieFgZnxy0
         rxXhjG+aVkD+XFj4WiIaFvypU+bZ3TYAm8q548Cuh8GMRwuWVt7RoeSyD2K7d/5JPxqB
         t5DM0WfrEjaNMCG3yQgafaLwcZKmxX8aFV4eILIu+fFk5gH5MZGm2Ws7ooH7CalcVxbD
         dEQnLmA7nw6uWkca6mlV1p1wa0beVmxn9e0tlmdnkY78D1XU1I8yo90d43xH3MvjkUEh
         TMOOKxh+DT+c/9Wfu+GMRVOZ4BdqAvBHYQ6vpTSUWCVpZ9GNvxyOwf7vs+kPJRC6qIyz
         Oxcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=B/vaGz4A+JAM4Vb6V6mH3+H/rgOoG2wfKp6FFtgHSns=;
        b=K7PO1Yk6wf2TySf0QPXdrIXOaCi2tpE8qoCDqEcqPolj6UikrkXUs2JLbIHCpIB3Fg
         i+yN4dTjIrMVA4nd613moZWcEEGpArHyKInF6vnFOtjEyw4fjceoB0AuC3f14nAByxe6
         ++7m8IiQk8ynBz8Kr7rjI79BKp/N3limoFE9TR7xSbNr33YZ27vAkkmzy7U0NOxuq/Wy
         WevPEV2wJYvl7tqKOmuJ4Yoo/R9bhZcRHhIn1AvvYw737UQnjJpQ2yRVXc5JdhY+dxGQ
         nelMMSZgc7ds0/sHrl5yoFltoLEWZdKQgOmtgAk89ODO+9ujBGQvJxzVw4IVBcJNE/YW
         sKgg==
X-Received: by 10.50.73.196 with SMTP id n4mr3135418igv.3.1369928758775;
        Thu, 30 May 2013 08:45:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.39.81 with SMTP id n17ls665303igk.21.gmail; Thu, 30 May
 2013 08:45:58 -0700 (PDT)
X-Received: by 10.66.146.168 with SMTP id td8mr1171954pab.17.1369928758203;
        Thu, 30 May 2013 08:45:58 -0700 (PDT)
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com [209.85.192.178])
        by gmr-mx.google.com with ESMTPS id cw1si6070720pbb.0.2013.05.30.08.45.58
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 08:45:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of patthoyts@gmail.com designates 209.85.192.178 as permitted sender) client-ip=209.85.192.178;
Received: by mail-pd0-f178.google.com with SMTP id w11so576396pde.9
        for <msysgit@googlegroups.com>; Thu, 30 May 2013 08:45:58 -0700 (PDT)
X-Received: by 10.68.231.65 with SMTP id te1mr8454222pbc.98.1369928758122;
 Thu, 30 May 2013 08:45:58 -0700 (PDT)
Received: by 10.68.63.132 with HTTP; Thu, 30 May 2013 08:45:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1305301713400.650@s15462909.onlinehome-server.info>
X-Original-Sender: patthoyts@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of patthoyts@gmail.com designates 209.85.192.178 as
 permitted sender) smtp.mail=patthoyts@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226015>

On 30 May 2013 16:15, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Karsten,
>
> On Thu, 30 May 2013, Karsten Blees wrote:
>
>> Am 25.05.2013 21:16, schrieb Pat Thoyts:
>> > On that note -- with this merge as it now stands I get the following
>> > test failures:
>> >
>> > t0008-ignores.sh                     155, 158, 162, 164
>>
>> These tests fail because they use absolute paths, e.g. "C:/.../global-excludes", which is then translated to "C<NUL>/.../global-excludes". Can be fixed like so:
>>
>> --- 8< ---
>> --- a/t/t0008-ignores.sh
>> +++ b/t/t0008-ignores.sh
>> @@ -5,7 +5,7 @@ test_description=check-ignore
>>  . ./test-lib.sh
>>
>>  init_vars () {
>> -       global_excludes="$(pwd)/global-excludes"
>> +       global_excludes="global-excludes"
>>  }
>>
>>  enable_global_excludes () {
>> ---
>
> Since I do not have time for the lengthy, undirected discussion upstream
> seems to want to start, let's make your change, but only conditional on
> MINGW?
>
> Ciao,
> Dscho

I was just testing this -- I've already wrapped the suggested fix
within a "test_have_prereq MINGW" for our fork and committed it. This
was  an issue partly because was alias pwd to "pwd -W" and so always
get Windows paths. It means the test here doesn't check absolute paths
but I think we can live with that. I tried using $(builtin pwd) to
avoid the "-W" but it didn't help and I still got C: style paths.

I also grabbed Karsten's patch "dir.c: fix ignore processing within
not-ignored directories" as this appears to deal with a .gitignore
regression in 1.8.3. We can carry this until the next merge with
upstream.

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
For more options, visit https://groups.google.com/groups/opt_out.
