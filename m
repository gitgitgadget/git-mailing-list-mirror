From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 12:50:14 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>  <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org> <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com> <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLmN-0003ty-Uf
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab0CRTxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 15:53:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60566 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751421Ab0CRTxJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:53:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJr7VV017786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 12:53:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJr7BD012368;
	Thu, 18 Mar 2010 12:53:07 -0700
In-Reply-To: <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142509>



On Thu, 18 Mar 2010, Linus Torvalds wrote:
>=20
> (*) I'll give you one answer in the next email. But before you read t=
hat=20
> email, try to think about it, and see if you can guess at patterns.

Lookie here:

  [torvalds@i5 linux]$ git log --pretty=3Dfull | grep '^Commit: ' | sor=
t | uniq -c | sort -n | grep localdomain
      1 Commit: Jeff Garzik <jgarzik@localhost.localdomain>
      2 Commit: Dave Airlie <airlied@ppcg5.localdomain>
      3 Commit: James Bottomley <jejb@sparkweed.localdomain>
      3 Commit: James Morris <jmorris@localhost.localdomain>
      3 Commit: James Morris <jmorris@macbook.localdomain>
      4 Commit: James Bottomley <jejb@hobholes.localdomain>
     32 Commit: Thomas Graf <tgr@axs.localdomain>
    410 Commit: James Bottomley <jejb@mulgrave.localdomain>
  [torvalds@i5 linux]$ git log --pretty=3Dfull | grep '^Author: ' | sor=
t | uniq -c | sort -n | grep localdomain
      1 Author: Alex Deucher <alex@hp.localdomain>
      1 Author: Dave Airlie <airlied@ppcg5.localdomain>
      1 Author: Eduardo Habkost <ehabkost@Rawhide-64.localdomain>
      1 Author: Grzegorz Nosek <root@localdomain.pl>
      1 Author: Izik Eidus <izike@localhost.localdomain>
      1 Author: Jeff Garzik <jgarzik@localhost.localdomain>
      2 Author: Esti Kummer <stkumer@localhost.localdomain>
      2 Author: James Bottomley <jejb@mulgrave.localdomain>
      3 Author: Dave Airlie <airlied@optimus.localdomain>
      3 Author: James Bottomley <jejb@hobholes.localdomain>
      3 Author: James Bottomley <jejb@sparkweed.localdomain>
      4 Author: Cindy H Kao <evans@localhost.localdomain>
      4 Author: Kristian H=F8gsberg <krh@localhost.localdomain>

See? Mistakes happen. But look at what happens to the committer=20
information? Think about it. Really _think_ about it. There is absolute=
ly=20
zero _technical_ difference between the two fields. The only difference=
 is=20
that "git log" by default shows one, and not the other.

So as a human, which one do you think people care about and fix more=20
quickly?

And look at the numbers once more.

			Linus
