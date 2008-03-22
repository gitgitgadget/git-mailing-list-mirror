From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git add --interactive: Autoselect single patch file
Date: Sat, 22 Mar 2008 16:41:35 +0100
Message-ID: <6AA0A7C2-488B-4440-A797-B1B87361801D@wincent.com>
References: <1206148960-29563-1-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803221549570.4124@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org, normalperson@yhbt.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 16:43:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd5s5-0003JS-Di
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 16:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYCVPmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYCVPmK
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 11:42:10 -0400
Received: from wincent.com ([72.3.236.74]:35486 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbYCVPmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 11:42:09 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2MFfavY013917;
	Sat, 22 Mar 2008 10:41:37 -0500
In-Reply-To: <alpine.LSU.1.00.0803221549570.4124@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77817>

El 22/3/2008, a las 15:51, Johannes Schindelin escribi=F3:

> Hi,
>
> On Sat, 22 Mar 2008, J=F6rg Sommer wrote:
>
>> If there's only one file to patch, select it automaticly and don't
>> bother the user. In the case he didn't want do patching, he can say =
=20
>> 'd'
>> at the patch prompt.
>
> It also triggers when you specified a single path:
>
> 	$ git add -i that-file.c
>
> I like it.
>
> However, if I already specify (a) file(s), could add -i not go to the
> [p]atch option right away?

That's what I originally wanted and I sent a couple of patches in to =20
that effect some months back. But it was argued that it is useful for =20
passed-in filepatterns to limit the scope of other operations in "git =20
add -i", not just the [p] subcommand, and that in turn lead to the "--=20
patch" option being implemented. I can try to dig up the message-ids =20
in question if you are interested.

Still, I use the [p] subcommand so often (and almost never use any of =20
the other subcommands offered by "git add -i") that I have "git patch" =
=20
set up as an alias for "git add --patch".

Cheers,
Wincent
