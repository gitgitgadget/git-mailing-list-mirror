From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] notes: attach help text to subcommands
Date: Fri, 8 Jun 2012 17:54:23 +0200
Message-ID: <CAMP44s28aoKkXyTr4Stow-empen9_CUxAWTDi_gcSUpKjMzg6Q@mail.gmail.com>
References: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
	<1339169317-12134-1-git-send-email-artagnon@gmail.com>
	<20120608153607.GC10380@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd1W9-0007o8-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab2FHPy0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 11:54:26 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62412 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761121Ab2FHPyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 11:54:25 -0400
Received: by lbbgm6 with SMTP id gm6so1465276lbb.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hqqrbO7AFx5JA0K+IPz/aNDOZhcqAvpTXbnzZCLkwAc=;
        b=0OMyuqdlb8vCU80Q+RCycjm3Tt6eATgoW4M4lsrrswUZTaVVuxJvCuRzqw/akb+ADo
         w3M/wOAU5pjvTxhcqEQ4R0w3ASncxhwCnfFM6ZCn8QKliv3kgsVApDcgt7ikk4vEWj1r
         dI7EP0B8xd92RR/EoSlqlW4PrwjZACzZTeE679DpXw/xSVAM0iqAN1sKXeVv2QZtXbwX
         UY7fOMqUe6v/z9l9UJaIbFrAF+Mka3nkxqqn7x4BEtvwdhP5gqxBIVX4Pr7IqnvzCFKc
         SFV97yPJW7Hrz+5GxA6RZmPLD7POJLKGhs+UVBftuwqvrMku9fMXcxAJSPJrfVACpXvF
         Bkrg==
Received: by 10.112.82.165 with SMTP id j5mr4214353lby.50.1339170863440; Fri,
 08 Jun 2012 08:54:23 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Fri, 8 Jun 2012 08:54:23 -0700 (PDT)
In-Reply-To: <20120608153607.GC10380@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199507>

On Fri, Jun 8, 2012 at 5:36 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Ramkumar Ramachandra wrote:
>
>> =C2=A0Thanks. =C2=A0I wish we could do something aout USAGE_OPTS_WID=
TH and
>> =C2=A0USAGE_GAP; I stole them from parse-options.
>
> Expose them in parse-options.h? =C2=A0Or put this functionality in a
> parseopt-related file?
>
> Copy+paste must die. :)

There's many commands that would benefit from this. In addition to
provide a better help for subcommands, this can be used to generate
automatically the shell completion list of subcommands.

Even more; in zsh it would be possible to show this help text directly
in the completion.

Cheers.

--=20
=46elipe Contreras
