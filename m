From: Florian Weimer <fweimer@bfk.de>
Subject: Re: git annotate runs out of memory
Date: Wed, 12 Dec 2007 11:36:01 +0100
Message-ID: <82bq8wi4j2.fsf@mid.bfk.de>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 11:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2OxM-0006tR-5T
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437AbXLLKgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 05:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758558AbXLLKgG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:36:06 -0500
Received: from mx01.bfk.de ([193.227.124.2]:34908 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758437AbXLLKgF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 05:36:05 -0500
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1J2Owc-0006GD-1e; Wed, 12 Dec 2007 11:36:02 +0100
Received: from fweimer by bfk.de with local id 1J2Owb-0007HY-W7; Wed, 12 Dec 2007 11:36:02 +0100
In-Reply-To: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> (Daniel Berlin's message of "Tue, 11 Dec 2007 12:33:56 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68034>

* Daniel Berlin:

> On the gcc repository (which is now a 234 meg pack for me), git
> annotate ChangeLog takes > 800 meg of memory (I stopped it at about
> 1.6 gig, since it started swapping my machine).
> I assume it will run out of memory.  I stopped it after 2 minutes.

A less unwieldy repository that shows the same problem is:

  svn://svn.debian.org/secure-testing/

It's annotating the data/CVE/list file that uses tons of memory.  I
guess you don't need to clone the full history to exhibit the problem.

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
