From: Tim Visher <tim.visher@gmail.com>
Subject: Manually edit the commit a submodule is pointing to?
Date: Mon, 12 Apr 2010 10:31:57 -0400
Message-ID: <i2jc115fd3c1004120731g950c127fn44603df222de8273@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:32:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Kgd-0004E4-Mr
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab0DLOcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 10:32:21 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:46900 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0DLOcV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 10:32:21 -0400
Received: by gxk9 with SMTP id 9so3414379gxk.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=BEkCt11y7DCDkg5AuvEGn69w/YZFYrEUVNM7yiBlYGE=;
        b=PQ8oTD9U2MzKx7Yu72YBoQnKMvo1DXCRhQXdP/dKqHftZ8mW143NbdtgaRpgmBULoU
         eLpy/fdBumOiDK/qXuxnGUs68IZnhOuVbpBP6cGubtHDp6TSKW491xG8/QolnQWAJ+UL
         8SGoNfGyRzaYjLT+1vuSI6oXk5Kgy0uYoYBuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=xTqg2t8MOHwn7bhE2NFFKbdcLDpB1kwHDcxjSPsW/4CAaRWhOuFBzlpIsESU3fKaPd
         FY1BGmcijdqf1c2CR2ias8bSdgTXA6Lh7FSxRt3WzFg6csrtnV2SRS2ljnyCdDpzCUDu
         Q5LSBRYVSODfvxR+664NOPVZAXuycgn3MHB8E=
Received: by 10.100.109.4 with HTTP; Mon, 12 Apr 2010 07:31:57 -0700 (PDT)
Received: by 10.101.209.21 with SMTP id l21mr6997347anq.114.1271082737899; 
	Mon, 12 Apr 2010 07:32:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144735>

Hello Everyone,

I recently began to use submodules to manage large packages that I
depend on from my .emacs file and I've run into an issue where I made
a change locally and didn't push out to the master repo.  I'm now not
at that box and I'm trying to checkout the repo fresh.

The problem is that the master repo doesn't have the commit specified=E2=
=80=A6
Where?  So I can't edit the submodule commit and then readd it because
I don't have the submodule to edit since I can't check it out.  Is it
possible to just manually munge the commit that the submodule is
pointing to?

Thanks!

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
