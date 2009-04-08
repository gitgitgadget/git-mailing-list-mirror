From: layer <layer@known.net>
Subject: Re: need help with git show :1:...
Date: Wed, 08 Apr 2009 11:10:09 -0700
Message-ID: <7357.1239214209@relay.known.net>
References: <6838.1239212486@relay.known.net> <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com> <7199.1239213762@relay.known.net> <51419b2c0904081107s7ba08367w671d5b494095402@mail.gmail.com>
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcFU-0004gm-7H
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614AbZDHSKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbZDHSKL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:10:11 -0400
Received: from relay.known.net ([67.121.255.169]:59990 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755206AbZDHSKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:10:10 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000034341; Wed, 8 Apr 2009 11:10:09 -0700
In-reply-to: <51419b2c0904081107s7ba08367w671d5b494095402@mail.gmail.com>
Comments: In-reply-to Elijah Newren <newren@gmail.com>
   message dated "Wed, 08 Apr 2009 12:07:00 -0600."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116103>

Elijah Newren <newren@gmail.com> wrote:

>> Hi,
>> 
>> On Wed, Apr 8, 2009 at 12:02 PM, layer <layer@known.net> wrote:
>> > Elijah Newren <newren@gmail.com> wrote:
>> >>> Does the file have conflicts?  Try
>> >>> git ls-files -s src/c/sock.c
>> >
>> > Yes, it did have conflicts.  I resolved the conflicts via editing, but
>> > want to look at the other versions before finalizing the edits.
>> >
>> > quadra% git ls-files -s src/c/sock.c
>> > 100644 ef6c9b94c678dc79760edfd15a0796b3726b76f6 0       src/c/sock.c
>> 
>> That suggests that the file is not unmerged, i.e. that there aren't
>> any remaining conflicts.  This explains why your commands wouldn't
>> work unless you used stage 0 instead of 1 or 2.  Now, why there
>> weren't conflicts when you thought there were?  I have no idea, unless
>> perhaps you did a stray git add src/c/sock.c.

It was several of weeks ago that I started this merge, and I remember
playing with git show then and it worki.  I might have overwriten
the file with one of the show's and done manual editing that way.  I
don't know if this makes a difference.

How can I redo the merge for just this file?  Is that possible?  I
think I'd definitely like to start over on *just this one file*.

Thanks.
