From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Conceptual Question for git usage ...
Date: Wed, 22 Jan 2014 10:03:58 -0500
Message-ID: <CCFA1C8D-F0E3-43D9-87FD-B62807DB7EA8@kellerfarm.com>
References: <CABQ4iYjfa1X0KkMm=VtoRt2j65E1cce7TyY_PU8WFr8DPQEtjw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 16:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5zLp-0005LU-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbaAVPEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 10:04:16 -0500
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:57507 "EHLO
	atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755212AbaAVPEN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 10:04:13 -0500
Received: from atl4mhob13.myregisteredsite.com (atl4mhob13.myregisteredsite.com [209.17.115.51])
	by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s0MF4CDn016944
	for <git@vger.kernel.org>; Wed, 22 Jan 2014 10:04:12 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
	by atl4mhob13.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s0MF3xGg014391
	for <git@vger.kernel.org>; Wed, 22 Jan 2014 10:03:59 -0500
Received: (qmail 12400 invoked by uid 0); 22 Jan 2014 15:03:59 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 22 Jan 2014 15:03:59 -0000
In-Reply-To: <CABQ4iYjfa1X0KkMm=VtoRt2j65E1cce7TyY_PU8WFr8DPQEtjw@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240828>

On Jan 22, 2014, at 9:20 AM, John McIntyre <joh98.mac@gmail.com> wrote:

> =85
>=20
> So basically, what I'd like to do is this.  I want to write code,
> write blg posts, write essays for university, whatever.  And I want t=
o
> use git to maintain revisions, but where do I store them?  Do I make
> the Mac my hub?  I have a git client on there.  Do I make the server
> my 'hub'?  If I make the server the 'hub', then won't rsync back-ups
> from the Mac to the server wipe them out?
>=20
> =85

Git's degree of flexibility in what is considered "the server" is valua=
ble here.  I advise that you simply try a configuration, and see how it=
 works.  It's easy to change where origin points later.

With that said, like you, I have a small ad-hoc setup of automated rsyn=
c backups between my various computers and servers, and I have found so=
me characteristics useful:

* I have rsync saving backups into dedicated backup folders on the remo=
te machines.  This eliminates ambiguity of what to back up (server A wo=
n't blow away server B's Documents folder, for example).

* Using a publicly accessible server has been useful.  I set up port fo=
rwarding to the machine, and set up a domain name pointing to the serve=
r.  In general, when I have Internet access, I can access the server th=
at contains my repositories.  I always use the same domain name, even i=
f I'm in the same room as the server.

Hope that helps,
Andrew
