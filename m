From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: How to "git add ." when some files are not accessible (permission
 denied)?
Date: Mon, 03 Mar 2008 21:32:17 +0100
Message-ID: <47CC6051.1090308@dirk.my1.cc>
References: <47C95E34.1050306@dirk.my1.cc> <20080302011900.GC22843@coredump.intra.peff.net> <47CC4EAC.1050905@dirk.my1.cc> <7vmypfh8s4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:33:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWHLF-0002Py-LN
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 21:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbYCCUcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 15:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbYCCUcT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 15:32:19 -0500
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:45796 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbYCCUcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 15:32:19 -0500
Received: from [84.176.72.199] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JWHKb-0006CC-9k
	for git@vger.kernel.org; Mon, 03 Mar 2008 21:32:17 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <7vmypfh8s4.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75983>

Junio C Hamano schrieb:
> Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:
>
>  =20
>> This way prepared, I used "git ls-files -o | xargs git add -v" until
>> most of my files were added.
>> ...
>> Caveat: filenames containing blanks are not handled properly as they
>> are not surrounded by quotes. "git add" thinks of them as two or mor=
e
>> files and fails.
>>    =20
>
> Perhaps "git ls-files -z -o | git update-index --add --stdin"
>
>  =20
That's exactly what I meant when I wrote "Git almost always has a=20
solution for 'do what I mean'".
It is, however, sometimes hard to find, but the solution is always ther=
e.
Its such a great piece of software. Congratulations to you all.
