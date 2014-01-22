From: John McIntyre <joh98.mac@gmail.com>
Subject: Conceptual Question for git usage ...
Date: Wed, 22 Jan 2014 14:20:41 +0000
Message-ID: <CABQ4iYjfa1X0KkMm=VtoRt2j65E1cce7TyY_PU8WFr8DPQEtjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 15:20:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5yff-0005BJ-19
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 15:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbaAVOUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 09:20:43 -0500
Received: from mail-we0-f193.google.com ([74.125.82.193]:34207 "EHLO
	mail-we0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbaAVOUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 09:20:42 -0500
Received: by mail-we0-f193.google.com with SMTP id u57so99506wes.8
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 06:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=549MKKH3yNXrDm7XuD5oWjHAO6cgb2rR3AXwBAAweIg=;
        b=0+xsLAYxrOfPWPEITnaJwAjpMqb5bExMi0QUVJloZ4AWHbEcP8rrvBsDNZzl8XLRez
         foPKaSPkEhvXvotFbou4wrOPbQ4uW6E3A+faKNyMM7XAAsvfXnV5gZk7QFZ9Jz65V/6B
         4+qp2c7tL1ilpRvv3YwYfPtynm1eo92waEpk0udfFtNjsXSgFVU7JBIhOcvuoA86iH/L
         WNgMypUTKq3ebrVLVrgcVu/q9Ll4O/B5IapA1wFj/XF5yG3r8DW4CNR2LiDemqcgK64x
         U8Au3Pv3ZIoZEXZVpgrugUvcR+jK4hRokaXedGv/MOLFIUoKa9UPpVV9Junk0tZq0R87
         dvkg==
X-Received: by 10.194.93.193 with SMTP id cw1mr2097100wjb.72.1390400441358;
 Wed, 22 Jan 2014 06:20:41 -0800 (PST)
Received: by 10.180.24.198 with HTTP; Wed, 22 Jan 2014 06:20:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240825>

Hi,
I want to install git onto my home network - in fact, truth be told,
it's already on my server, but I have some questions as to its
implementation.

First of all, my network.  At the 'centre' (practically, if not
logically) is my Mac.  I consider this my 'central repository' of
everything.  Mail, documents, blog posts etc.  Everything is on this
machine.  The Mac is backed up i) to an external drive with Time
Machine, ii) to my Linux server (more on that below) via rsync and
iii) to my personal Linux laptop which sits on 27/7 at work via rsync.

My server.  This is a Linux server runing CentOS 6.5, and working as a
webserver, fileserver, MySQL server, mail server (primary MX), and is
the 'public face' of my domain name.

Then there are two other Linux servers - one running MySQL
replication, and the other as a publically-accessible 'sandbox' on
which people whom I train can connect via a specific port, and mess
around, with no possibility that what they do will damage other parts
of the LAN.

So basically, what I'd like to do is this.  I want to write code,
write blg posts, write essays for university, whatever.  And I want to
use git to maintain revisions, but where do I store them?  Do I make
the Mac my hub?  I have a git client on there.  Do I make the server
my 'hub'?  If I make the server the 'hub', then won't rsync back-ups
from the Mac to the server wipe them out?

I confess that my preference would be to use the server, because I
occasionally bring the Linux laptop home from the office and use that,
and don't want to connect it to the Mac.

Anyway, basically .. that's it.  Any ideas would be appreciated.  Thanks.
