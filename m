From: James Cloos <cloos@jhcloos.com>
Subject: Re: Millisecond precision in timestamps?
Date: Mon, 10 Dec 2012 15:56:19 -0500
Message-ID: <m31uexsk1f.fsf@carbon.jhcloos.org>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
	<20121128075807.GA9912@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 22:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiAm9-0003ib-4R
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 22:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2LJVUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 16:20:13 -0500
Received: from eagle.jhcloos.com ([207.210.242.212]:54822 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab2LJVUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 16:20:11 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2012 16:20:11 EST
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 9EF4240113; Mon, 10 Dec 2012 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1355173803;
	bh=LA895oxiJirFJ/dpZyQBbpWkDbWHqsDeypyJLLmlEDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=xRJ1zzjHgt731wSyr/tcC5MbiNyJAiWFfQleuhzZL57O7+ObFwg4OlNNvdf3vFyjA
	 Fk+Kklfk12KD+V+vD/gq9jVXQZbTe+8bFYjkLbEQMHsvXoXCw7q+wSm0X2lYwvbHK2
	 Gd8OLoGP2mIhS5BmEz3QyjS0OB6Q94rpiXQCUZ7w=
Received: by carbon.jhcloos.org (Postfix, from userid 500)
	id 454CA60021; Mon, 10 Dec 2012 20:56:19 +0000 (UTC)
In-Reply-To: <20121128075807.GA9912@thyrsus.com> (Eric S. Raymond's message of
	"Wed, 28 Nov 2012 02:58:08 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAACVBMVEX///8ZGXBQKKnCrDQ3
 AAAAJElEQVQImWNgQAAXzwQg4SKASgAlXIEEiwsSIYBEcLaAtMEAADJnB+kKcKioAAAAAElFTkSu
 QmCC
Copyright: Copyright 2012 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:30:121210:esr@thyrsus.com::ThX7pvU/KWERY/ZN:0FzlZG
X-Hashcash: 1:30:121210:gitster@pobox.com::Xw45oTdfVkEa76A+:00000000000000000000000000000000000000000009a5Zm
X-Hashcash: 1:30:121210:peff@peff.net::5Pa/fqritsI5Y52n:000ThLhZ
X-Hashcash: 1:30:121210:spearce@spearce.org::OoEMxfeGYOmVpSYt:00000000000000000000000000000000000000000VM280
X-Hashcash: 1:30:121210:felipe.contreras@gmail.com::9YM7lrXZRiVrIXwa:0000000000000000000000000000000000P91Hl
X-Hashcash: 1:30:121210:git@vger.kernel.org::on7jwTwE1CIdw/br:000000000000000000000000000000000000000003ORyv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211275>

>>>>> "ESR" == Eric S Raymond <esr@thyrsus.com> writes:

ESR> I've never seen a software project under version control with bits
ESR> that old,

They do exist, but the vcs timestamps are (at least for those in git :)
not (always) correlated to when the files were first added to the project.

Maxima, as an example, has code which was written in the '60s.  (A
couple of years ago a bug was fixed in a contrib module which had
been added to MACSYMA back in '62 or so.)

I beleive axiom also has some similarly ancient code.

Those two are now managed in git.  (Except for the openaxiom fork.)

And there is a high-energy physics package still under development
with code going back to the '50s.  I'm pretty sure they moved to a
vcs sometime in the last decade or two. :)

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
