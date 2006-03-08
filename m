From: Andreas Ericsson <ae@op5.se>
Subject: Re: Update hook in Cygwin
Date: Wed, 08 Mar 2006 14:36:36 +0100
Message-ID: <440EDDE4.9070405@op5.se>
References: <ad8ce5c20603080416g5ed6d77el@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 14:37:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGyqQ-0002NA-5a
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 14:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCHNgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Mar 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWCHNgi
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 08:36:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3531 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751111AbWCHNgi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 08:36:38 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B9B426BD60; Wed,  8 Mar 2006 14:36:36 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: =?ISO-8859-15?Q?Niklas_H=F6glund?= <nhoglund@gmail.com>
In-Reply-To: <ad8ce5c20603080416g5ed6d77el@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17371>

Niklas H=F6glund wrote:
> Hi.
>=20
> After creating a couple of repositories and pushing and cloning them,
> I get the following:
>=20
> $ git push --all origin
> ...
> hooks/update: line 88: mail: command not found
>=20
> This is in cygwin. I'm rather glad I don't have the mail command
> installed, as I don't want mails going anywhere.
>=20
> The update hook contains the following comment:
>=20
> # To enable this hook:
> # (1) change the recipient e-mail address
> # (2) make this file executable by "chmod +x update".
>=20
> But my impression after a cursory look at it is that it would always
> call "mail" whenever it is run, and since all files are executable in
> Windows (AFAIK), it would always be run.


I was under the impression that the cygwin abstraction layer had some=20
unixy permission thing on top of NTFS. Perhaps that's wrong. If you=20
remove the hook it won't be called.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
