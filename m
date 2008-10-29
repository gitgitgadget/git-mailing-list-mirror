From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 20:44:58 +0100
Message-ID: <C03E504F-50E8-4887-80CE-2C6B2F824B9E@wincent.com>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de> <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com> <alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de> <E4E10B61-FA92-417C-9046-F9DE3B48C2A6@wincent.com> <alpine.DEB.1.00.0810292022480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:46:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvH0F-0007S8-QU
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 20:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbYJ2Tpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYJ2Tpi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 15:45:38 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:60551 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYJ2Tph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2008 15:45:37 -0400
Received: from cuzco.lan (225.pool85-53-3.dynamic.orange.es [85.53.3.225])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m9TJiwO8027220
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 29 Oct 2008 15:45:01 -0400
In-Reply-To: <alpine.DEB.1.00.0810292022480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99397>

El 29/10/2008, a las 20:23, Johannes Schindelin escribi=F3:

> Hi,
>
> On Wed, 29 Oct 2008, Wincent Colaiuta wrote:
>
>> El 29/10/2008, a las 18:03, Johannes Schindelin escribi=F3:
>>
>>> On Wed, 29 Oct 2008, Wincent Colaiuta wrote:
>>>
>>>> Git already has too many commands. Adding more is not going to =20
>>>> clear
>>>> up newbie confusion, and will only waste time because people will
>>>> complain about it and ask why there is this kind of duplication.
>>>
>>> I completely disagree.  If the existing set of commands causes
>>> confusion, we need to deprecate those parts and add new commands.
>>> Even if we have a ton of commands already.
>>
>> The confusion isn't at the command level; it's at the switch/option
>> level. The solution isn't to add a new command.
>
> Seems that at leat one guy who does Git training disagrees with you, =
=20
> _in
> addition_ to me.

That's what I call a "zero value" addition to the thread, seeing as =20
anyone reading the thread _already_ knows the opinions of the =20
participants who've posted.

Adding a separate command to an already overwhelming command set in =20
order to address confusion about options to "git diff" is a case of =20
"duct-tape UI design".

Wincent
