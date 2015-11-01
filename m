From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Sat, 31 Oct 2015 22:31:14 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA0B@mail.accesssoftek.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <5631AB75.5030800@gmail.com>,<alpine.DEB.1.00.1510301941170.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 06:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZslGP-0003pt-2h
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 06:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbbKAFcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 01:32:36 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:27752 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbbKAFcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 01:32:35 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Sat, 31 Oct 2015 22:32:34 -0700
Thread-Topic: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Thread-Index: AdETQ2+yLejNb8qVTs+PsFtMyGZKwQBIxaj6
In-Reply-To: <alpine.DEB.1.00.1510301941170.31610@s15462909.onlinehome-server.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280606>



> >   +if test -n "$TEST_GDB_GIT"
> > +then
> > +   exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> Maybe we could make $TEST_GDB_GIT not just a boolean flag? It would be useful
> to contain "gdb" executable name. It would allow to set path to GDB when it
> is not in $PATH, set different debuggers (for example, I usually use cgdb),
> or even set it to /path/to/gdb_wrapper.sh which could contain different gdb
> options and tunings.

> Sure, as long as TEST_GDB_GIT=1 still works. Why don't you make an add-on
> patch and submit it?

Hello Johannes,

Sure, I will prepare the patch as soon as this one is included in master.
--
Victor
