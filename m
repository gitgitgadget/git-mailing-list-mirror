From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 11:11:49 +0200
Message-ID: <4DB92F55.5090409@op5.se>
References: <4DB80747.8080401@op5.se>	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>	<4DB82D90.6060200@op5.se>	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>	<20110427194233.GA16717@gnu.kitenet.net>	<7vwrif5q93.fsf@alter.siamese.dyndns.org>	<20110427220748.GA19578@elie>	<7vsjt35l84.fsf@alter.siamese.dyndns.org>	<20110427234224.GA26854@elie>	<7viptz5j82.fsf@alter.siamese.dyndns.org>	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com> <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:12:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNGW-0001pG-9D
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab1D1JL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:11:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47384 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab1D1JL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:11:56 -0400
Received: by bwz15 with SMTP id 15so2118905bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:11:55 -0700 (PDT)
Received: by 10.204.141.15 with SMTP id k15mr222808bku.50.1303981915312;
        Thu, 28 Apr 2011 02:11:55 -0700 (PDT)
Received: from vix.int.op5.se (m83-186-240-35.cust.tele2.se [83.186.240.35])
        by mx.google.com with ESMTPS id 16sm889228bkm.18.2011.04.28.02.11.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 02:11:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172328>

On 04/28/2011 04:15 AM, Jon Seymour wrote:
> Assuming for the moment that the concept of a managed plugin is accepted, then.
> 
> The relationship between distribution managers and the git-plugin
> architecture would be as follows:
> 
> - distributions would know how to locate the git instance it manages
> - distributions would know how to install their own packages that
> contain plugins into plugins/ subdirectory of this git instance
> - distributions would know how to run git plugin activate and properly
> handle non-zero return codes from same
> 
> make install scripts would act like a kind of distribution in this regard.
> 
> Now consider this:
> 
> * suppose that git-core defined a git install _interface contract_ but
> did not define an implementation.
> 

Please. I'm already on my way to a seriously boring sales meeting without
having developers throw garbage terms on me. You've done a lot of that in
this thread and I for one am confused by them as to what you want to
achieve and how you want to achieve it.

> Then, a distribution could install its own implementation of the
> git-install plugin into git installations it manages.
> 
> Then a command like:
> 
>      git install gitwork
> 
> would trivially work across all distributions precisely because the
> distribution has provided the implementation of the git install
> interface contract that git-core has helpfully mandated.
> 

And so we force package maintainers to become git extension developers.
Brilliant. They'll love you for it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
