From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] Export format_commit_message()
Date: Mon, 03 Sep 2007 20:44:10 +0200
Message-ID: <46DC55FA.6040905@lsrfire.ath.cx>
References: <46DC4D2C.8070109@lsrfire.ath.cx> <Pine.LNX.4.64.0709031934480.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISGuL-0000ll-NS
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 20:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbXICSoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbXICSoQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 14:44:16 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40102
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751907AbXICSoP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 14:44:15 -0400
Received: from [10.0.1.201] (p508EFD82.dip.t-dialin.net [80.142.253.130])
	by neapel230.server4you.de (Postfix) with ESMTP id C062B873B5;
	Mon,  3 Sep 2007 20:44:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709031934480.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57502>

Johannes Schindelin schrieb:
>> -static long format_commit_message(const struct commit *commit,
>> -		const char *msg, char **buf_p, unsigned long *space_p)
>> +long format_commit_message(const struct commit *commit, const void =
*template,
>> +                           char **buf_p, unsigned long *space_p)
>=20
> I am quite sure that this breaks compilation in C++.
>=20
> Besides, "format" is so much more descriptive here IMHO.  What is so =
wrong=20
> with "format" for you?

I have nothing against naming the parameter "format", actually.  This
name simply didn't occur to me -- weird but true. :-]

Ren=E9
