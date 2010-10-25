From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: git-gui: 'Unhandled 2 way diff marker:' for typechanged path
Date: Mon, 25 Oct 2010 14:59:00 +0200
Message-ID: <AANLkTi=dA+mj1KDpAgGAtg1S5Gt5wXAJ4zLd-tLob=DH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Oct 25 14:59:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAMdp-0000De-MW
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 14:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab0JYM7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 08:59:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38582 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab0JYM7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 08:59:01 -0400
Received: by yxn35 with SMTP id 35so1981601yxn.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=plAZkVdcnV1EMDTvY6+u/6U8W9po6XY1r/Gfr4Wi9OI=;
        b=Ns3cJQqo7l++yFmiVaTbvtgs/arSxohU5/Jc0/Ljij+DXzZhf5FNuY5guNuVaQM/Yy
         ewMxRlV3QE7jhI0DW2iGpdEXGtx2LBj5KO+lXByDvfxr3PBftIWBkbm1hBZYk56RwYw6
         Iub3Gpdon9su+MAevLOop7E4VOf/hnQzSCl0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=o+X4HLiLNhlUQ5rzZRYgeFwVDpFPEWVBijA1Ya25E8TzMGRMfeDSB2wIN+fXyHEPD5
         Z2W4k0eED3tZ4/HuRzcme1yGzXahtRH6fpv9Z7249MPRcZlUYxk4nutroMW+6vA5Da4J
         jpNe+TLC0TYw1rQqhSPcBAHziDcKlb2kX0Sqk=
Received: by 10.42.104.210 with SMTP id s18mr3688520ico.471.1288011540759;
 Mon, 25 Oct 2010 05:59:00 -0700 (PDT)
Received: by 10.42.114.15 with HTTP; Mon, 25 Oct 2010 05:59:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159948>

Hi,

I get this error from git gui after I changed a symlink to a file:

error: Unhandled 2 way diff marker: {d}

To reproduce:

$ git init
$ ln -s bar foo
$ git add foo
$ git commit -m "add foo link"
$ rm foo
$ echo bar >foo
$ git gui
error: Unhandled 2 way diff marker: {d}

I may have a look into this by my self in the long term, but maybe
someone is faster than me.

Regards,
Bert
