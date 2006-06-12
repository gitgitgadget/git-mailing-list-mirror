From: David Kowis <dkowis@shlrm.org>
Subject: Re: Thoughts on adding another hook to git
Date: Mon, 12 Jun 2006 14:10:35 -0500
Message-ID: <448DBC2B.1070807@shlrm.org>
References: <448DB201.5090208@shlrm.org> <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 21:11:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fproa-0006jh-VL
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFLTKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbWFLTKl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:10:41 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:5264 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1752191AbWFLTKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:10:41 -0400
Received: from pimout6-ext.prodigy.net (pimout6-int.prodigy.net [207.115.4.22])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id k5CJAe4Q012378
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 15:10:42 -0400
X-ORBL: [66.143.247.87]
Received: from mail.shlrm.org (adsl-66-143-247-87.dsl.snantx.swbell.net [66.143.247.87])
	by pimout6-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id k5CJAave220024;
	Mon, 12 Jun 2006 15:10:36 -0400
Received: from [192.168.2.111] (rrcs-24-173-63-133.sw.biz.rr.com [24.173.63.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.shlrm.org (Postfix) with ESMTP id 5D9A528034B4;
	Mon, 12 Jun 2006 14:10:36 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21730>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Yakov Lerner wrote:
> On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
>> I'd like to be able to modify the commit message before it ends up in
>> the $EDITOR.
> 
> Can't you define $EDITOR to point to some script
> which modifies the file as you wish then calls the
> real editor on it ?
> 

I could, but then anything else that uses $EDITOR would also be affected
in the same way... Which would produce interesting results.

- --
David Kowis

ISO Team Lead - www.sourcemage.org
Source Mage GNU/Linux

Progress isn't made by early risers. It's made by lazy men trying to
find easier ways to do something.
  - Robert Heinlein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iQGVAwUBRI28K8nf+vRw63ObAQoKPgv9EvwbDkGmct7IZGFMydea+HlIMWR+Jyla
WHYnCN353Hw+WbOIvnTvlJrI1R+zSYIu2tDhZ2P/2czyWyja8HQHjGhTXbBInILX
T4ODPwZ55od4uDi1arnHgRpJwhLeGIU+1Wxc8k70tszWj2gb6sIGMHcK9LhzZ+Sf
lEY6iGF74TE3gyQsj78smxL/COvNjzoCWY4AieIVxtu7b1shb7lZXbnkfcKhs82L
0bdmHKri7999nxgWnmdyaDi9RuYOKinc/YhrKDrvY2GB5c8BQHgpFMDR/17oTREL
PTmAJwFs8dAAalGmPAajZY1gXrqo/lVb4JPK4b2QboEC8SGpFwcq4jtHCr/s2mQd
uNINnZ62+dxgRxk9koW2QZeh7hPB8rFcIufUhUC19P0+UWv5TDuKie/mR1U6uZNN
BfTIj/1AI5+l9kCJS+om9o8P1m2wPW4MsP2XaqatInUz9YXn14zrjcKTZnCuIMvw
mqrBlfI7L2KEsoL4ywJsb4ATVz7M6G0I
=IFOu
-----END PGP SIGNATURE-----
