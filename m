From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git push failing, unpacker error
Date: Fri, 9 Nov 2007 00:55:57 -0500
Message-ID: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 06:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqMrE-0003mt-IJ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 06:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXKIF40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 00:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbXKIF40
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 00:56:26 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:44829 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXKIF4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 00:56:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so495025wah
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 21:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ThNqdFSyV8UWWk7v/YG/G5lDc4eznKQgchYIBVqyLvg=;
        b=KxkJPf1qoXS8YL76CC20tsDb5pV9sho9r/3j6ij2HhAJiTodaRXDkbJLkqRFP1pG8R4P+WV05jpWMH2vDQ04KYEE7C+hSmI1xoAyJ7EAalFJE8/Dlcj0NgkIrFUvjvkmHSgckfgCdlM54imAc6mbJ1klMyRk5kW/IA/B/dk3pqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YgBTE/Yk5B7xPOSJFkmkTDcMEj+UMLNDUNn/emsYcwT9qExLBfiZXlscTaBfGBDqn/UbzwTx61eAxLmwwfL/CPrwVOQ4agcsP2IXlp500gAbcjswsEoW7QMyiL7QxJqSEcvsRd5Qqo3ujMdDAWduE8VUDULHPJnXPLqehW4gZI0=
Received: by 10.114.194.1 with SMTP id r1mr181533waf.1194587784841;
        Thu, 08 Nov 2007 21:56:24 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Thu, 8 Nov 2007 21:55:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64130>

Why is this push failing?

jonsmirl@terra:~/mpc5200b$ git push dreamhost
updating 'refs/remotes/linus/m24' using 'refs/heads/m24'
  from 0000000000000000000000000000000000000000
  to   06c52341cc9265b23e2d11eb631ff45e763215c0
updating 'refs/remotes/linus/m25' using 'refs/heads/m25'
  from 0000000000000000000000000000000000000000
  to   bef47d2064dd1a848597246291ef8a7654387dde
updating 'refs/remotes/linus/m26' using 'refs/heads/m26'
  from 0000000000000000000000000000000000000000
  to   35200c360d85fb74da55e57dfb16cb9d50b253e9
updating 'refs/remotes/linus/m28' using 'refs/heads/m28'
  from 0000000000000000000000000000000000000000
  to   a77cec0752aa8a00b95a44d1028d5f9b989354a4
updating 'refs/remotes/linus/m29' using 'refs/heads/m29'
  from 0000000000000000000000000000000000000000
  to   0c4bfa1cbed0070e5d0cc739ab0ac4c04290b8d3
Counting objects: 81156, done.
Compressing objects: 100% (16575/16575), done.
Writing objects: 100% (70133/70133), done.
Total 70133 (delta 57185), reused 66194 (delta 53490)
unpack index-pack abnormal exit
ng refs/remotes/linus/m24 n/a (unpacker error)
ng refs/remotes/linus/m25 n/a (unpacker error)
ng refs/remotes/linus/m26 n/a (unpacker error)
ng refs/remotes/linus/m28 n/a (unpacker error)
ng refs/remotes/linus/m29 n/a (unpacker error)
error: failed to push to 'ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git'
jonsmirl@terra:~/mpc5200b$



-- 
Jon Smirl
jonsmirl@gmail.com
