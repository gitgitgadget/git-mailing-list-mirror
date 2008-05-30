From: "Alf Clement" <alf.clement@gmail.com>
Subject: gitk / diffcore-rename error message
Date: Fri, 30 May 2008 17:54:42 +0200
Message-ID: <556d90580805300854k27e0ea9ev3aabcfb28f131228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 17:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K26x9-0004TJ-Hj
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbYE3Pyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYE3Pyr
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:54:47 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:5125 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYE3Pyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 11:54:47 -0400
Received: by ik-out-1112.google.com with SMTP id c28so73999ika.5
        for <git@vger.kernel.org>; Fri, 30 May 2008 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jnNYUIFpJAkzyWzUboLc6VHCrVZiVb6UmZIZpILS/X0=;
        b=NhCJ90kN+bt1CvxkYFXD/XQD9tjWvyJs43jDyFfcDl8X2dt2+tCSLdiLfZaAqM1ogOIf0PORjMFnlNwZeUN9OO7cL5whLWDQllzyz02XPLbEJVBog0bRz0BWLTYYaNKYHPV+d49ChnpOH+p0bNTQ4x4B1i2GY76HoRAo8EWV398=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=neC0PyzR8AnWpD/OvAid3Mr5E1L7JEFe2iIG1pd+DH1vCSGLg/Ddq8igunGO70MFL8/6NABfQwYC8GKYLW/nsNWOnHLNujz12Hh3xjmn88jM1exwIT4zfhp3i31DB5MWwSA5bJ9bbUSV+cPFomrlc5PjdfLzFqBUx51C4ZrkQys=
Received: by 10.78.199.8 with SMTP id w8mr578231huf.30.1212162882896;
        Fri, 30 May 2008 08:54:42 -0700 (PDT)
Received: by 10.78.144.18 with HTTP; Fri, 30 May 2008 08:54:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83311>

Hi all,

I was trying to create a git repository in the following way (while
importing different releases from clearcase tree)

git init .
tar xzf version1..
git add .
git commit -a -m"Version1"
rm -rf tree
tar xzf version2
git add .
git commit -a -m"Version2"
... and so on for next next verison.

Now I get the following error while using gitk:
warning: too many files, skipping inexact rename detection
warning: too many files, skipping inexact rename detection
    while executing
"close $bdf"
    (procedure "getblobdiffline" line
...

which seems to come out of diffcore-rename.c

Can I ignore it? Is it harmful?

Thanks,
Alf
