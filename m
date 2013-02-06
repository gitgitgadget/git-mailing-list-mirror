From: demerphq <demerphq@gmail.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 6 Feb 2013 19:25:43 +0100
Message-ID: <CANgJU+VbkQ+xa+_sSAu-3pMe+6gycHi9J4VR18M5YJt=pa9QUw@mail.gmail.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
	<871ucto4vj.fsf_-_@lifelogs.com>
	<7vvca5mmmt.fsf@alter.siamese.dyndns.org>
	<87vca5gvx6.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39hF-0002nc-0y
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab3BFSZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:25:47 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:41308 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab3BFSZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:25:44 -0500
Received: by mail-qa0-f48.google.com with SMTP id j8so800997qah.0
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3sgDnsQNPi0DBatZJtf1gbToQ9Q3u4x/3bGgBsny+L0=;
        b=alKK48qDbpoeE/q626UXwwufQhVfT80Ic0bMV1r9FQQRpgL/D1BW/5mqflnov2WW+q
         Teit72RaiUtgL+Vd/ZjOK8b057Nm8QhniZOMMwNrpRu5wGeEX+1s/mX7YRcJSyVJtYyh
         lOmaPNUmV5kW8l4/Wr+3aJct2NCWeYgicQEEAz56Z40jIiRHt3AaL2VUC25lILGHf34+
         1O34b4i54ngzG8OBlW8rWV4PrfES7IoVnfG1kuUN5fHSyYhuuoFRgkga0kP7DHWgaMmJ
         uqyc0Vo4E9TOZ66X+74jAkCTt5dnc4g+VLv5TRL0MwFxd0XWuNALrTdCotNFhNE0x454
         c9Cw==
X-Received: by 10.49.133.195 with SMTP id pe3mr24763526qeb.58.1360175144057;
 Wed, 06 Feb 2013 10:25:44 -0800 (PST)
Received: by 10.49.94.196 with HTTP; Wed, 6 Feb 2013 10:25:43 -0800 (PST)
In-Reply-To: <87vca5gvx6.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215616>

On 6 February 2013 19:05, Ted Zlatanov <tzz@lifelogs.com> wrote:
> On Wed, 06 Feb 2013 08:29:30 -0800 Junio C Hamano <gitster@pobox.com> wrote:
>
> JCH> Is it ever (as opposed to "not always") possible to omit braces?
>
> Oh yes!  Not that I recommend it, and I'm not even going to touch on
> Perl Golf :)

I think you are wrong. Can you provide an example?

Larry specifically wanted to avoid the "dangling else" problem that C
suffers from, and made it so that blocks are mandatory. The only
exception is statement modifiers, which are not only allowed to omit
the braces but also the parens on the condition.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
