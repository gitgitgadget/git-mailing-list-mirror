From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: GSOC application: Network layer for libgit2
Date: Tue, 5 Apr 2011 00:20:59 +0200
Message-ID: <20110404222051.GB4529@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, libgit2@librelist.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:21:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6s8y-0002Yl-3g
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 00:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab1DDWVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 18:21:03 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42632 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021Ab1DDWVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 18:21:01 -0400
Received: from centaur.lab.cmartin.tk (brln-4d0c31e8.pool.mediaWays.net [77.12.49.232])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 66FA546124;
	Tue,  5 Apr 2011 00:20:49 +0200 (CEST)
Received: (nullmailer pid 5290 invoked by uid 1000);
	Mon, 04 Apr 2011 22:20:59 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	git@vger.kernel.org, libgit2@librelist.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170843>

Hi all,

 I'd like to take part in this year's GSOC adding a/the network layer
to libgit2. I already have some experience with git and libgit2. This
message is mostly in order to get some feedback to the timeline and
goals. I'll send a formal application in a day or two.

 Not studying in the US, I don't have free time that early, so I
expect most of the actual hard coding will be done after the
midterm. By then I do want to have most of the thinking done.

 From reading the documentation, I assume I'll have to write
pack-objects using libgit2, or rather add that support to it in the
library and then write {upload,receive}-pack first mostly as a client
of the library in order to include it in a more library-friendly form
once it works.

 My goal for this project would be to add the object packing code to
libgit2 and, if we want to have pushing and fetching inside the
library, to add this functionality to the library as well. Otherwise,
the client would be useful for later conversion of git.git to libgit2
or as an example for others.

 As for success, I'd rate a success to have the library code merged or
ready to merge both for object packing and network protocol, if it
does go into the library.

 I expect the timeline to be:

 - Pre-coding time: get to know the packed object format better, read
   the documentation and code for it in git.git.

- Up to midterm: due to the difference in lecture times between the US
   and Germany, I won't be able to devote all my time to coding, but I
   expect/hope to have code using the network protocol working by this
   time, as well as a design for object packing (the code has to be
   worthy of a library, so object caches would have to be invalidated
   and other side-effects which come from not being allowed to assume
   the code runs once and then dies).

- Up to the end: get object packing working, thread safety issues,
  reviews, and other misc. library code stuff, including getting
  push/fetch into the library if necessary.

 I've put the network side of things earlier because I expect it to be
'lighter' but I'd be interested to know if people think the order
should be reversed.

 As for previous involvement, I've sent a few small patches to git.git
and larger ones to libgit2. I'm currently writing its config file
support during an internship. In the melange application, I'll post
some gmane links to threads and to my libgit2 fork on gibhub.

 Thanks for your time if you've read this far,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI
