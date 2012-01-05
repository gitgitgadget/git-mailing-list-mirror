From: Bruno Bigras <bigras.bruno@gmail.com>
Subject: 'fatal: Out of memory? mmap failed: No such device' using cifs
Date: Thu, 5 Jan 2012 10:44:01 -0500
Message-ID: <CAJwt-JmUVtjTBQf84DoR0y1FHsPbULioXqoJ+J6PHHouoV-n-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 16:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RipU9-0004zR-6C
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 16:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab2AEPoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 10:44:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39232 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab2AEPoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 10:44:03 -0500
Received: by wgbdr13 with SMTP id dr13so769348wgb.1
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3VHk5JdZzmmM4299FV/q69HAzq4nZR7G353BgJkylg8=;
        b=D2grovHp7APRMuv1Zcx40vCnD8n7Gc1Q4EXChIUJtaQculQQK05UF2Yc5YcjjthR1w
         nUJt20r1zEX5XrbRulIdy9marqJU1mPB50tThfUFkOQ3KD3hf3lpdafHah6nQ8DX90zx
         2N61f8CbeeaCczTfcAkdbCYqW+9CgsAcNg/CQ=
Received: by 10.180.80.164 with SMTP id s4mr4999627wix.7.1325778241433; Thu,
 05 Jan 2012 07:44:01 -0800 (PST)
Received: by 10.216.5.10 with HTTP; Thu, 5 Jan 2012 07:44:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187983>

Hi,

I got : 'fatal: Out of memory? mmap failed: No such device' when doing
'git init' in a directory on a mounted cifs share. Any ideas?

I'm using cifs with autofs, here's what I use :
win1
-fstype=smbfs,rw,credentials=/etc/smb.auth,gid=admin,file_mode=0777,dir_mode=0777,nocase,directio,sfu,iocharset=utf8
        ://10.1.1.8/DATA/

git version 1.7.8.2
2.6.32-37-generic-pae

$ mount
//10.1.1.8/DATA/ on /net/smb/win1 type cifs (rw,mand)

Thanks,

Bruno
