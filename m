From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: what is the test target of t9400-git-cvsserver-server.sh
Date: Sat, 3 Jul 2010 19:04:34 +0200
Message-ID: <AANLkTimhp_D22jGlfkbJenYpyzLKWN6HqCyHePCOwJ50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 19:05:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV69X-0006O8-QZ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 19:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab0GCRE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 13:04:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54941 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab0GCRE4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 13:04:56 -0400
Received: by fxm14 with SMTP id 14so2944485fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=71T2TVRkFiN/fLbfGEbB/coyF3oKZbGe6TALGZeycRQ=;
        b=Z2vyKNhiTaHtzi/Hmk3fpvIGjzyGzbkKbPJ4kBNZontPbX/fJ5Ur8NvqTcMyTKMT1M
         ZMVpZrPzKSx+w3ALNL3S1AYIZ6d768H7syv6QN/8rfcMl49qd/GR+UIrbAAxEdvGUScb
         EzPfzh9nlqZAEi7XPOmhz/YWx8BiOkZ55o6VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=uG/hLqrpLoaxIcBPbPu4YvQY7DiamFe7YAf2HgtZS8RpsZwXCl+EraDWz4MX0bi0WZ
         28AsMka9gSbaYQ2zZY+uuU+hvC4Cb7009r5jePUzkRSH6Gcv4NFu5B0fUEBHmfE8qQ+q
         q5Fg81oH+bH6DtkciblaMaH4OADW4d06P6e5c=
Received: by 10.103.138.14 with SMTP id q14mr44455mun.119.1278176694138; Sat, 
	03 Jul 2010 10:04:54 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 10:04:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150194>

Hi,

t9400-git-cvsserver-server.sh refers to git-cvsserver as CVS_SERVER
for the cvs client:
CVS_SERVER=3Dgit-cvsserver

What is the goal of this test? To test the git-cvsserver executable
found in the system (in $PATH), or the one bundled in the git source
distribution? I would think that unit tests are to be run before make
install, so it should test the latter. I have a patch already to fix
that and I will post it in case I am right.

Regards,
L=E1szl=F3 =C1SHIN
