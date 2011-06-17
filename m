From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: git bash
Date: Fri, 17 Jun 2011 16:39:12 +0200
Message-ID: <4DFB6710.8090105@dirk.my1.cc>
References: <4DFB5C37.1090606@micronengineering.it> <20110617141822.GD7751@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <carlos@cmartin.tk>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 17 16:47:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXaK6-00005k-SB
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 16:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab1FQOq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jun 2011 10:46:59 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:46939 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab1FQOq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 10:46:58 -0400
Received: from [84.176.58.117] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1QXaCY-0007Ki-2s; Fri, 17 Jun 2011 16:39:14 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110617141822.GD7751@centaur.lab.cmartin.tk>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175949>

Am 17.06.2011 16:18 schrieb Carlos Mart=EDn Nieto:
> On Fri, Jun 17, 2011 at 03:52:55PM +0200, Massimo Manca wrote:
>> Hi all,
>> I am using git on Linux Ubuntu, Windows Vista, , Windows 7 and Windo=
ws
>> XP (several o.s. to develop sw).
>> In my notebook under Vista if I use bash on mi physical HD (it is
>> divided in C:, F:, H:) it works, if I try to open a bash console on =
an
>=20
> Assuming you mean that git doesn't work (rather than bash), could you
> provide a transcript of what you think went wrong?
>=20
>> external HD (or USB or SD memories) and also on network shared drive=
s it
>> doesn't work.
>=20
> Are these filsystems FAT32 by any chance. You may need to turn on a
> couple of compatibility options like case-insensitivity and filemode.

But when using msysGit, these options are already set appropriate,
aren't they?

Sometimes I have a similar problem. What do you mean by "opening a bash
console on an external HD"? Do you right-click a folder and then "Git
bash (here)"? I don't use that feature but I always start the bash with
its regular icon (so my answer may probably not help you).  It then
starts in my $HOME and I change to the external HD (say X:) like so:

$ cd /x/foo

I noticed the following: When the ext. HD is attached/mounted *before* =
I
start the bash, then it works. But if I have a running bash and then
mount the drive, I cannot cd to it. "No such path" or sth. It seems,
that bash builds a list of available drives only at startup. Might that
be your problem? If so, then close all bashs and re-open them after
mounting the devices.

HTH,
Dirk
