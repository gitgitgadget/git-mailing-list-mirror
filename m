From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Windows binaries for qgit 2.0
Date: Sat, 15 Dec 2007 16:02:18 +0100
Message-ID: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 16:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3YXN-0001jZ-6U
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 16:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbXLOPCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 10:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbXLOPCU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 10:02:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:46725 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXLOPCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 10:02:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1284988rvb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ugcjEl7KOPkSniOkWyqdLIhB6A7ApgiAb57XH+0dndA=;
        b=ouhvTCrIWYTQV8D4vb+vY3VfVtDVB0gBzTHcEWciumN+0QjrFNV4R3VP54jUZCsJa+opKI9fAwY/KKbPpy7gAf1SDEor67kRjkDlraIIM7vJXTZXigXfjhE+b9kE2MNbrllu4+L8z4m4XcUIkto6yUHi6O7DKDvZtTghpeiA9ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UVMiN0tO3wDyc0Uh1uWAQX/uxymvjS5Jklb9oX8hp1BSOcfLCYymPBjuDcJ5S13YthBkknVI2RBihfwJgalQbpFWJfA/ZJc1wZ9SHRC4qASuc49qdBrpekWz78QrXyKoEzw+EeBJ5yV6UTCDP38RUAum+Cwg8G3Fx7zuRElSQkI=
Received: by 10.140.82.38 with SMTP id f38mr127788rvb.27.1197730938885;
        Sat, 15 Dec 2007 07:02:18 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 15 Dec 2007 07:02:18 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68390>

Due to a feature request on sourceforge qgit account:

http://sourceforge.net/tracker/index.php?func=detail&aid=1759403&group_id=139897&atid=744830

I have cooked and uploaded a qgit.exe file with Qt4.3.3 statically
linked in so to let Windows users that just want to give a shot to
qgit the possibility to try it easily.

Normally I use debug shared Qt libraries for development, so after
some effort I finally managed to build the static ones and finally to
build qgit.exe

Problem is that _this_ qgit.exe shows strange misbehaviour like 20X
slower then the one I normally build for development,  there is also
some strange artifacts with file history graph.

I have a clue that is due to static Qt + mingw 3.4 problems, I have
read something on it somewhere, but I would like to ask if someone has
experienced the same problems when running qgit2.0 under Windows.

BTW if someone is interested, in the sourceforge thread above there is
the link to download this zipped file, testing is very easy and quick,
just extract files where git.exe is and start qgit.exe...

Thanks for any help
Marco
