From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] Documentation/notes: fill out the man page a little
Date: Mon, 3 May 2010 18:36:05 -0500
Message-ID: <20100503233604.GA27451@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 01:36:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95BB-0001v2-PM
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148Ab0ECXf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 19:35:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57548 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab0ECXfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:35:54 -0400
Received: by gyg13 with SMTP id 13so1463210gyg.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wQfBK1cw+UK3tG/0UNmUwSaqlpEeRy5l3PtBAkTQk9o=;
        b=YzQ0imZiuKbdsj4OV8R89ShnGm9ugwo85wmNQBuySbgeLhAyRunzyuebAT2xhZp81+
         i/H3dTjhtmNnlA4IQQUY46exEQolWrvlrIZV50hwqpyqwHos3VxRTa5YBwk3UOQCPSMc
         gFuHK0bcPkp/1flTXBRV5SADMQN6wKUvYpKgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=et8ajSKYrChyxKIqt5cG+gt+J+n+Y9N5c8Xpd1nRqOz4bI92XKe8+XvtCc6TXNAiLo
         m3fMMq1Jnk1YrlSlea2xCRXGG8lrnNT4MtT4SzQ6szDovnpw9a23GfX1hPfK80G70Hzx
         CiS4QlhB5i0reDuu30utDrP4kLdkYoG0WvIkA=
Received: by 10.150.47.33 with SMTP id u33mr10439820ybu.49.1272929754239;
        Mon, 03 May 2010 16:35:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm219378iwn.8.2010.05.03.16.35.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 16:35:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146269>

I decided it=E2=80=99s time I learn to use notes.  Here=E2=80=99s a by-=
product.

Thoughts?
Jonathan Nieder (4):
  Documentation/notes: describe effect of environment and configuration
  Documentation/notes: adjust description to use configuration section
  Documentation/notes: describe content of notes
  Documentation/notes: nitpicks

 Documentation/git-notes.txt |  114 +++++++++++++++++++++++++++++++++++=
++------
 1 files changed, 99 insertions(+), 15 deletions(-)
