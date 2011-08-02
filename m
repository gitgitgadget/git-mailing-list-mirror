From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 2/2] grep: long context options
Date: Tue, 02 Aug 2011 19:24:01 +0200
Message-ID: <4E3832B1.1030408@lsrfire.ath.cx>
References: <4E357BE2.8030409@lsrfire.ath.cx> <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com> <4E36C840.9000808@lsrfire.ath.cx> <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com> <4E36E0EC.1000508@lsrfire.ath.cx> <20110802010143.GL13795@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:24:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoIhP-00014H-Nu
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1HBRYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 13:24:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:55346 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1HBRYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:24:05 -0400
Received: from [192.168.2.104] (p4FFDA3FA.dip.t-dialin.net [79.253.163.250])
	by india601.server4you.de (Postfix) with ESMTPSA id 1CFF72F8035;
	Tue,  2 Aug 2011 19:24:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110802010143.GL13795@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178487>

Am 02.08.2011 03:01, schrieb Tait:
> Ren=E9 Scharfe <rene.scharfe_lsrfire.ath.cx> said (on 2011/08/01):
>> Take long option names for -A (--after-context), -B (--before-contex=
t)
>> and -C (--context) from GNU grep and add a similar long option name
>> for -W (--function-context).
>=20
> Why not just add --context=3Dfunction? Then when I want --context=3Di=
ndent
> to give context based on the indent-level, it is an intuitive extensi=
on
> of the existing options. (Of course, --context=3D<number> would still=
 do
> exactly what it does now.)

With the current patches, you can use --function-context together with
--context=3D<num> to specify a minimum number of context lines to show,
even beyond function boundaries.

I'd expect a --context=3Dfunction option to be equivalent to -W -C0 and
--context=3D<num> to be equivalent to -C<num> --no-function-context, so
the syntax would be limited in that regard (or be unintuitive to me).

We can still add it on top, though.

Ren=E9
