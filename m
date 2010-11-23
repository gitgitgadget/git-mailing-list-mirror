From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: disabling PROPFIND when using smart http
Date: Tue, 23 Nov 2010 21:10:43 +0530
Message-ID: <AANLkTikwqtPDDk6i0nMKJiXn5cc3DmTGYp0==daX96yd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 23 16:40:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKuzE-0002dz-E7
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 16:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab0KWPkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 10:40:46 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46224 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab0KWPkp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 10:40:45 -0500
Received: by eye27 with SMTP id 27so4724763eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=GnOXNBwx4ge20jXcuaLwSxHz63gcIM/dcONs8b+nuuU=;
        b=MF36+iDjPNq63i2iSvYJJGdYK5X9AQlDxJKyCCH/uAQurWU2/Pvx1Nr3D1aMrNjIiP
         XSDyTNKCMp0B9KXphGhqmsKFdgRS5lY96JPKS5KzIY7gjHq4/6SWoi5cH8xGJUUY6F1a
         A+AfXcPTtjWOXfZKA2ehkHu8m6MlsDBAQzgvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=oNfeMwYGas6PCXhlbOTlf+4dglaHRDpno4+26UHJiWd0zEO/5IE4aTx1z89uEHvJIe
         xQpdcTDSC/j98As01XTzPOin4vTN6erTc8QdoQJ0rOSoAvYmk3odnNJG45KNKJFyf1t7
         Ghe8kBVbeD3SVbj1Gs9vp/MHMGszAHLKezA5E=
Received: by 10.213.16.131 with SMTP id o3mr4127219eba.29.1290526843900; Tue,
 23 Nov 2010 07:40:43 -0800 (PST)
Received: by 10.213.108.81 with HTTP; Tue, 23 Nov 2010 07:40:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161973>

Hello,

Although smart http worked fine for me out of the box, following "man
git-http-backend", I've found folks on #git for whom it seems to fail
on doing a PROPFIND (found by setting GIT_CURL_VERBOSE=3D1).  Enabling
WebDAV also doesn't seem to help, although that is quite likely to be
some nuance in the Apache config I suppose.

The thing is, I *think* that PROPFIND is not, strictly speaking,
needed when you use the smart HTTP mode.=C2=A0 If that is indeed true, =
can
we stop git from even attempting it, and so avoid the need to setup
WebDAV on Apache?

Would be a great help for many installations.

Thanks,


--
Sitaram
