From: Johan Herland <johan@herland.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 12:02:46 +0200
Message-ID: <201106141202.46720.johan@herland.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <7vtybtm3dl.fsf@alter.siamese.dyndns.org>
 <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:04:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQTa-00022D-Vz
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 12:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab1FNKDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 06:03:53 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48743 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab1FNKDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 06:03:52 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMR00D6TYMDBFB0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Jun 2011 12:03:49 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id C1FDF17992DA_DF73205B	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 10:03:49 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1B6371796FB0_DF731C8F	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 10:02:47 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMR005YDYKMT030@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Jun 2011 12:02:47 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175756>

On Tuesday 14 June 2011, Sverre Rabbelier wrote:
> Heya,
> 
> On Tue, Jun 14, 2011 at 06:41, Junio C Hamano <gitster@pobox.com> wrote:
> > I would rather want to see if somebody can come up with a flexible
> > reverse mapping feature around notes. It does not have to be
> > completely generic, just being flexible enough is fine.
> 
> Wouldn't it be enough to simply create a note on 'r651235' with as
> contents the git ref?

Not quite sure what you mean by "create a note on 'r651235'". You could 
devise a scheme where you SHA1('r651235'), and then create a note on the 
resulting hash.

Notes are named by the SHA1 of the object they annotate, but there is no 
hard requirement (as long as you stay away from "git notes prune") that the 
SHA1 annotated actually exists as a valid Git object in your repo.

Hence, you can use notes to annotate _anything_ that can be uniquely reduced 
to a SHA1 hash.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
