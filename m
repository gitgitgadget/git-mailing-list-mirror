From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] notes: attach help text to subcommands
Date: Fri, 8 Jun 2012 22:04:21 +0530
Message-ID: <CALkWK0k_tP7qGJ9zvAvrPtqMqAtK2QE7mibf2Yt1gssN10a1NA@mail.gmail.com>
References: <7vd359eu4s.fsf@alter.siamese.dyndns.org> <1339169317-12134-1-git-send-email-artagnon@gmail.com>
 <20120608153607.GC10380@burratino> <CAMP44s28aoKkXyTr4Stow-empen9_CUxAWTDi_gcSUpKjMzg6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 18:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd299-0002Y3-I5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 18:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761948Ab2FHQen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 12:34:43 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36534 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab2FHQem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 12:34:42 -0400
Received: by wibhm6 with SMTP id hm6so1466363wib.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=72HGiigCfxNlP750KLVn8Dm7Bs1ho4vELUsZuAfGsR0=;
        b=w6j8AvLv9iGXbpqfA8h2oChbMITIjPCkTZS3NqTFi+O2wPLptX1SI97vbBqJG85FEh
         aKZAKsM4c3qKyZ/dJSHwBpSy1ZnqwUk1GZWk+dtA4wIO9yTXZSL4ioe7mWEp7gk0Uj8S
         /Jfc0zzXh+3GzG89j5lnJgUzor4bbC8p0k8lM36ZGrkZo4rRiRvITK15kGLEv8QLlAUV
         5ha/gKa5cjck3qF1lpx1IoeE9EZMlL/r8s7B9WJACKHpq1Zn1ssZBVd/QYjP8Ov9MHHe
         J3sALh69guYo/TdclKg8shcMYXhwYdpleFPPZ0xZIjwROMK9blxd+Q4L0cTq7BX3sbdq
         ving==
Received: by 10.216.210.225 with SMTP id u75mr1648847weo.13.1339173281511;
 Fri, 08 Jun 2012 09:34:41 -0700 (PDT)
Received: by 10.216.160.9 with HTTP; Fri, 8 Jun 2012 09:34:21 -0700 (PDT)
In-Reply-To: <CAMP44s28aoKkXyTr4Stow-empen9_CUxAWTDi_gcSUpKjMzg6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199511>

Hi Jonathan and Felipe,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> =C2=A0Thanks. =C2=A0I wish we could do something aout USAGE_OPTS_WID=
TH and
>> =C2=A0USAGE_GAP; I stole them from parse-options.
>
> Expose them in parse-options.h? =C2=A0Or put this functionality in a
> parseopt-related file?

Exposing a `subcommand_usage` in parse-options.h may not be a bad idea.

=46elipe Contreras wrote:
> There's many commands that would benefit from this. In addition to
> provide a better help for subcommands, this can be used to generate
> automatically the shell completion list of subcommands.
>
> Even more; in zsh it would be possible to show this help text directl=
y
> in the completion.

How exactly is that going to work?  `git notes -h` doesn't output
this- so the only way to get this output is to invoke `git notes` with
an invalid subcommand.  To fix that, I'd have to teach parse-options
about subcommands.

Ram
