From: layer <layer@known.net>
Subject: Re: How can I tell if a tag has been pushed, or not?
Date: Fri, 10 Jul 2009 13:02:23 -0700
Message-ID: <16198.1247256143@relay.known.net>
References: <14563.1247247807@relay.known.net> <81b0412b0907101228t2cc55aa6g21d2a11ec9caa1c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPMIh-0003YQ-Oj
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 22:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZGJUCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 16:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbZGJUCY
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 16:02:24 -0400
Received: from relay.known.net ([67.121.255.169]:53043 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbZGJUCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 16:02:24 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.19) id 000000046949; Fri, 10 Jul 2009 13:02:23 -0700
In-reply-to: <81b0412b0907101228t2cc55aa6g21d2a11ec9caa1c1@mail.gmail.com>
Comments: In-reply-to Alex Riesen <raa.lkml@gmail.com>
   message dated "Fri, 10 Jul 2009 21:28:10 +0200."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123079>

Alex Riesen <raa.lkml@gmail.com> wrote:

>> On Fri, Jul 10, 2009 at 19:43, layer<layer@known.net> wrote:
>> > Here's the problem:
>> >
>> > I expect that users, in their own private repos, will from time to
>> > time create tags that should not be pushed. =A0Sometimes, tags tha=
t
>> > should be pushed will be created.
>> >
>> > I could require that the "public" tags follow a specific conventio=
n
>> > (start with "release", or something). =A0Then, the scripts all my
>> > developers use could use that and push only certain tags. =A0Howev=
er,
>> > over time there could be a large number of them. =A0It seems undes=
irable
>> > to push each tag each time a push is done. =A0So, how can I tell i=
f a
>> > tag has already been pushed? =A0Is there a way?
>>=20
>> git push does not push any tags by default. You either have to
>> specify them explicitly or add --tags (all tags). Maybe that is enou=
gh?

No, I already knew about that.

>> Otherwise, there is always git ls-remote 'tags/*'...

This is what I needed.  Thanks.
