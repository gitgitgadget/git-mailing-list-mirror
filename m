From: =?UTF-8?B?SnVya28gR29zcG9kbmV0acSH?= <jurko.gospodnetic@docte.hr>
Subject: Re: What is 'git BRANCH'?
Date: Wed, 30 Jul 2008 00:43:35 +0200
Message-ID: <488F9D17.8020703@docte.hr>
References: <g6o4vi$rap$1@ger.gmane.org> <7vej5cba6z.fsf@gitster.siamese.dyndns.org> <DEBF93FC-BA8D-4513-B4EE-A8648DA1D591@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 00:44:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxvw-0007Mw-KY
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbYG2Wno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 18:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755723AbYG2Wnn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:43:43 -0400
Received: from main.gmane.org ([80.91.229.2]:32902 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291AbYG2Wnn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:43:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNxuu-0004ut-SA
	for git@vger.kernel.org; Tue, 29 Jul 2008 22:43:40 +0000
Received: from 87.252.137.70 ([87.252.137.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 22:43:40 +0000
Received: from jurko.gospodnetic by 87.252.137.70 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 22:43:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.137.70
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <DEBF93FC-BA8D-4513-B4EE-A8648DA1D591@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90698>

   Hi all.

> On Jul 29, 2008, at 3:24 PM, Junio C Hamano wrote:
>=20
>> Jurko Gospodneti=C4=87 <jurko.gospodnetic@docte.hr> writes:
>>
>>>  Hi.
>>>
>>>  I typed in "git BRANCH" by accident and got the error message:
>>> "fatal: cannot handle BRANCH internally".
>>>
>>>  What does that mean?
>>>
>>>  It is different from the usual "git: 'yada-yada' is not a
>>> git-command. See 'git --help'." message you get when you type in an
>>> incorrect command name.
>>
>> Just a guess; your git is installed on a case-challenged filesystem?

   Thank you all for explaining this, and yes - this was detected on=20
Windows with a NTFS drive set to case-insensitive.

   But, if something is running git-branch here... why does this=20
script/executable/whatever try to check the name it got called with? Wh=
y=20
does it not simply do its work no matter the name it got called with?

   If I'm asking something to obvious here - feel free to send me back=20
to read the code... :-)

   Best regards,
     Jurko Gospodneti=C4=87
