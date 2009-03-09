From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Mon, 09 Mar 2009 20:34:03 +0100
Message-ID: <49B56F2B.1080402@lsrfire.ath.cx>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com> <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com> <5ACAF49A-84B5-4F55-A8B8-0FC711708810@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 20:36:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LglGd-0002UC-Eu
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 20:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbZCITeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 15:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZCITeP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 15:34:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:44694 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZCITeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 15:34:14 -0400
Received: from [10.0.1.101] (p57B7F24E.dip.t-dialin.net [87.183.242.78])
	by india601.server4you.de (Postfix) with ESMTPSA id 9DE572F8063;
	Mon,  9 Mar 2009 20:34:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <5ACAF49A-84B5-4F55-A8B8-0FC711708810@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112733>

Brian Gernhardt schrieb:
>=20
> On Mar 8, 2009, at 10:22 PM, Jay Soffian wrote:
>=20
>> On Sun, Mar 8, 2009 at 9:15 PM, Brian Gernhardt
>> <benji@silverinsanity.com> wrote:
>>> On OS X the printf specifier "%.0s" outputs the entire string inste=
ad
>>> of 0 characters as POSIX states.
>>
>> Does not reproduce for me:
>=20
> Nor for me, as I noted on the other thread...  And looking again, I w=
as
> reading the man page for printf(1), not printf(3).  Ouch.  *grumble,
> grumble*  I'm crawling back under my rock now.

Sorry for introducing a Linuxism. :-/  Thanks for testing and reporting
and for fixing the bug.

Ren=E9
