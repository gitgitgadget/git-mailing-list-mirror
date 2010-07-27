From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Git-svn & 502 Bad Gateway
Date: Tue, 27 Jul 2010 11:35:33 -0700
Message-ID: <AANLkTimkrurvkL-Co=HOq4osmyu7K43Ky=-v_LwyKabZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:35:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odp09-0003yq-P3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0G0Sff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 14:35:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42637 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab0G0Sff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:35:35 -0400
Received: by wyf19 with SMTP id 19so3369405wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=qqvyNfuSw/jprgX3FumNCzY/54nkYx5bqNV8ujHXzRw=;
        b=uvA57QQyGuPUW5QWZ26wfExRhESEDuogWR7TnmZ2sEYmqjnT4v+V9i2WFi7T5jfZbe
         QCpsbtSQoTkwNwkXkvQrpl6qlDrQHtOrVC4rqkwV6P0gAMVGBK4yJg2gHM6vU9wYPYMH
         ILIo3mjOSZaFZv9ZuxzGZv2bYdoQ3Nl1vqZHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xOcspRmN4k1RwJwTfxKERAUo4DdMMeL8Ol7n1U6Zvkxe90wGggVpExGBg7MN1V0Uqz
         RUt7D/m352qlDuadZNpQ3mRVRgp2+GqiIr0vCzzF4TDHEj0hpcSn1jfJFwEvg867WnmN
         vWx5OLf6B9MFTAmOSm/HxvNDeN4ZS+4GXND4U=
Received: by 10.216.178.80 with SMTP id e58mr9043687wem.108.1280255733467; 
	Tue, 27 Jul 2010 11:35:33 -0700 (PDT)
Received: by 10.216.179.14 with HTTP; Tue, 27 Jul 2010 11:35:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151969>

I am trying to use git-svn to download an Subversion repository. I did
the "git svn -s init http://..." thing and then ran "git svn fetch".
Everything seems to be working nicely.

Every now and then, however, I get

RA layer request failed: Server sent unexpected return value (502 Bad
Gateway) in response to REPORT request for '/svn/!svn/vcc/default' at
/usr/libexec/git-core/git-svn line 5091

which kills the running "git svn fetch".

I then simply run "git svn fetch" again and git-svn seems to pick up
where it left off. Is that indeed the case? Or should I do some clean
up first?

Cheers,
Hilco
