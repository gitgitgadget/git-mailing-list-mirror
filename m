From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:44:33 +0200
Message-ID: <3af572ac0908171544w36e98bd7g282660d54a37e872@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
	 <alpine.DEB.1.00.0908172255140.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171359o33f6ca70n599bdc27be74784a@mail.gmail.com>
	 <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAwU-0001E0-I5
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212AbZHQWod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757670AbZHQWod
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:44:33 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:39994 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbZHQWoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 18:44:32 -0400
Received: by bwz22 with SMTP id 22so2598439bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 15:44:33 -0700 (PDT)
Received: by 10.223.75.133 with SMTP id y5mr995294faj.18.1250549073245; Mon, 
	17 Aug 2009 15:44:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126310>

(Sorry for answering some parts now, I didn't realize this text was
there before)

> But here's a clue: you will probably _never_ succeed in getting a
> replacement of the make-based build in git.git by the maintainer. =A0=
Make is
> just too ubiquitous and well-established for that.

CMake does not replace Make, it runs a step before CMake


CMakeLists.txt
     |
     |
     |
     v
  Makefile/.vcproj/Eclipse/XCode project/NMakefile
     |
     |
     |
     v
 gcc/VC++/SunCC/whatever
     |
     |
     v
   ld/link.exe/whatever

(see page 10 in my slides for a nicer version :-) )

> If you succeed, I will ask you to do the same for Python, as you clea=
rly
> proved by that point that you are a magician.

I can't do any Python whatsoever, sorry :-)

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
