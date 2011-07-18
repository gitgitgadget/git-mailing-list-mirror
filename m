From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: git bash
Date: Mon, 18 Jul 2011 20:51:41 +0200
Message-ID: <4E2480BD.9000403@dirk.my1.cc>
References: <4DFB5C37.1090606@micronengineering.it> <20110617141822.GD7751@centaur.lab.cmartin.tk> <4DFB6710.8090105@dirk.my1.cc> <alpine.DEB.1.00.1107150114240.2642@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <carlos@cmartin.tk>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 18 20:51:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qisv0-000732-Go
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab1GRSvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 14:51:45 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:38886 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1GRSvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:51:45 -0400
Received: from [217.87.103.122] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Qisus-000277-Hg; Mon, 18 Jul 2011 20:51:42 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <alpine.DEB.1.00.1107150114240.2642@bonsai2>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177397>

Hi Johannes,

Am 15.07.2011 01:15 schrieb Johannes Schindelin:
> Hi Dirk,
>=20
> On Fri, 17 Jun 2011, Dirk S=FCsserott wrote:
>=20
>> I noticed the following: When the ext. HD is attached/mounted *befor=
e* I=20
>> start the bash, then it works. But if I have a running bash and then=
=20
>> mount the drive, I cannot cd to it. "No such path" or sth. It seems,=
=20
>> that bash builds a list of available drives only at startup. Might t=
hat=20
>> be your problem? If so, then close all bashs and re-open them after=20
>> mounting the devices.
>=20
> This behavior is discussed here:
>=20
> http://permalink.gmane.org/gmane.comp.version-control.git/141867
>=20
> (look for "NO_FSTAB_THREAD")
>=20
> Ciao,
> Johannes

thank you for the pointer. That's what I've observed. To be honest, I'm
one of the lazy guys and didn't really understand the impact of setting
NO_FSTAB_THREAD at first glance. As I understood, setting it means
"mounting drives afterwards works, but slows things down" and not
setting it means the opposite. Meanwhile I'm familiar with re-starting
my git-bash in case (that's not too bad for me). I almost never run git
commands from cmd.exe because cmd.exe is rubbish.

But, again, thanx for the help; now I know how to fine-tune the
behaviour if I wish.

Cheers,
Dirk
