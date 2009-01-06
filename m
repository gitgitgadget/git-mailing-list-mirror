From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Migration problems from SVN
Date: Tue, 6 Jan 2009 13:09:31 +0100
Message-ID: <c09652430901060409p23d2737ck6e41b3f8f1eaf01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 13:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKAlt-0004a2-U7
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 13:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbZAFMJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 07:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbZAFMJe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 07:09:34 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:33920 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbZAFMJd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 07:09:33 -0500
Received: by bwz14 with SMTP id 14so23906958bwz.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=PTo+3rBDi3hBLlHfRH/MdD6j6GR28hSYkWTNQLZphwQ=;
        b=dd0FI/niEOCtJSehIngHuV8YkeCG6gtFoR+hWTGY85X3S9HHroNsKzdysr8kVoYZzM
         EGxermgry7W9ppbZf9QPjT8E3mLQ4U3HZnKEE3Hk/CORs9tuABOfHk+iLg1tKe1N7053
         4nbWblTA3/0U/H3ZsXbypjJe6Z5C27TlSQ5Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=pwbjC09luhBcWAf/5HvWXhXl3bdLId/ooYl9a9pbjLSji+vAFimEm1EHHrzLPN/kwi
         WbwQlfa2fUOS09k3DRy0t7m2N81UH1q4mBcolj+E3aw/WGu6w3880t//YOpvqo4L7ZB9
         NboCF86mhKiQYFVv6xBzYy3uwXXJ2vbAYnRAg=
Received: by 10.223.104.140 with SMTP id p12mr15402351fao.7.1231243771636;
        Tue, 06 Jan 2009 04:09:31 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Tue, 6 Jan 2009 04:09:31 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 4bbf46999b289130
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104680>

Hi all,

I'm trying to migrate from svn to git, but has run into a snag for whic=
h
I haven't found any good solutions on the web:

If I early on and accidentally commit a *large* binary object, how do I=
 get rid
of it from .git again?

svn copes with this reasonably well as the binary object will no longer=
 be
downloaded if it is deleted. Also when converting old SVN repositories,
such objects needs to be pruned.  Somewhat related I also need to enume=
rate
the offending large binary objects that I should get rid of.

It is unpractical to live by the rule that no big objects should ever
be committed
accidentally given the number of people involved and the walks of life =
they come
from.... So there really needs to be some way to deal with this once th=
e
damage has been done.


--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
