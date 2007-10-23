From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Tue, 23 Oct 2007 09:44:59 +0200
Message-ID: <A225BBC0-2607-4952-8578-EC9A181C418E@wincent.com>
References: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022163244.4af72973@danzwell.com> <20071023040315.GA28312@coredump.intra.peff.net> <D1795135-AD5E-491C-99E6-30486E189B13@wincent.com> <20071023064106.GA30351@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 09:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkET1-0004IT-NC
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 09:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXJWHqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2007 03:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXJWHqL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 03:46:11 -0400
Received: from wincent.com ([72.3.236.74]:39157 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbXJWHqL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 03:46:11 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9N7jk3K004471;
	Tue, 23 Oct 2007 02:45:47 -0500
In-Reply-To: <20071023064106.GA30351@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62119>

El 23/10/2007, a las 8:41, Jeff King escribi=F3:

> On Tue, Oct 23, 2007 at 08:28:28AM +0200, Wincent Colaiuta wrote:
>
>> I did too, where you add a third, optional "trailer" parameter to th=
e
>> function where you pass the newline if there is one (following the =20
>> style of
>> the functions in color.c). Pasting it below.
>
> The problem with that approach is that you can only send in a single
> line at a time (with the newline detached!), so it makes life =20
> harder for
> the caller. E.g., there is at least one spot that uses a here-doc wit=
h
> many lines; splitting that into a bunch of print_ansi_color calls =20
> would
> be unnecessarily ugly.

Yes, I agree that it complicates things for the caller. I was just =20
copying the model found in color.c; but seeing as this is Perl =20
splitting into lines inside the printing function would be =20
straightforward.

Cheers,
Wincent
