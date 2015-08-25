From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 22:07:22 +0200
Message-ID: <CANy2qHdiXXkz2KjUaPebApKHFiKnDxPrc+i-BP0DN07KOeS8HA@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUKVS-0001O3-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbbHYUHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 16:07:31 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37519 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbbHYUHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2015 16:07:24 -0400
Received: by widdq5 with SMTP id dq5so25078315wid.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=E0Q4JqRnic/mROdDECmoV04pKqNSv9CCrA6WnSlRMNo=;
        b=kI5sm3N1+4Z40IfBxwVTnQRQmqp6diAKNbB0owymouvjBDUBH3psy1t7nKo1SXHjhU
         2rjRotfXT0H9+rO6bR632Y1kwrpuK9wZmB5L3oKY8IRpgI9XTjrU2L4AvH2PhY/2Kv7G
         Gfprr8CO+UrYyVTCqEhTXSNgEs19CYfXu6hu8iP5QwG65cnJLkPcM/71XZjv2cml5Nrh
         Nir0z8qrJdsuu415EcHQ246bAfNwwNguQpwFmQCk7SZq1cuR5tf/bdtmz83K5k46Ag58
         DLydiOk+P9IbJ+OmQE5R5Umb/O+LgrwyzgcNnSmVAg8fIbmqR0hAq3eDvHPhIevl56TX
         fu0w==
X-Received: by 10.180.107.202 with SMTP id he10mr7599270wib.35.1440533242341;
 Tue, 25 Aug 2015 13:07:22 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Tue, 25 Aug 2015 13:07:22 -0700 (PDT)
In-Reply-To: <20150825185414.GA10895@sigill.intra.peff.net>
X-Google-Sender-Auth: lQRiFDQGl3G3UR-pdzxzYVOvYtY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276567>

I would lean for an extra on-demand flag for this, and a per commit
measurement, initial noise is okay for the first iteration I think.
Secondly note that on the output other messages could also be present
(other than the rewrite), as the command running may have its own
output. I will try to create a initial version just have some time for
it :)

On 8/25/15, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 25, 2015 at 02:52:10PM -0400, Jeff King wrote:
>
>> Yeah, that would probably be a good solution, assuming there is a
>> portable "how many seconds" (I do not relish the thought of
>> reconstructing it based on the current hours/minutes/seconds).
>
> A little googling came up with:
>
>     awk 'END { print systime() }' </dev/null
>
> which probably (?) works everywhere. I feel dirty just having typed
> that, though.
>
> -Peff
>


--=20
 Bern=C3=A1t G=C3=A1bor
Student -  Budapest University of Technology and Economics - Computer
Engineering, M.Sc. - Budapest, Hungary
System Integrator - Gravity R&D | Rock Solid Recommendations - Budapest
office | 5-7 Expo ter | H-1101 | Budapest | Hungary
