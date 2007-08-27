From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Mon, 27 Aug 2007 15:18:18 +0200
Message-ID: <46D2CF1A.9020303@op5.se>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi> <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi> <fam221$oj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPeU9-00082w-5j
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbXH0NSW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 09:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbXH0NSW
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:18:22 -0400
Received: from mail.op5.se ([193.201.96.20]:39889 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbXH0NSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:18:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E269B1943F3;
	Mon, 27 Aug 2007 15:18:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QsRujS2nT5FE; Mon, 27 Aug 2007 15:18:19 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 499E4194020;
	Mon, 27 Aug 2007 15:18:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <fam221$oj$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56827>

Jakub Narebski wrote:
> V=E4in=F6 J=E4rvel=E4 wrote:
>=20
>> The way I see the flag used is: A user runs "git status", sees that =
=20
>> there is too much untracked files and not enough scrollback, so he =20
>> runs "git status --only-tracked" to filter the results.
>=20
> I like it.
>=20

Ack on that. It's happened to me a bunch of times, usually followed by
<identical command> | sed '/Untracked/,$d'

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
