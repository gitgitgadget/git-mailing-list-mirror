From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: Intermittent failures in t9119
Date: Fri, 31 Dec 2010 06:13:56 -0800 (PST)
Message-ID: <190893.69491.qm@web30005.mail.mud.yahoo.com>
References: <7vmxoml1p7.fsf@alter.siamese.dyndns.org> <7vy684t0mt.fsf@alter.siamese.dyndns.org> <20101206191055.GA9597@dcvr.yhbt.net> <7vd3pesb99.fsf@alter.siamese.dyndns.org> <20101209175503.GA16478@dcvr.yhbt.net>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 15:14:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYfk7-00078v-3G
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 15:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab0LaON6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 09:13:58 -0500
Received: from web30005.mail.mud.yahoo.com ([209.191.69.22]:43960 "HELO
	web30005.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753545Ab0LaON5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Dec 2010 09:13:57 -0500
Received: (qmail 70793 invoked by uid 60001); 31 Dec 2010 14:13:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1293804836; bh=5rrmOodaiG4lLe+kJzEhxxpE+RL5rvUCEQG6nx3vUQo=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=Qg4xpx2IYiUodp+jDIDGAqYzKb1F8IYttWbx1eKIq25MjNY/coWnEpHQDpFvn7O84h9iR96gEAJbTDGK9/+LqpPu88tloLpDb6vMp0EdKSEhZyzNdPDKM3ZSjxZiXpqVoYE4EbcDTpNMqmeG17f9+3kUYlVsHxSVBVgwt/BTuVg=
X-YMail-OSG: VDRHp8MVM1m6X2Ppuwq4BAgofe4gGYeWQBiDjC8XhxDZ5W8
 F95EFHTpO8A7356A2QHKBBmtIQYuYwcGLLj9hJ8zb7OWr8.vgNSKRPs0iVEw
 Z3pK5.b4D6xo_1BNO5VdPGvAvTDePdAsuuIJ.uoENs_eKHjZZGlYV0JupPvB
 zm4bn_d4meXmxHTik5ZbzPqIlgzqdsGzJi09eQ73FJVMwtOGgMwIQfVPRNnY
 ptRtcRzsJUF.zD2hEq7JYp0tbikQ0wBgHR_rdYkbkcjcwRcZdSCN0lMfzdQ1
 4bNbV8Brajzd3zPrFIY7VYc1fx8G8LHVqm8ZWRJdMFTjc8VakK6J8yp2gPJO
 oociZ5DfdqI1h0hqzuwJimObYM_iawDtRk9gbbNaI3QRC7y03OodyepoMgef
 xtLvNljal83tn
Received: from [98.207.50.178] by web30005.mail.mud.yahoo.com via HTTP; Fri, 31 Dec 2010 06:13:56 PST
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/553 YahooMailWebService/0.8.107.285259
In-Reply-To: <20101209175503.GA16478@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164383>

Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric  Wong <normalperson@yhbt.net>  writes:
> > > Junio C Hamano <gitster@pobox.com> wrote:
> >  >>  (2) Nobody uses the value from "Text Last Updated" field in  practice, 
>so
> > >>      that bug has been unnoticed so  far;
> > >> 
> > >>  (3) And it is not worth fixing it  ;-)
> > >> 
> > >> For now, I would suggest fixing the  failing test to ignore the "Text 
Last
> > >> Updated" field while  comparing, and if somebody is inclined to, we would
> > >> update the  code to match what "svn info" does.
> > >
> > > Agreed on both  points.  I consider "git svn log" and "git svn info" to
> > > be  reasonable approximations of svn behavior, not exact replicas.
> > >  Exactly matching would be extremely difficult given variations between
> >  > different svn versions, and also svn requiring network access while
> >  > git svn does not.
> > 
> > Ok, here is a minimum patch to do  that.
> 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Thanks,  Acked-by: Eric Wong <normalperson@yhbt.net>


Acked-by: David Kilzer <ddkilzer@kilzer.net>

Thanks!

Dave
