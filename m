From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: How to fetch missing pack
Date: Wed, 23 Apr 2008 20:55:03 +0000 (UTC)
Message-ID: <slrng0v8h8.ujv.joerg@alea.gnuu.de>
References: <slrng019fg.nd8.joerg@alea.gnuu.de>
 <20080413094131.GA9437@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 23:20:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JomOS-0001US-NL
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 23:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbYDWVT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2008 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbYDWVT6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 17:19:58 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2753 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYDWVT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 17:19:57 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 418B548802E; Wed, 23 Apr 2008 23:19:55 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1Jolzb-0004QE-SQ
	for git@vger.kernel.org; Wed, 23 Apr 2008 22:55:04 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1208984103 16931 192.168.0.5 (23 Apr 2008 20:55:03 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80261>

Hi Peter,

Peter Baumann <waste.manager@gmx.de> wrote:
> On Sat, Apr 12, 2008 at 12:07:12PM +0000, J=C3=B6rg Sommer wrote:
>> I'm missing a pack. My history of the git repository is broken:
>> % git show --pretty=3Draw e0fda6ab|head -7
>> commit e0fda6abd11c567b72f29ec0ee06c541404a9cb7
>> tree 77a7e4a849bbec646d88ae863f80ea3f519e26bd
>> parent 1ab58e8d6f728cdde0057f7ee88daab3a1c2d06f
>> author Wincent Colaiuta <win@wincent.com> 1196066088 +0100
>> committer Junio C Hamano <gitster@pobox.com> 1196109124 -0800
>>=20
>>     Fix typo in draft 1.5.4 release notes
>> % git log --pretty=3Doneline e0fda6ab | wc -l
>> 1
>> % git show e0fda6ab~1|cat
>> fatal: ambiguous argument 'e0fda6ab~1': unknown revision or path not=
 in the working tree.
>> Use '--' to separate paths from revisions
>>=20
>> Can I somehow tell git fetch to check the whole history for holes an=
d
>> fetch missing packs?
>>=20
>> Bye, J=C3=B6rg.
>
> Try using git fsck --full to check you repo. If you are missing some
> objects, you could just grab them from another valid repo which still=
 has
> them.

How can I exctract single objects from a pack?

> (e.g. copy all packs/objects from the other repo into yours and then =
do
> a git-repack -a -d -f)

This didn't work. I've cloned my git repo and copied the pack into
packs/objects without the .keep file and removed objects/info/packs.
After that I ran repack -a -d -f, but nothing changed. I still can't
access the parent of e0fda6ab. What else can I do?

Bye, J=C3=B6rg.
--=20
The social dynamics of the net are a direct consequence of the fact
that nobody has yet developed a Remote Strangulation Protocol.
            (Larry Wall)
