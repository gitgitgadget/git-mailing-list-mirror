From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 14 Mar 2007 12:47:03 +0100
Message-ID: <8aa486160703140447g560e3b42j7a14f6c3032bb77a@mail.gmail.com>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	 <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	 <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
	 <7vhcsphqtk.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160703131614i1b67e6c3vf7ccf395d63573b4@mail.gmail.com>
	 <7vbqiwawva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Paolo Bonzini" <paolo.bonzini@lu.unisi.ch>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 12:47:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRRwm-0007Ff-GZ
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 12:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbXCNLrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Mar 2007 07:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbXCNLrI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 07:47:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:4820 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161152AbXCNLrF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2007 07:47:05 -0400
Received: by nf-out-0910.google.com with SMTP id o25so178543nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 04:47:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dFB2bmHSnESUWnT2TVaUkkolhhSsD+btq3rv9Xojd9e4t5VLiE72beN6lesemUXbShHmYbYNlPR/U7wJ65+oMBgqFD7/sYEjV8mngcBnwDZ+d+JzPXm5IAG0hwEuqbywoexDoLo9ySlPcodkmCY3u5Dp/DSfqR4CQkbs71CFemc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YXAWQCfxozClrT0O8pP7cUQH/o7BC+VwLPTIY++PQyLjSyU8j7bPzHuebCodn6iLrlxC6LYkFSiNQTrc6gE4c3Mn81wWlA2jIT+v8LNWEcQy9Xy1+JutYyhsC0NUO2pHfg9N2uqZfHekM8GyRJ6T9cfxkzkR36n5hLQ+tGmaQWY=
Received: by 10.78.136.7 with SMTP id j7mr1119707hud.1173872823871;
        Wed, 14 Mar 2007 04:47:03 -0700 (PDT)
Received: by 10.78.69.4 with HTTP; Wed, 14 Mar 2007 04:47:03 -0700 (PDT)
In-Reply-To: <7vbqiwawva.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42200>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> >> I tried the "NULL fetch between 1000-refs repositories" test,
> >> which prompted the git-fetch--tool work that was done on
> >> jc/fetch topic in 'next', with the following versions:
> >>
> >>  (1) 1.5.0 (without any git-fetch--tool optimization)
> >>  (2) master (ditto)
> >>  (3) master with jc/fetch (but not sb/fetch topic)
> >>  (4) next ((3) plus sb/fetch and others)
> >>
> >> The test scripts are at the end of this message.  Both (1) and
> >> (2) take 3 minutes 7 seconds wallclock time.  (3) improves it
> >> down to 15 seconds.  (4) makes the operation spend 24 seconds
> >> (the times are all on my primary machine x86-64 with 1GB, hot
> >> cache and average of three runs each).
> >
> > I think it is not fair,...

[...]

>, and you may not like the
> numbers, but if you call that is "not fair", I do not know what
> could be considered fair.

I would consider fair the comparison you did not quote, a comparison
with the merge logic written in C. I know that (4) is a step backwards
in performance as it is now, and I understand that with those numbers
the "Split" patch must be reverted.

Santi
