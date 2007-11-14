From: Bill Lear <rael@zopyra.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 14:22:31 -0600
Message-ID: <18235.22791.974033.758825@lisa.zopyra.com>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru>
	<7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
	<18235.22445.16228.535898@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <wielemak@sci
X-From: git-owner@vger.kernel.org Wed Nov 14 21:22:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOl9-0008Dm-Gl
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbXKNUWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbXKNUWf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:22:35 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60464 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbXKNUWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:22:34 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lAEKMX529928;
	Wed, 14 Nov 2007 14:22:33 -0600
In-Reply-To: <18235.22445.16228.535898@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65007>

[I sent a few mistakes --- edited below.]
On Wednesday, November 14, 2007 at 14:16:45 (-0600) Bill Lear writes:
>...
>Well, here's what we'd like:
>
>% mkdir new_repo
>% cd new_repo
>% git --bare init
>
>[on another machine:]
>% git clone git://host/new_repo
>% cd new_repo
>% git init
[No git init would be needed here, obviously.]
>[add content]
>% git commit -a -m "Initial stuff"
>% git push
>
>So, this is hard work, and other priorities intrude.  Ok.
>
>Instead, we have to 1) figure out how to do this right, because it's
>difficult to remember and not intuitive, and 2) once we have "figured
>it out", really figure it out, because there are a few gotchas:
>
>% mkdir new_repo
>% cd new_repo
>% git --bare init
>
>% mkdir new_repo
>% cd new_repo
[git init is needed here...]
>[add content]
>% git commit -a -m "Initial stuff"
>% git config remote.origin.url git://host/new_repo
>% git push
>[ach! fails!  what's up??]
>[poke, read, poke some more, try other things..]
>[try setting the remote.origin.fetch?  No, that doesn't work]
>[try setting branch.master.remote?  Just edit by hand??]
>% git push master
>[fails again; read some more; think, think, think...]
>% git push origin master
>[aha! finally it works]
>...

Sorry for the sloppiness.


Bill
