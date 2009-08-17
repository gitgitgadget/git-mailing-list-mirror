From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 22:17:42 +0200
Message-ID: <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8es-0006bl-3v
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbZHQURm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 16:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbZHQURm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:17:42 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:63703 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZHQURl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 16:17:41 -0400
Received: by fxm11 with SMTP id 11so2507080fxm.39
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:17:42 -0700 (PDT)
Received: by 10.223.145.21 with SMTP id b21mr896982fav.102.1250540262129; Mon, 
	17 Aug 2009 13:17:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126271>

On Mon, Aug 17, 2009 at 9:53 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:

> Of course, we could have a script that verifies that the .vcproj file=
s
> contain reference the appropriate files (which it would know about by
> being called from the Makefile and being passed the file names), mayb=
e
> even be able to edit the .vcproj file if it is missing some. =A0Shoul=
d not
> be too hard in Perl.

You'll need to special-case for Visual C++ 2010, which is different
and incompatible with previous versions. Hence my suggestion for
CMake: appropriate project files would be generated for the tool the
user chooses, be it VC++ 2005, VC++2010, gcc, Borland C++ or anything
else.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
