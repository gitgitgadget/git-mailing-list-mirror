From: Amit Walambe <awalambe@arcom.com>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:15:38 +0100
Message-ID: <469CF93A.9070802@arcom.com>
References: <469CE836.6010508@arcom.com> <469CF2E6.1020104@lsrfire.ath.cx> <469CF52D.10407@arcom.com> <Pine.LNX.4.64.0707171809190.29062@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Amit Walambe (awalambe@arcom.com)" <awalambe@arcom.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:15:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqeO-0000x7-5S
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136AbXGQRPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbXGQRPo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:15:44 -0400
Received: from mail28.messagelabs.com ([216.82.249.131]:60028 "HELO
	mail28.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755929AbXGQRPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 13:15:43 -0400
X-VirusChecked: Checked
X-Env-Sender: awalambe@arcom.com
X-Msg-Ref: server-7.tower-28.messagelabs.com!1184692541!36169366!1
X-StarScan-Version: 5.5.12.11; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Received: (qmail 6010 invoked from network); 17 Jul 2007 17:15:42 -0000
Received: from mail2.arcom.com (HELO mail2.arcom.com) (194.200.159.164)
  by server-7.tower-28.messagelabs.com with SMTP; 17 Jul 2007 17:15:42 -0000
Received: from amit.arcom.cc [10.2.2.55] by mail2.arcom.com with ESMTP
  (SMTPD32-8.00) id AA791F6900AC; Tue, 17 Jul 2007 18:20:57 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <Pine.LNX.4.64.0707171809190.29062@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52782>

Julian Phillips wrote:
> On Tue, 17 Jul 2007, Amit Walambe wrote:
>=20
>> But telling good/bad points to git bisect still fails, whether I pas=
s=20
>> the commit-id or the tags I created with commands given by Ren=E9 :
>>
>> root@amit:/usr/src/linux-git # git bisect good=20
>> 8f41958bdd577731f7411c9605cfaa9db6766809
>> cat: .git/BISECT_NAMES: No such file or directory
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git # git tag v2.6.22-git6=20
>> 8f41958bdd577731f7411c9605cfaa9db6766809
>> root@amit:/usr/src/linux-git # git tag v2.6.22-git8=20
>> a5fcaa210626a79465321e344c91a6a7dc3881fa
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
>> cat: .git/BISECT_NAMES: No such file or directory
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git #
>> root@amit:/usr/src/linux-git # git bisect bad v2.6.22-git8
>> cat: .git/BISECT_NAMES: No such file or directory
>>
>> Thanks and Regards,
>>
>=20
> you seem to be missing a "git bisect start" from that sequence ... se=
e=20
> the man page for more details.
Yes indeed. Somehow the state was messed up due to different commands I=
=20
had tried. Now it works ok.
root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
root@amit:/usr/src/linux-git # git bisect bad v2.6.22-git8
Bisecting: 362 revisions left to test after this
[02b2318e07f98a7cdf7089a4457a8d62424aa824] Merge branch 'master' of=20
master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6
Thanks a lot for everyone for their help. _Much appreciated_!
Best Regards,
--=20
Amit Walambe
Design Engineer, Arcom Control Systems Ltd.
http://www.arcom.com
Tel: +44-(0)1223 411200 ext. 3204
Direct: +44-(0)1223 403465

_____________________________________________________________________
The message in this transmission is sent in confidence for the attentio=
n of the addressee only and should not be disclosed to any other party.=
 Unauthorised recipients are requested to preserve this confidentiality=
=2E Please advise the sender if the addressee is not resident at the re=
ceiving end.  Email to and from Arcom is automatically monitored for op=
erational and lawful business reasons.

This message has been virus scanned by MessageLabs.
