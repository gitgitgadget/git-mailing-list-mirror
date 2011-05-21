From: fREW Schmidt <frioux@gmail.com>
Subject: git-svn feature idea
Date: Fri, 20 May 2011 22:41:39 -0500
Message-ID: <BANLkTi=OHfHaHE86z8Ufj44J+Oxu8ec5ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 05:42:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNd4v-0002JR-N3
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 05:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab1EUDmB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 23:42:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45946 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1EUDmA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 23:42:00 -0400
Received: by gwaa18 with SMTP id a18so1540662gwa.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=FWOlISPK2jP2/mD3OqWBKYvOX8fXLC9Jr1TvtQ2Vc0k=;
        b=srJQhT8zK5Oml0np2mNDuesIDcTK6A+zU/B4STj1dhFPtOfBVIMunxxoFUfr7qNCPt
         C/BJwOURQAsC8HcUS0PqViwIAZ/oweRLUqbTCBsLj03egzFjfHdasvIR2AuLoZrZgf4l
         1UPKMfKDXfK5XqinxEe+I4hFxZ5p6Z+OZX/5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=F0tFVdUgADKx4VMz7uJBQ0rg/KYmFOJkwRUHuQJHAZhjv60PFfSOqgDSM/B0zmbQH1
         Vt7YMr4kxX9Q1pNV9xhxojENpJH1ZrxjaKO3x5cEfDiL5XRluvKwCmPxILAfHpKbeH52
         2+YhOo5PS2lQT+Uo5ijn9hnzu4t/ywxJmOe3E=
Received: by 10.150.131.3 with SMTP id e3mr1103812ybd.236.1305949319065; Fri,
 20 May 2011 20:41:59 -0700 (PDT)
Received: by 10.150.230.4 with HTTP; Fri, 20 May 2011 20:41:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174089>

Hey guys,
Lately I've been doing a lot of permanent subversion to git
conversions, and I keep running into braindead repo structures that
give me pain to export.=A0 The main one is this:

trying to check out MyProject:

trunk/MyProject
trunk/OtherProject
tags/MyProject-1.0
tags/MyProject-1.1
tags/OtherProject-1.0

So you see I can't just specify to git-svn that tags is the tags dir.
I know a workaround (check out each tag separately and then use git
fetch to put them all in the same repo) but that's really inefficient.

So really what would be great would be to be able to do the following:

git svn clone $repo --trunk=3Dtrunk/MyProject --tag=3Dtags/MyProject-1.=
0
(and --branch would be great too)

Anyway, I am fairly well versed with perl, so I could try my hand at
writing such a feature, but I wouldn't really know where to start or
if anyone other than me is even interested in something this.

Thoughts?

--
fREW Schmidt
http://blog.afoolishmanifesto.com
