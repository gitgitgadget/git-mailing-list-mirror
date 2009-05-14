From: layer <layer@known.net>
Subject: Re: how to update origin/<branch> after a push to origin <branch>?
Date: Wed, 13 May 2009 22:01:56 -0700
Message-ID: <19997.1242277316@relay.known.net>
References: <19640.1242276135@relay.known.net> <32541b130905132158s44cc5b19n974901c05cf025b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 07:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4T51-0001NU-Pv
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbZENFB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 01:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbZENFBz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:01:55 -0400
Received: from relay.known.net ([67.121.255.169]:48621 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbZENFBz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 01:01:55 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.19) id 000000039334; Wed, 13 May 2009 22:01:56 -0700
In-reply-to: <32541b130905132158s44cc5b19n974901c05cf025b2@mail.gmail.com>
Comments: In-reply-to Avery Pennarun <apenwarr@gmail.com>
   message dated "Thu, 14 May 2009 00:58:09 -0400."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119135>

Avery Pennarun <apenwarr@gmail.com> wrote:

>> On Thu, May 14, 2009 at 12:42 AM, layer <layer@known.net> wrote:
>> > after the push, I still see the names of the files I pushed becaus=
e I
>> > haven't updated origin/master yet, with a fetch. =A0Of course, a "=
git
>> > pull" would do it, but I don't want to do that, because I might be
>> > using something other than `origin' and I don't want anything but =
the
>> > single branch.
>> >
>> > So, I naively thought that
>> >
>> > =A0git fetch origin master
>> >
>> > would do the trick, but after that command the git diff above stil=
l
>> > shows the same files.
>>=20
>> Short answer:
>>=20
>>    git fetch origin

I'm pretty sure I tried that.  I'll certainly verify it once I figure
out how to unwedge my repo.

>> However, 'git push origin master' should update origin/master
>> automatically, at least in relatively recent git versions.  It's
>> rather weird if that didn't happen.

That's what I thought.  Using git version 1.6.1.3 (client and server
are the same machine).
